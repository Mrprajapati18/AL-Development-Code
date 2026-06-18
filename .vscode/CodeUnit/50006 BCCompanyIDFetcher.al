
codeunit 50006 "BC Company ID Fetcher"
{
    procedure FetchSourceCompanyIDs(var Setup: Record "BC Transfer Setup")
    begin
        ValidateCredentials(
            Setup."Source Tenant ID",
            Setup."Source Client ID",
            Setup."Source Client Secret",
            Setup."Source Environment Name",
            'Source'
        );
        FetchAndDisplay(
            Setup."Source Tenant ID",
            Setup."Source Client ID",
            Setup."Source Client Secret",
            Setup."Source Environment Name",
            'Source'
        );
    end;

    procedure FetchTargetCompanyIDs(var Setup: Record "BC Transfer Setup")
    begin
        ValidateCredentials(
            Setup."Target Tenant ID",
            Setup."Target Client ID",
            Setup."Target Client Secret",
            Setup."Target Environment Name",
            'Target'
        );
        FetchAndDisplay(
            Setup."Target Tenant ID",
            Setup."Target Client ID",
            Setup."Target Client Secret",
            Setup."Target Environment Name",
            'Target'
        );
    end;

    local procedure FetchAndDisplay(
        TenantId: Text;
        ClientId: Text;
        ClientSecret: Text;
        EnvironmentName: Text;
        EnvLabel: Text
    )
    var
        OAuthMgr: Codeunit "BC OAuth Manager";
        APIHelper: Codeunit "BC API Helper";
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        Headers: HttpHeaders;
        AccessToken: Text;
        CompaniesUrl: Text;
        ResponseText: Text;
        JsonObj: JsonObject;
        JsonToken: JsonToken;
        ValueArray: JsonArray;
        CompanyToken: JsonToken;
        CompanyObj: JsonObject;
        IdToken: JsonToken;
        NameToken: JsonToken;
        CompanyList: Text;
        i: Integer;
        CompanyId: Text;
        CompanyName: Text;
    begin
        // Get token for this environment
        if EnvLabel = 'Source' then
            AccessToken := OAuthMgr.GetSourceToken(TenantId, ClientId, ClientSecret)
        else
            AccessToken := OAuthMgr.GetTargetToken(TenantId, ClientId, ClientSecret);

        // Build /companies URL
        CompaniesUrl := APIHelper.BuildBaseUrl(TenantId, EnvironmentName) + 'companies';

        // Execute GET /companies
        HttpRequest.SetRequestUri(CompaniesUrl);
        HttpRequest.Method := 'GET';
        HttpRequest.GetHeaders(Headers);
        Headers.Add('Authorization', 'Bearer ' + AccessToken);
        Headers.Add('Accept', 'application/json');

        if not HttpClient.Send(HttpRequest, HttpResponse) then
            Error('[%1] Failed to connect. Check network and environment name.', EnvLabel);

        HttpResponse.Content().ReadAs(ResponseText);

        if not HttpResponse.IsSuccessStatusCode() then
            Error('[%1] API Error (HTTP %2): %3', EnvLabel, HttpResponse.HttpStatusCode(), ResponseText);

        if not JsonObj.ReadFrom(ResponseText) then
            Error('[%1] Failed to parse API response.', EnvLabel);

        if not JsonObj.Get('value', JsonToken) then
            Error('[%1] "value" property not found in response.', EnvLabel);

        // Build display list
        ValueArray := JsonToken.AsArray();
        CompanyList := StrSubstNo('[%1] Available Companies — Environment: %2\n\n', EnvLabel, EnvironmentName);
        CompanyList += 'COMPANY NAME AND COMPANY ID (GUID)\n';
        CompanyList += '\n';

        for i := 0 to ValueArray.Count() - 1 do begin
            ValueArray.Get(i, CompanyToken);
            CompanyObj := CompanyToken.AsObject();

            CompanyId := '';
            CompanyName := '';

            if CompanyObj.Get('id', IdToken) then
                CompanyId := IdToken.AsValue().AsText();
            if CompanyObj.Get('name', NameToken) then
                CompanyName := NameToken.AsValue().AsText();

            CompanyList += PadStr(CompanyName, 27) + ' | ' + CompanyId + '\n';
        end;

        CompanyList += StrSubstNo(
            '\nCopy the correct Company ID and paste it into the "%1 Company ID" field on the Setup page.',
            EnvLabel
        );

        Message(CompanyList);
    end;

    local procedure ValidateCredentials(
        TenantId: Text;
        ClientId: Text;
        ClientSecret: Text;
        EnvironmentName: Text;
        EnvLabel: Text
    )
    begin
        if TenantId = '' then
            Error('[%1] Tenant ID is empty. Fill in the Setup page first.', EnvLabel);
        if ClientId = '' then
            Error('[%1] Client ID is empty. Fill in the Setup page first.', EnvLabel);
        if ClientSecret = '' then
            Error('[%1] Client Secret is empty. Fill in the Setup page first.', EnvLabel);
        if EnvironmentName = '' then
            Error('[%1] Environment Name is empty. Fill in the Setup page first.', EnvLabel);
    end;
}
