
codeunit 50007 "BC Data Transfer Mgt"
{
    var
        Setup: Record "BC Transfer Setup";
        OAuthMgr: Codeunit "BC OAuth Manager";
        APIHelper: Codeunit "BC API Helper";

        // Separate tokens for each environment
        SourceToken: Text;
        TargetToken: Text;

        // Separate base URLs for each environment
        SourceCompanyUrl: Text;
        TargetCompanyUrl: Text;

        // Transfer result counters
        TotalSuccess: Integer;
        TotalSkipped: Integer;
        TotalError: Integer;


    procedure RunTransfer()
    var
        ProgressDialog: Dialog;
        SummaryMsg: Text;
    begin
        Setup.GetSetup(Setup);
        ValidateSetup();
        ProgressDialog.Open('Connecting to environments...\' + '');

        ProgressDialog.Update(1, 'Acquiring Source environment token...');
        SourceToken := OAuthMgr.GetSourceToken(
            Setup."Source Tenant ID",
            Setup."Source Client ID",
            Setup."Source Client Secret"
        );

        ProgressDialog.Update(1, 'Acquiring Target environment token...');
        TargetToken := OAuthMgr.GetTargetToken(
            Setup."Target Tenant ID",
            Setup."Target Client ID",
            Setup."Target Client Secret"
        );

        SourceCompanyUrl :=
            APIHelper.BuildBaseUrl(Setup."Source Tenant ID", Setup."Source Environment Name") +
            StrSubstNo('companies(%1)/', Setup."Source Company ID");

        TargetCompanyUrl :=
            APIHelper.BuildBaseUrl(Setup."Target Tenant ID", Setup."Target Environment Name") +
            StrSubstNo('companies(%1)/', Setup."Target Company ID");

        // Reset counters
        TotalSuccess := 0;
        TotalSkipped := 0;
        TotalError := 0;

        // Transfer selected record types
        if Setup."Transfer Customers" then begin
            ProgressDialog.Update(1, 'Transferring Customers...');
            TransferCustomers();
        end;

        if Setup."Transfer Vendors" then begin
            ProgressDialog.Update(1, 'Transferring Vendors...');
            TransferVendors();
        end;

        if Setup."Transfer Items" then begin
            ProgressDialog.Update(1, 'Transferring Items...');
            TransferItems();
        end;

        ProgressDialog.Close();

        // Save last run summary
        Setup."Last Transfer DateTime" := CurrentDateTime();
        Setup."Last Transfer Status" := StrSubstNo(
            'Success: %1 | Skipped: %2 | Error: %3',
            TotalSuccess, TotalSkipped, TotalError
        );
        Setup.Modify(true);

        // Display summary
        SummaryMsg := StrSubstNo(
            'Transfer Complete!\n\n' +
            'Source : %1 (%2)\n' +
            'Target : %3 (%4)\n\n' +
            'Successful : %5\n' +
            'Skipped    : %6\n' +
            'Errors     : %7\n\n' +
            'Check the Transfer Log for full details.',
            Setup."Source Company Name", Setup."Source Environment Name",
            Setup."Target Company Name", Setup."Target Environment Name",
            TotalSuccess, TotalSkipped, TotalError
        );
        Message(SummaryMsg);
    end;

    local procedure TransferCustomers()
    var
        SourceUrl: Text;
        TargetUrl: Text;
        AllCustomers: JsonArray;
        CustomerToken: JsonToken;
        CustomerObj: JsonObject;
        i: Integer;
    begin
        SourceUrl := SourceCompanyUrl + 'customers';
        TargetUrl := TargetCompanyUrl + 'customers';

        // Use SourceToken to fetch from the source environment
        APIHelper.GetAllRecords(SourceToken, SourceUrl, AllCustomers);

        for i := 0 to AllCustomers.Count() - 1 do begin
            AllCustomers.Get(i, CustomerToken);
            CustomerObj := CustomerToken.AsObject();
            ProcessCustomer(CustomerObj, TargetUrl);
        end;
    end;

    local procedure ProcessCustomer(SourceObj: JsonObject; TargetUrl: Text)
    var
        Number: Text;
        Name: Text;
        ExistingId: Text;
        ExistingETag: Text;
        RequestBody: Text;
        ResponseText: Text;
        StatusCode: Integer;
        ActionTaken: Text;
        JsonToken: JsonToken;
    begin
        if SourceObj.Get('number', JsonToken) then
            Number := JsonToken.AsValue().AsText();
        if SourceObj.Get('displayName', JsonToken) then
            Name := JsonToken.AsValue().AsText();

        // Use TargetToken to check existence in the target environment
        if APIHelper.CheckRecordExists(TargetToken, TargetUrl, 'number', Number, ExistingId, ExistingETag) then begin
            if Setup."Skip Existing Records" then begin
                WriteLog("BC Transfer Record Type"::Customer, Number, Name,
                    "BC Transfer Status"::Skipped, '', 0, 'Skipped');
                TotalSkipped += 1;
                exit;
            end;
            RequestBody := BuildCustomerJson(SourceObj);
            // Use TargetToken for the PATCH call
            StatusCode := APIHelper.PatchRecord(TargetToken, TargetUrl, ExistingId, ExistingETag, RequestBody, ResponseText);
            ActionTaken := 'Updated';
        end else begin
            RequestBody := BuildCustomerJson(SourceObj);
            // Use TargetToken for the POST call
            StatusCode := APIHelper.PostRecord(TargetToken, TargetUrl, RequestBody, ResponseText);
            ActionTaken := 'Created';
        end;

        if StatusCode in [200, 201, 204] then begin
            WriteLog("BC Transfer Record Type"::Customer, Number, Name,
                "BC Transfer Status"::Success, '', StatusCode, ActionTaken);
            TotalSuccess += 1;
        end else begin
            WriteLog("BC Transfer Record Type"::Customer, Number, Name,
                "BC Transfer Status"::Error, ResponseText, StatusCode, ActionTaken);
            TotalError += 1;
        end;
    end;

    local procedure BuildCustomerJson(SourceObj: JsonObject): Text
    var
        TargetObj: JsonObject;
        JsonToken: JsonToken;
        Result: Text;
    begin
        AddJsonText(TargetObj, SourceObj, 'number', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'displayName', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'type', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'addressLine1', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'addressLine2', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'city', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'state', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'postalCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'country', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'phoneNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'email', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'website', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'taxRegistrationNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'currencyCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'paymentTermsId', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'paymentMethodId', JsonToken);
        AddJsonBool(TargetObj, SourceObj, 'blocked', JsonToken);
        AddJsonDecimal(TargetObj, SourceObj, 'creditLimit', JsonToken);
        TargetObj.WriteTo(Result);
        exit(Result);
    end;
    // TransferVendors
    local procedure TransferVendors()
    var
        SourceUrl: Text;
        TargetUrl: Text;
        AllVendors: JsonArray;
        VendorToken: JsonToken;
        VendorObj: JsonObject;
        i: Integer;
    begin
        SourceUrl := SourceCompanyUrl + 'vendors';
        TargetUrl := TargetCompanyUrl + 'vendors';

        APIHelper.GetAllRecords(SourceToken, SourceUrl, AllVendors);

        for i := 0 to AllVendors.Count() - 1 do begin
            AllVendors.Get(i, VendorToken);
            VendorObj := VendorToken.AsObject();
            ProcessVendor(VendorObj, TargetUrl);
        end;
    end;

    local procedure ProcessVendor(SourceObj: JsonObject; TargetUrl: Text)
    var
        Number: Text;
        Name: Text;
        ExistingId: Text;
        ExistingETag: Text;
        RequestBody: Text;
        ResponseText: Text;
        StatusCode: Integer;
        ActionTaken: Text;
        JsonToken: JsonToken;
    begin
        if SourceObj.Get('number', JsonToken) then
            Number := JsonToken.AsValue().AsText();
        if SourceObj.Get('displayName', JsonToken) then
            Name := JsonToken.AsValue().AsText();

        if APIHelper.CheckRecordExists(TargetToken, TargetUrl, 'number', Number, ExistingId, ExistingETag) then begin
            if Setup."Skip Existing Records" then begin
                WriteLog("BC Transfer Record Type"::Vendor, Number, Name,
                    "BC Transfer Status"::Skipped, '', 0, 'Skipped');
                TotalSkipped += 1;
                exit;
            end;
            RequestBody := BuildVendorJson(SourceObj);
            StatusCode := APIHelper.PatchRecord(TargetToken, TargetUrl, ExistingId, ExistingETag, RequestBody, ResponseText);
            ActionTaken := 'Updated';
        end else begin
            RequestBody := BuildVendorJson(SourceObj);
            StatusCode := APIHelper.PostRecord(TargetToken, TargetUrl, RequestBody, ResponseText);
            ActionTaken := 'Created';
        end;

        if StatusCode in [200, 201, 204] then begin
            WriteLog("BC Transfer Record Type"::Vendor, Number, Name,
                "BC Transfer Status"::Success, '', StatusCode, ActionTaken);
            TotalSuccess += 1;
        end else begin
            WriteLog("BC Transfer Record Type"::Vendor, Number, Name,
                "BC Transfer Status"::Error, ResponseText, StatusCode, ActionTaken);
            TotalError += 1;
        end;
    end;

    local procedure BuildVendorJson(SourceObj: JsonObject): Text
    var
        TargetObj: JsonObject;
        JsonToken: JsonToken;
        Result: Text;
    begin
        AddJsonText(TargetObj, SourceObj, 'number', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'displayName', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'addressLine1', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'addressLine2', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'city', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'state', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'postalCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'country', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'phoneNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'email', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'website', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'taxRegistrationNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'currencyCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'paymentTermsId', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'paymentMethodId', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'iban', JsonToken);
        AddJsonBool(TargetObj, SourceObj, 'blocked', JsonToken);
        TargetObj.WriteTo(Result);
        exit(Result);
    end;

    // TransferItems
    local procedure TransferItems()
    var
        SourceUrl: Text;
        TargetUrl: Text;
        AllItems: JsonArray;
        ItemToken: JsonToken;
        ItemObj: JsonObject;
        i: Integer;
    begin
        SourceUrl := SourceCompanyUrl + 'items';
        TargetUrl := TargetCompanyUrl + 'items';

        APIHelper.GetAllRecords(SourceToken, SourceUrl, AllItems);

        for i := 0 to AllItems.Count() - 1 do begin
            AllItems.Get(i, ItemToken);
            ItemObj := ItemToken.AsObject();
            ProcessItem(ItemObj, TargetUrl);
        end;
    end;

    local procedure ProcessItem(SourceObj: JsonObject; TargetUrl: Text)
    var
        Number: Text;
        Name: Text;
        ExistingId: Text;
        ExistingETag: Text;
        RequestBody: Text;
        ResponseText: Text;
        StatusCode: Integer;
        ActionTaken: Text;
        JsonToken: JsonToken;
    begin
        if SourceObj.Get('number', JsonToken) then
            Number := JsonToken.AsValue().AsText();
        if SourceObj.Get('displayName', JsonToken) then
            Name := JsonToken.AsValue().AsText();

        if APIHelper.CheckRecordExists(TargetToken, TargetUrl, 'number', Number, ExistingId, ExistingETag) then begin
            if Setup."Skip Existing Records" then begin
                WriteLog("BC Transfer Record Type"::Item, Number, Name,
                    "BC Transfer Status"::Skipped, '', 0, 'Skipped');
                TotalSkipped += 1;
                exit;
            end;
            RequestBody := BuildItemJson(SourceObj);
            StatusCode := APIHelper.PatchRecord(TargetToken, TargetUrl, ExistingId, ExistingETag, RequestBody, ResponseText);
            ActionTaken := 'Updated';
        end else begin
            RequestBody := BuildItemJson(SourceObj);
            StatusCode := APIHelper.PostRecord(TargetToken, TargetUrl, RequestBody, ResponseText);
            ActionTaken := 'Created';
        end;

        if StatusCode in [200, 201, 204] then begin
            WriteLog("BC Transfer Record Type"::Item, Number, Name,
                "BC Transfer Status"::Success, '', StatusCode, ActionTaken);
            TotalSuccess += 1;
        end else begin
            WriteLog("BC Transfer Record Type"::Item, Number, Name,
                "BC Transfer Status"::Error, ResponseText, StatusCode, ActionTaken);
            TotalError += 1;
        end;
    end;

    local procedure BuildItemJson(SourceObj: JsonObject): Text
    var
        TargetObj: JsonObject;
        JsonToken: JsonToken;
        Result: Text;
    begin
        AddJsonText(TargetObj, SourceObj, 'number', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'displayName', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'displayName2', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'type', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'itemCategoryCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'baseUnitOfMeasureCode', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'gtin', JsonToken);
        AddJsonDecimal(TargetObj, SourceObj, 'unitPrice', JsonToken);
        AddJsonDecimal(TargetObj, SourceObj, 'unitCost', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'taxGroupCode', JsonToken);
        AddJsonBool(TargetObj, SourceObj, 'blocked', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'vendorNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'vendorItemNumber', JsonToken);
        AddJsonText(TargetObj, SourceObj, 'description', JsonToken);
        TargetObj.WriteTo(Result);
        exit(Result);
    end;

    local procedure AddJsonText(var TargetObj: JsonObject; SourceObj: JsonObject; FieldName: Text; var Token: JsonToken)
    begin
        if SourceObj.Get(FieldName, Token) then
            if not Token.AsValue().IsNull() then
                TargetObj.Add(FieldName, Token.AsValue().AsText());
    end;

    local procedure AddJsonBool(var TargetObj: JsonObject; SourceObj: JsonObject; FieldName: Text; var Token: JsonToken)
    begin
        if SourceObj.Get(FieldName, Token) then
            if not Token.AsValue().IsNull() then
                TargetObj.Add(FieldName, Token.AsValue().AsBoolean());
    end;

    local procedure AddJsonDecimal(var TargetObj: JsonObject; SourceObj: JsonObject; FieldName: Text; var Token: JsonToken)
    begin
        if SourceObj.Get(FieldName, Token) then
            if not Token.AsValue().IsNull() then
                TargetObj.Add(FieldName, Token.AsValue().AsDecimal());
    end;

    local procedure WriteLog(
        RecordType: Enum "BC Transfer Record Type";
        RecordNo: Text;
        RecordName: Text;
        Status: Enum "BC Transfer Status";
        ErrorMsg: Text;
        HttpCode: Integer;
        ActionTaken: Text
    )
    var
        LogEntry: Record "BC Transfer Log";
    begin
        LogEntry.Init();
        LogEntry."Transfer DateTime" := CurrentDateTime();
        LogEntry."Record Type" := RecordType;
        LogEntry."Record No." := CopyStr(RecordNo, 1, MaxStrLen(LogEntry."Record No."));
        LogEntry."Record Name" := CopyStr(RecordName, 1, MaxStrLen(LogEntry."Record Name"));
        LogEntry."Status" := Status;
        LogEntry."Error Message" := CopyStr(ErrorMsg, 1, MaxStrLen(LogEntry."Error Message"));
        LogEntry."Source Environment" := CopyStr(
            Setup."Source Company Name" + ' / ' + Setup."Source Environment Name",
            1, MaxStrLen(LogEntry."Source Environment")
        );
        LogEntry."Target Environment" := CopyStr(
            Setup."Target Company Name" + ' / ' + Setup."Target Environment Name",
            1, MaxStrLen(LogEntry."Target Environment")
        );
        LogEntry."HTTP Status Code" := HttpCode;
        LogEntry."Action Taken" := CopyStr(ActionTaken, 1, MaxStrLen(LogEntry."Action Taken"));
        LogEntry.Insert(true);
    end;

    local procedure ValidateSetup()
    begin
        // Source validation
        if Setup."Source Tenant ID" = '' then
            Error('Source Tenant ID is empty.');
        if Setup."Source Environment Name" = '' then
            Error('Source Environment Name is empty.');
        if Setup."Source Client ID" = '' then
            Error('Source Client ID is empty.');
        if Setup."Source Client Secret" = '' then
            Error('Source Client Secret is empty.');
        if Setup."Source Company ID" = '' then
            Error('Source Company ID is empty. Use "Fetch Source Company IDs".');

        // Target validation
        if Setup."Target Tenant ID" = '' then
            Error('Target Tenant ID is empty.');
        if Setup."Target Environment Name" = '' then
            Error('Target Environment Name is empty.');
        if Setup."Target Client ID" = '' then
            Error('Target Client ID is empty.');
        if Setup."Target Client Secret" = '' then
            Error('Target Client Secret is empty.');
        if Setup."Target Company ID" = '' then
            Error('Target Company ID is empty. Use "Fetch Target Company IDs".');

        if not Setup."Transfer Customers" and
           not Setup."Transfer Vendors" and
           not Setup."Transfer Items"
        then
            Error('No record types selected for transfer. Please enable at least one option.');
    end;
}
