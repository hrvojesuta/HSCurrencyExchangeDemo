namespace EX;
using Microsoft.Finance.Currency;

codeunit 70300 "EX Sync Management"
{
    procedure RunFxSync(Silent: Boolean)
    var
        Setup: Record "EX Sync Setup";
        Response: HttpResponseMessage;
        Content: Text;
        Json: JsonObject;
        RatesToken: JsonToken;
        RatesObj: JsonObject;
        RateToken: JsonToken;
        CurrencyCodeTxt: Text;
        CurrencyCode: Code[10];
        RateValue: Decimal;
        Updated: Integer;
        CurrenciesArr: List of [Text];
        APIUrl: Text;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        JsonText: Text;
        ResponseHttpResponseMessage: HttpResponseMessage;
        HttpContent: HttpContent;
        httpContentText: Text;
        errorMessageConcatened: Text;
        Method: Text;
    begin
        if not Setup.Get('SETUP') then
            exit;

        if not Setup.Enabled then
            exit;

        Updated := 0;
        CurrenciesArr := SplitCurrencies(Setup."Currencies To Sync");
        ApiUrl := StrSubstNo(Setup."API URL", Setup."Base Currency", Setup."Currencies To Sync");


        Method := 'GET';
        HttpContent.WriteFrom(httpContentText);
        HttpContent.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');

        HttpRequestMessage.Content := HttpContent;
        HttpRequestMessage.SetRequestUri(ApiUrl);
        HttpRequestMessage.Method := Method;

        HttpClient.Send(HttpRequestMessage, ResponseHttpResponseMessage);



        if not HttpResponseMessage.IsSuccessStatusCode() then begin
            errorMessageConcatened := Format(HttpResponseMessage.HttpStatusCode()) + HttpResponseMessage.ReasonPhrase();
            Error(errorMessageConcatened);
        end;

        ResponseHttpResponseMessage.Content().ReadAs(JsonText);
        Response.Content.ReadAs(Content);

        if not Json.ReadFrom(Content) then begin
            InsertLog('Invalid JSON response from API.', false, 0);
            exit;
        end;
        if not Json.Get('rates', RatesToken) then begin
            InsertLog('"rates" not found in API response.', false, 0);
            exit;
        end;

        RatesObj := RatesToken.AsObject();
        foreach CurrencyCodeTxt in CurrenciesArr do
            if RatesObj.Get(CurrencyCodeTxt, RateToken) then begin
                RateValue := RateToken.AsValue().AsDecimal();
                CurrencyCode := CopyStr(CurrencyCodeTxt, 1, MaxStrLen(CurrencyCode));
                ApplyRate(CurrencyCode, RateValue);
                Updated += 1;
            end;

        InsertLog('FX sync completed successfully.', true, Updated);

        if not Silent then
            Message('FX Sync completed. %1 currencies updated.', Updated);
    end;

    local procedure SplitCurrencies(Value: Text): List of [Text]
    var
        Arr: List of [Text];
        Part: Text;
    begin
        foreach Part in Value.Split(',') do
            Arr.Add((Part.Trim()));
        exit(Arr);
    end;

    local procedure ApplyRate(CurrencyCode: Code[10]; RateValue: Decimal)
    var
        CurrRate: Record "Currency Exchange Rate";
    begin
        CurrRate.Reset();
        CurrRate.SetRange("Currency Code", CurrencyCode);
        CurrRate.SetRange("Starting Date", Today());
        if CurrRate.FindFirst() then begin
            CurrRate."Exchange Rate Amount" := RateValue;
            CurrRate."Relational Exch. Rate Amount" := 1;
            CurrRate.Modify(true);
        end else begin
            CurrRate.Init();
            CurrRate."Currency Code" := CurrencyCode;
            CurrRate."Starting Date" := Today();
            CurrRate."Exchange Rate Amount" := RateValue;
            CurrRate."Relational Exch. Rate Amount" := 1;
            CurrRate.Insert(true);
        end;
    end;

    local procedure InsertLog(Message: Text[500]; Success: Boolean; Updated: Integer)
    var
        Log: Record "EX Sync Log";
    begin
        Log.Init();
        Log."Entry No." := 0;
        Log."Date Time" := CurrentDateTime();
        if Success then
            Log.Status := Enum::"EX Sync Log Status"::Success
        else
            Log.Status := Enum::"EX Sync Log Status"::Error;
        Log.Message := Message;
        Log."Rates Updated" := Updated;
        Log.Insert();
    end;
}
