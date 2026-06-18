
codeunit 50005 "BC API Helper"
{
    procedure BuildBaseUrl(TenantId: Text; EnvironmentName: Text): Text
    begin
        exit(StrSubstNo('https://api.businesscentral.dynamics.com/v2.0/%1/%2/api/v2.0/',TenantId,EnvironmentName));
    end;
    procedure GetAllRecords(
        AccessToken: Text;
        Url: Text;
        var ResultArray: JsonArray
    ): Boolean
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        Headers: HttpHeaders;
        ResponseText: Text;
        JsonObj: JsonObject;
        JsonToken: JsonToken;
        ValueArray: JsonArray;
        NextLink: Text;
        i: Integer;
        RecordToken: JsonToken;
    begin
        NextLink := Url;
        while NextLink <> '' do begin
            Clear(HttpRequest);
            HttpRequest.SetRequestUri(NextLink);
            HttpRequest.Method := 'GET';
            HttpRequest.GetHeaders(Headers);
            Headers.Add('Authorization', 'Bearer ' + AccessToken);
            Headers.Add('Accept', 'application/json');

            if not HttpClient.Send(HttpRequest, HttpResponse) then
                Error('GET request failed. URL: %1', NextLink);

            HttpResponse.Content().ReadAs(ResponseText);

            if not HttpResponse.IsSuccessStatusCode() then
                Error('GET Error (HTTP %1)\nURL: %2\nResponse: %3',
                    HttpResponse.HttpStatusCode(), NextLink, ResponseText);

            if not JsonObj.ReadFrom(ResponseText) then
                Error('Failed to parse response from: %1', NextLink);

            if JsonObj.Get('value', JsonToken) then begin
                ValueArray := JsonToken.AsArray();
                for i := 0 to ValueArray.Count() - 1 do begin
                    ValueArray.Get(i, RecordToken);
                    ResultArray.Add(RecordToken);
                end;
            end;

            NextLink := '';
            if JsonObj.Get('@odata.nextLink', JsonToken) then
                NextLink := JsonToken.AsValue().AsText();
        end;

        exit(true);
    end;

    procedure PostRecord(
        AccessToken: Text;
        Url: Text;
        RequestBody: Text;
        var ResponseText: Text
    ): Integer
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        ReqHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
    begin
        HttpRequest.SetRequestUri(Url);
        HttpRequest.Method := 'POST';

        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');

        HttpRequest.Content := HttpContent;
        HttpRequest.GetHeaders(ReqHeaders);
        ReqHeaders.Add('Authorization', 'Bearer ' + AccessToken);
        ReqHeaders.Add('Accept', 'application/json');

        if not HttpClient.Send(HttpRequest, HttpResponse) then begin
            ResponseText := 'Network error: POST request failed.';
            exit(0);
        end;

        HttpResponse.Content().ReadAs(ResponseText);
        exit(HttpResponse.HttpStatusCode());
    end;
    
    procedure PatchRecord(
        AccessToken: Text;
        Url: Text;
        RecordId: Text;
        ETag: Text;
        RequestBody: Text;
        var ResponseText: Text
    ): Integer
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        HttpContent: HttpContent;
        ReqHeaders: HttpHeaders;
        ContentHeaders: HttpHeaders;
        PatchUrl: Text;
    begin
        PatchUrl := Url + '(' + RecordId + ')';

        HttpRequest.SetRequestUri(PatchUrl);
        HttpRequest.Method := 'PATCH';

        HttpContent.WriteFrom(RequestBody);
        HttpContent.GetHeaders(ContentHeaders);
        if ContentHeaders.Contains('Content-Type') then
            ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');

        HttpRequest.Content := HttpContent;
        HttpRequest.GetHeaders(ReqHeaders);
        ReqHeaders.Add('Authorization', 'Bearer ' + AccessToken);
        ReqHeaders.Add('Accept', 'application/json');
        if ETag <> '' then
            ReqHeaders.Add('If-Match', ETag);

        if not HttpClient.Send(HttpRequest, HttpResponse) then begin
            ResponseText := 'Network error: PATCH request failed.';
            exit(0);
        end;

        HttpResponse.Content().ReadAs(ResponseText);
        exit(HttpResponse.HttpStatusCode());
    end;

    procedure CheckRecordExists(AccessToken: Text;Url: Text;FilterField: Text;FilterValue: Text;var ExistingId: Text;
        var ExistingETag: Text
    ): Boolean
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpResponse: HttpResponseMessage;
        Headers: HttpHeaders;
        ResponseText: Text;
        FilterUrl: Text;
        JsonObj: JsonObject;
        JsonToken: JsonToken;
        ValueArray: JsonArray;
        RecordToken: JsonToken;
        RecordObj: JsonObject;
        IdToken: JsonToken;
        ETagToken: JsonToken;
    begin
        FilterUrl := Url + '?$filter=' + FilterField + ' eq ''' + FilterValue + '''&$top=1';

        HttpRequest.SetRequestUri(FilterUrl);
        HttpRequest.Method := 'GET';
        HttpRequest.GetHeaders(Headers);
        Headers.Add('Authorization', 'Bearer ' + AccessToken);
        Headers.Add('Accept', 'application/json');

        if not HttpClient.Send(HttpRequest, HttpResponse) then
            exit(false);

        HttpResponse.Content().ReadAs(ResponseText);

        if not HttpResponse.IsSuccessStatusCode() then
            exit(false);

        if not JsonObj.ReadFrom(ResponseText) then
            exit(false);

        if not JsonObj.Get('value', JsonToken) then
            exit(false);

        ValueArray := JsonToken.AsArray();
        if ValueArray.Count() = 0 then
            exit(false);

        ValueArray.Get(0, RecordToken);
        RecordObj := RecordToken.AsObject();

        if RecordObj.Get('id', IdToken) then
            ExistingId := IdToken.AsValue().AsText();
        if RecordObj.Get('@odata.etag', ETagToken) then
            ExistingETag := ETagToken.AsValue().AsText();

        exit(ExistingId <> '');
    end;
}
