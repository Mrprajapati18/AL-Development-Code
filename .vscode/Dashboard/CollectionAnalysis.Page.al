page 50048 "Collection Analysis"
{
    Caption = 'Collection Analysis';
    PageType = CardPart;


    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                Caption = 'Collection Activities';
                field(YTDCollection; YTDCollection)
                {
                    Caption = 'YTD Collection Amt';
                    ApplicationArea = Basic, Suite;
                }
                field(MonthCollection; MonthCollection)
                {
                    Caption = 'Month Collection Amt';
                    ApplicationArea = Basic, Suite;
                }
                field(TodayCollection; TodayCollection)
                {
                    Caption = 'Today Collection Amt';
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        StartDate1: Date;
        EndDate1: Date;
    begin
        Clear(StartDate);
        Clear(EndDate);
        StartDate := CALCDATE('<-CM>', today);
        EndDate := CALCDATE('<CM>', StartDate);

        Clear(StartDate1);
        Clear(EndDate1);
        StartDate1 := StartDate - 1;
        EndDate1 := EndDate - 1;

        YTDCollection := 0;
        clear(BankaccLedgrEntRec1);
        BankaccLedgrEntRec1.SetRange("Bal. Account Type", BankaccLedgrEntRec1."Bal. Account Type"::Customer);
        BankaccLedgrEntRec1.SetRange("Posting Date", 20250331D, 20260330D);
        if BankaccLedgrEntRec1.FindFirst() then
            repeat
                YTDCollection += BankaccLedgrEntRec1.Amount;
            until BankaccLedgrEntRec1.Next() = 0;

        MonthCollection := 0;
        clear(BankaccLedgrEntRec2);
        BankaccLedgrEntRec2.SetRange("Bal. Account Type", BankaccLedgrEntRec2."Bal. Account Type"::Customer);
        BankaccLedgrEntRec2.SetRange("Posting Date", StartDate1, EndDate1);
        if BankaccLedgrEntRec2.FindFirst() then
            repeat
                MonthCollection += BankaccLedgrEntRec2.Amount;
            until BankaccLedgrEntRec2.Next() = 0;

        TodayCollection := 0;
        clear(BankaccLedgrEntRec3);
        BankaccLedgrEntRec3.SetRange("Bal. Account Type", BankaccLedgrEntRec3."Bal. Account Type"::Customer);
        BankaccLedgrEntRec3.SetRange("Posting Date", Today - 1);
        if BankaccLedgrEntRec3.FindFirst() then
            repeat
                todayCollection += BankaccLedgrEntRec3.Amount;
            until BankaccLedgrEntRec3.Next() = 0;



    end;

    var
        BankaccLedgrEntRec1: Record "Bank Account Ledger Entry";
        BankaccLedgrEntRec2: Record "Bank Account Ledger Entry";
        BankaccLedgrEntRec3: Record "Bank Account Ledger Entry";
        YTDCollection: Decimal;
        MonthCollection: Decimal;
        TodayCollection: Decimal;
        StartDate: Date;
        EndDate: date;


}
