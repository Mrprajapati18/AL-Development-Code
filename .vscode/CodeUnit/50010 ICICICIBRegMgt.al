codeunit 50003 "ICICI CIB Reg. Mgt."
{
    procedure RegisterCIBUser(var RegRec: Record "ICICI CIB User Reg.")
    var
        Setup: Record "ICICI CIB Setup";
        PlainReqJson: Text;
        EncryptedPayload: Text;
        ResponseText: Text;
        OStream: OutStream;
    begin
        // Load Setup
        if not Setup.Get('DEFAULT') then
            Error('ICICI CIB Setup not configured.\Open "ICICI CIB Setup" page and fill all fields.');

        ValidateSetup(Setup);
        ValidateRegRecord(RegRec);

        PlainReqJson := BuildPlainRequestJson(Setup, RegRec);

        Clear(RegRec."Raw Request JSON");
        RegRec."Raw Request JSON".CreateOutStream(OStream);
        OStream.WriteText(PlainReqJson);

        EncryptedPayload := EncryptViaAzureFunction(Setup, PlainReqJson);

        ResponseText := CallICICIRegistrationAPI(Setup, EncryptedPayload);

        Clear(RegRec."Raw Response JSON");
        RegRec."Raw Response JSON".CreateOutStream(OStream);
        OStream.WriteText(ResponseText);

        ResponseText := DecryptICICIResponse(Setup, ResponseText);

        RegRec."Registration DateTime" := CurrentDateTime();
        ParseICICIResponse(RegRec, ResponseText);

        RegRec.Modify(true);
    end;

    procedure ValidateSetup(Setup: Record "ICICI CIB Setup")
    begin
        if Setup."AGGR ID" = '' then
            Error('Aggregator ID is missing in ICICI CIB Setup.');
        if Setup."AGGR Name" = '' then
            Error('Aggregator Name is missing in ICICI CIB Setup.');
        if Setup."API Key" = '' then
            Error('API Key is missing in ICICI CIB Setup.');
        if Setup."Azure Function URL" = '' then
            Error('Azure Function URL is missing.\This is required for encryption in BC Cloud (no DotNet allowed).');
        if Setup."ICICI Public Key PEM" = '' then
            Error('ICICI Public Key PEM is missing in ICICI CIB Setup.');
    end;

    local procedure ValidateRegRecord(RegRec: Record "ICICI CIB User Reg.")
    begin
        if RegRec."Corp ID" = '' then
            Error('Corp ID is mandatory.');
        if RegRec."User ID" = '' then
            Error('User ID is mandatory.');
        if RegRec."URN" = '' then
            Error('URN (Unique Reference Number) is mandatory.');
        if StrLen(RegRec."URN") > 40 then
            Error('URN cannot exceed 40 characters. Current length: %1', StrLen(RegRec."URN"));
    end;

    local procedure BuildPlainRequestJson(
        Setup: Record "ICICI CIB Setup";
        RegRec: Record "ICICI CIB User Reg."
    ): Text
    var
        ReqJson: JsonObject;
        JsonText: Text;
    begin
        ReqJson.Add('AGGRNAME', Setup."AGGR Name");
        ReqJson.Add('AGGRID', Setup."AGGR ID");
        ReqJson.Add('CORPID', RegRec."Corp ID");
        ReqJson.Add('USERID', RegRec."User ID");
        ReqJson.Add('URN', RegRec."URN");

        if RegRec."Alias ID" <> '' then
            ReqJson.Add('ALIASID', RegRec."Alias ID")
        else
            ReqJson.Add('ALIASID', '');

        ReqJson.WriteTo(JsonText);
        exit(JsonText);
    end;


    local procedure EncryptViaAzureFunction(
        Setup: Record "ICICI CIB Setup";
        PlainText: Text
    ): Text
    var
        HttpCl: HttpClient;
        HttpReq: HttpRequestMessage;
        HttpResp: HttpResponseMessage;
        HttpCont: HttpContent;
        ContHdrs: HttpHeaders;
        ReqBody: JsonObject;
        ReqBodyText: Text;
        RespText: Text;
    begin
        // Build Azure Function request
        ReqBody.Add('action', 'encrypt');
        ReqBody.Add('plainText', PlainText);
        ReqBody.Add('iciciPubKey', Setup."ICICI Public Key PEM");
        ReqBody.WriteTo(ReqBodyText);

        // Set content
        HttpCont.WriteFrom(ReqBodyText);
        HttpCont.GetHeaders(ContHdrs);
        ContHdrs.Remove('Content-Type');
        ContHdrs.Add('Content-Type', 'application/json');

        // Set request
        HttpReq.SetRequestUri(Setup."Azure Function URL");
        HttpReq.Method := 'POST';
        HttpReq.Content := HttpCont;

        // Send
        if not HttpCl.Send(HttpReq, HttpResp) then
            Error('Cannot reach Azure Function (Encryption Helper).\' +'URL: %1\' +'Check: URL is correct Azure Function is deployed Network accessible.',Setup."Azure Function URL");

        HttpResp.Content.ReadAs(RespText);

        if not HttpResp.IsSuccessStatusCode() then
            Error(
                'Azure Function (Encryption) returned HTTP %1.\' +
                'Response: %2',
                HttpResp.HttpStatusCode(),
                CopyStr(RespText, 1, 500));

        if RespText = '' then
            Error('Azure Function returned empty response for encryption.');

        exit(RespText);
    end;

    local procedure DecryptICICIResponse(
        Setup: Record "ICICI CIB Setup";
        RawResponse: Text
    ): Text
    var
        HttpCl: HttpClient;
        HttpReq: HttpRequestMessage;
        HttpResp: HttpResponseMessage;
        HttpCont: HttpContent;
        ContHdrs: HttpHeaders;
        TestJson: JsonObject;
        ReqBody: JsonObject;
        ReqBodyText: Text;
        RespText: Text;
        RespJson: JsonObject;
        DecryptedTok: JsonToken;
        CheckTok: JsonToken;
        PrivKey: Text;
    begin
       
        if TestJson.ReadFrom(RawResponse) then
            if TestJson.Get('RESPONSE', CheckTok) then
                exit(RawResponse);

        PrivKey := GetClientPrivateKeyFromStorage();

        ReqBody.Add('action', 'decrypt');
        ReqBody.Add('encryptedJson', RawResponse);
        ReqBody.Add('clientPrivateKey', PrivKey);
        ReqBody.WriteTo(ReqBodyText);

        HttpCont.WriteFrom(ReqBodyText);
        HttpCont.GetHeaders(ContHdrs);
        ContHdrs.Remove('Content-Type');
        ContHdrs.Add('Content-Type', 'application/json');

        HttpReq.SetRequestUri(Setup."Azure Function URL");
        HttpReq.Method := 'POST';
        HttpReq.Content := HttpCont;

        if not HttpCl.Send(HttpReq, HttpResp) then
            Error('Cannot reach Azure Function (Decryption Helper).\URL: %1', Setup."Azure Function URL");

        HttpResp.Content.ReadAs(RespText);

        if not HttpResp.IsSuccessStatusCode() then
            Error('Azure Function (Decryption) returned HTTP %1.\Response: %2',
                HttpResp.HttpStatusCode(), CopyStr(RespText, 1, 500));

        if RespJson.ReadFrom(RespText) then
            if RespJson.Get('decryptedText', DecryptedTok) then
                exit(DecryptedTok.AsValue().AsText());

        exit(RespText);
    end;

    local procedure CallICICIRegistrationAPI(
        Setup: Record "ICICI CIB Setup";
        EncryptedPayload: Text
    ): Text
    var
        HttpCl: HttpClient;
        HttpReq: HttpRequestMessage;
        HttpResp: HttpResponseMessage;
        HttpCont: HttpContent;
        ReqHdrs: HttpHeaders;
        ContHdrs: HttpHeaders;
        EndpointUrl: Text;
        RespText: Text;
    begin
        // Select URL
        if Setup."UAT Mode" then
            EndpointUrl :=
                'https://apibankingonesandbox.icici.bank.in/api/Corporate/CIB_SV/v1/Registration'
        else
            EndpointUrl :=
                'https://apibankingone.icici.bank.in/api/Corporate/CIB/v1/Registration';

        // Content
        HttpCont.WriteFrom(EncryptedPayload);
        HttpCont.GetHeaders(ContHdrs);
        ContHdrs.Remove('Content-Type');
        ContHdrs.Add('Content-Type', 'application/json');

        // Request
        HttpReq.SetRequestUri(EndpointUrl);
        HttpReq.Method := 'POST';
        HttpReq.Content := HttpCont;

        // Headers per ICICI spec
        HttpReq.GetHeaders(ReqHdrs);
        ReqHdrs.Add('accept', '*/*');
        ReqHdrs.Add('apikey', Setup."API Key");
        if Setup."Client IP" <> '' then
            ReqHdrs.Add('x-forwarded-for', Setup."Client IP");

        // Send
        if not HttpCl.Send(HttpReq, HttpResp) then
            Error(
                'HTTP call to ICICI Bank failed.\' +
                'Endpoint: %1\' +
                'Possible causes:\' +
                'BC Cloud outbound IP not whitelisted at ICICI Bank.\' +
                'Wrong endpoint URL.\' +
                'Network/firewall issue.',
                EndpointUrl);

        HttpResp.Content.ReadAs(RespText);

        if not HttpResp.IsSuccessStatusCode() then
            Error('ICICI Bank API returned HTTP %1.\Body: %2',
                HttpResp.HttpStatusCode(),
                CopyStr(RespText, 1, 500));

        exit(RespText);
    end;

    local procedure ParseICICIResponse(
        var RegRec: Record "ICICI CIB User Reg.";
        ResponseText: Text
    )
    var
        RespJson: JsonObject;
        Tok: JsonToken;
        Status: Text;
        Msg: Text;
        ErrCode: Text;
    begin
        if ResponseText = '' then
            Error('Empty response received from ICICI Bank.');

        if not RespJson.ReadFrom(ResponseText) then
            Error('ICICI response is not valid JSON.\Raw: %1',
                CopyStr(ResponseText, 1, 500));

        // RESPONSE field 
        if not RespJson.Get('RESPONSE', Tok) then
            Error('RESPONSE field missing in ICICI reply.\Raw: %1',
                CopyStr(ResponseText, 1, 500));
        Status := UpperCase(Tok.AsValue().AsText());

        // MESSAGE
        if RespJson.Get('MESSAGE', Tok) then
            Msg := Tok.AsValue().AsText();

        // ERRORCODE 
        if RespJson.Get('ERRORCODE', Tok) then
            ErrCode := Tok.AsValue().AsText();

        // Store
        RegRec."Response Message" := CopyStr(Msg, 1, MaxStrLen(RegRec."Response Message"));
        RegRec."Error Code" := CopyStr(ErrCode, 1, MaxStrLen(RegRec."Error Code"));

        case Status of
            'SUCCESS':
                begin
                    RegRec."Registration Status" := RegRec."Registration Status"::"Pending Approval";
                    Message(
                        'Registration Sent Successfully!\\' +
                        'Status  : Pending Self-Approval\\' +
                        'Message : %1\\' +
                        '\\' +
                        'NEXT STEP - Login to CIB Portal:\\' +
                        'Connected Banking → Approvals → Pending Approvals\\' +
                        'Click and approve the pending request.',
                        Msg);
                end;
            'FAILURE':
                begin
                    RegRec."Registration Status" := RegRec."Registration Status"::Failure;
                    Error(
                        'ICICI CIB Registration FAILED!\\' +
                        'Error Code : %1\\' +
                        'Message    : %2',
                        ErrCode, Msg);
                end;
            else
                Error('Unknown RESPONSE value "%1" from ICICI.\Message: %2', Status, Msg);
        end;
    end;

    local procedure GetClientPrivateKeyFromStorage(): Text
    var
        PrivKey: Text;
    begin
        if IsolatedStorage.Contains('ICICI_CLIENT_PRIVKEY', DataScope::Company) then begin
            IsolatedStorage.Get('ICICI_CLIENT_PRIVKEY', DataScope::Company, PrivKey);
            exit(PrivKey);
        end;
        exit('');
    end;

    procedure SetClientPrivateKey(PrivKeyBase64: Text)
    begin
        if PrivKeyBase64 = '' then
            Error('Private key value cannot be empty.');
        IsolatedStorage.Set('ICICI_CLIENT_PRIVKEY', PrivKeyBase64, DataScope::Company);
    end;

    procedure ClearClientPrivateKey()
    begin
        if IsolatedStorage.Contains('ICICI_CLIENT_PRIVKEY', DataScope::Company) then
            IsolatedStorage.Delete('ICICI_CLIENT_PRIVKEY', DataScope::Company);
    end;

    procedure HasClientPrivateKey(): Boolean
    begin
        exit(IsolatedStorage.Contains('ICICI_CLIENT_PRIVKEY', DataScope::Company));
    end;
}