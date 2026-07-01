page 50059 "Sales Values Dash"
{
    Caption = 'Sales Values Dash';
    PageType = CardPart;

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                Caption = 'Sales Activities';

                field(TotalSaleAmtMonth; TotalSaleAmtMonth)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hi-Tech Sales Amt MTD';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", StartDate, EndDate);
                        CLERec.Setfilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;

                }
                field(LocationSaleAmtMonth; LocationSaleAmtMonth)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Branch Sales Amt MTD';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", StartDate, EndDate);
                        CLERec.Setfilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        if UserId = 'ITEKLOGICS\RAJAN' then
                            CLERec.SetRange("Location State Code", 'PUN')
                        else
                            if UserId = 'ITEKLOGICS\BCDEV1' then
                                CLERec.SetRange("Location State Code", 'PUN')
                            else
                                if UserId = 'ITEKLOGICS\GULSHAN' then
                                    CLERec.SetRange("Location State Code", 'ND');
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;

                }
                field(OutStandingAmt; OutStandingAmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'OutStanding Amt Till Day';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLE.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
                        CLE.SetFilter("Due Date", '<=%1', Today);
                        if UserId = 'ITEKLOGICS\RAJAN' then
                            CLE.SetRange("Location State Code", 'PUN')
                        else
                            if UserId = 'ITEKLOGICS\BCDEV1' then
                                CLE.SetRange("Location State Code", 'PUN')
                            else
                                if UserId = 'ITEKLOGICS\GULSHAN' then
                                    CLE.SetRange("Location State Code", 'ND');

                        CLEPage.SetTableView(CLE);
                        CLEPage.Run();
                    end;

                }
                field(NexWeekDueAmt; NexWeekDueAmt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Next Week Due Amt';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        Clear(CLE);
                        CLE.SetRange("Document Type", cle."Document Type"::Invoice);
                        CLE.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
                        CLE.SetRange(Open, true);
                        CLE.SetFilter("Due Date", '%1..%2', today, Today + 6);
                        if UserId = 'ITEKLOGICS\RAJAN' then
                            CLE.SetRange("Location State Code", 'PUN')
                        else
                            if UserId = 'ITEKLOGICS\BCDEV1' then
                                CLE.SetRange("Location State Code", 'PUN')
                            else
                                if UserId = 'ITEKLOGICS\GULSHAN' then
                                    CLE.SetRange("Location State Code", 'ND');
                        CLEPage.SetTableView(CLE);
                        CLEPage.Run();
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        Clear(StartDate);
        Clear(EndDate);
        StartDate := CALCDATE('<-CM>', today);
        EndDate := CALCDATE('<CM>', StartDate);

        Clear(StartDateY);
        Clear(EndDateY);
        StartDateY := CALCDATE('<-CY>', today);
        EndDateY := CALCDATE('<CY>', StartDateY);

        TotalSaleAmtMonth := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", StartDate, EndDate);
        IF CLE.FINDFIRST THEN
            REPEAT
                TotalSaleAmtMonth += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        LocationSaleAmtMonth := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", StartDate, EndDate);
        if UserId = 'ITEKLOGICS\RAJAN' then
            CLE.SetRange("Location State Code", 'PUN')
        else
            if UserId = 'ITEKLOGICS\BCDEV1' then
                CLE.SetRange("Location State Code", 'PUN')
            else
                if UserId = 'ITEKLOGICS\GULSHAN' then
                    CLE.SetRange("Location State Code", 'ND');
        IF CLE.FINDFIRST THEN
            REPEAT
                LocationSaleAmtMonth += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        OutStandingAmt := 0;
        Clear(CLE);
        CLE.SetRange("Document Type", cle."Document Type"::Invoice);
        CLE.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
        CLE.SetFilter("Due Date", '<=%1', Today);
        if UserId = 'ITEKLOGICS\RAJAN' then
            CLE.SetRange("Location State Code", 'PUN')
        else
            if UserId = 'ITEKLOGICS\BCDEV1' then
                CLE.SetRange("Location State Code", 'PUN')
            else
                if UserId = 'ITEKLOGICS\GULSHAN' then
                    CLE.SetRange("Location State Code", 'ND');
        IF CLE.FINDFIRST THEN
            REPEAT
                cle.CalcFields("Remaining Amt. (LCY)");
                OutStandingAmt += CLE."Remaining Amt. (LCY)";
            UNTIL CLE.NEXT = 0;


        NexWeekDueAmt := 0;
        Clear(CLE);
        CLE.SetRange("Document Type", cle."Document Type"::Invoice);
        CLE.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
        CLE.SetRange(Open, true);
        CLE.SetFilter("Due Date", '%1..%2', today, Today + 6);
        if UserId = 'ITEKLOGICS\RAJAN' then
            CLE.SetRange("Location State Code", 'PUN')
        else
            if UserId = 'ITEKLOGICS\BCDEV1' then
                CLE.SetRange("Location State Code", 'PUN')
            else
                if UserId = 'ITEKLOGICS\GULSHAN' then
                    CLE.SetRange("Location State Code", 'ND');
        IF CLE.FINDFIRST THEN
            REPEAT
                cle.CalcFields("Remaining Amt. (LCY)");
                NexWeekDueAmt += CLE."Remaining Amt. (LCY)";
            UNTIL CLE.NEXT = 0;


    end;

    var
        CLE: Record "Cust. Ledger Entry";
        TotalSaleAmtMonth: decimal;
        LocationSaleAmtMonth: decimal;
        StartDate: Date;
        EndDate: date;
        StartDateY: Date;
        EndDateY: date;
        OutStandingAmt: Decimal;
        NexWeekDueAmt: Decimal;


}

