
codeunit 50008 "BC OAuth Manager"
{
    var
        SourceCachedToken: Text;
        SourceTokenExpiry: DateTime;

        // Target token cache
        TargetCachedToken: Text;
        TargetTokenExpiry: DateTime;

    procedure GetSourceToken(TenantId: Text; ClientId: Text; ClientSecret: Text): Text
    begin
        if (SourceCachedToken <> '') and (SourceTokenExpiry > CurrentDateTime()) then
            exit(SourceCachedToken);

        SourceCachedToken := FetchNewToken(TenantId, ClientId, ClientSecret, 'Source');
        SourceTokenExpiry := CurrentDateTime() + 3300000; // 55 minutes
        exit(SourceCachedToken);
    end;

    procedure GetTargetToken(TenantId: Text; ClientId: Text; ClientSecret: Text): Text
    begin
        if (TargetCachedToken <> '') and (TargetTokenExpiry > CurrentDateTime()) then
            exit(TargetCachedToken);

        TargetCachedToken := FetchNewToken(TenantId, ClientId, ClientSecret, 'Target');
        TargetTokenExpiry := CurrentDateTime() + 3300000; // 55 minutes
        exit(TargetCachedToken);
    end;

    local procedure FetchNewToken(TenantId: Text; ClientId: Text; ClientSecret: Text; EnvLabel: Text): Text
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        Headers: HttpHeaders;
        TokenUrl: Text;
        RequestBody: Text;
        ResponseText: Text;
        JsonObj: JsonObject;
        JsonToken: JsonToken;
    begin
        // Azure AD token endpoint
        TokenUrl := StrSubstNo(
            'https://login.microsoftonline.com/%1/oauth2/v2.0/token',
            TenantId
        );

        // Client Credentials grant body
        RequestBody := StrSubstNo(
            'grant_type=client_credentials&client_id=%1&client_secret=%2&scope=https%%3A%%2F%%2Fapi.businesscentral.dynamics.com%%2F.default',
            ClientId,
            ClientSecret
        );

        // Build HTTP POST request
        HttpRequest.SetRequestUri(TokenUrl);
        HttpRequest.Method := 'POST';

        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(Headers);
        if Headers.Contains('Content-Type') then
            Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/x-www-form-urlencoded');
        HttpRequest.Content := HttpContent;

        if not HttpClient.Send(HttpRequest, HttpResponse) then
            Error('[%1] Token request failed. Check network connectivity.', EnvLabel);

        HttpResponse.Content().ReadAs(ResponseText);

        if not HttpResponse.IsSuccessStatusCode() then
            Error('[%1] OAuth Error (HTTP %2): %3', EnvLabel, HttpResponse.HttpStatusCode(), ResponseText);

        if not JsonObj.ReadFrom(ResponseText) then
            Error('[%1] Failed to parse token response: %2', EnvLabel, ResponseText);

        if not JsonObj.Get('access_token', JsonToken) then
            Error('[%1] access_token not found in response: %2', EnvLabel, ResponseText);

        exit(JsonToken.AsValue().AsText());
    end;

    procedure ClearAllCaches()
    begin
        SourceCachedToken := '';
        SourceTokenExpiry := 0DT;
        TargetCachedToken := '';
        TargetTokenExpiry := 0DT;
    end;
}
