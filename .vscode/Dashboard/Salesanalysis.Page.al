page 50037 "Sales analysis"
{
    Caption = 'Sales Analysis';
    PageType = CardPart;


    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                Caption = 'Sales Activities';

                field(TotalSaleAmt; TotalSaleAmtYTD)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'YTD Sales Amt';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", 20250401D, 20260331D);
                        CLERec.Setfilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;
                }


                field(TotalSaleAmtToday; TotalSaleAmtToday)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Today Sales Amt';

                    /*  trigger OnDrillDown()
                     var
                         SalesInvPage: Page "Posted Sales Invoices";
                         SalesInvHDR: Record "Sales Invoice Header";
                     begin
                         Clear(SalesInvPage);
                         SalesInvHDR.Reset();
                         SalesInvHDR.SetRange("Posting Date", Today);
                         SalesInvPage.SetTableView(SalesInvHDR);
                         SalesInvPage.Run();
                     end; */
                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", Today);
                        CLERec.Setfilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;
                }

                field(TotalSaleAmtMonth; TotalSaleAmtMonth)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Month Sales Amt';

                    /* trigger OnDrillDown()
                    var
                        SalesInvPage: Page "Posted Sales Invoices";
                        SalesInvHDR: Record "Sales Invoice Header";
                    begin
                        Clear(SalesInvPage);
                        SalesInvHDR.Reset();
                        SalesInvHDR.SetRange("Posting Date", StartDate, EndDate);
                        SalesInvPage.SetTableView(SalesInvHDR);
                        SalesInvPage.Run();
                    end; */
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
                field(StockValue; StockValue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Value';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field(NetProfitt; NetProfitt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Net Profit';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field(YTDResult; YTDResult)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'YTD Growth %';
                    Style = Favorable;
                    StyleExpr = true;

                }
                field("Power BI"; PowerBI)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Power BI';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin
                        Hyperlink('https://app.powerbi.com/singleSignOn?pbi_source=websignin_uNav&ru=https%3A%2F%2Fapp.powerbi.com%2F%3Fpbi_source%3Dwebsignin_uNav%26noSignUpCheck%3D1');
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

        TotalSaleAmtYTD := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", 20250401D, 20260331D);
        IF CLE.FINDFIRST THEN
            REPEAT
                TotalSaleAmtYTD += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        TotalSaleAmtToday := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", Today);
        IF CLE.FINDFIRST THEN
            REPEAT
                TotalSaleAmtToday += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        TotalSaleAmtMonth := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", StartDate, EndDate);
        IF CLE.FINDFIRST THEN
            REPEAT
                TotalSaleAmtMonth += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        // StockValue := 0;
        // ValueEntry.Reset();
        // ValueEntry.CalcSums("Cost Amount (Actual)");
        // StockValue := ValueEntry."Cost Amount (Actual)";


        StockValue := 0;
        ItemLedEntry.Reset();
        ItemLedEntry.SetRange(Open, true);
        if ItemLedEntry.FindFirst() then
            repeat
                ItemLedEntry.CalcFields("Cost Amount (Actual)");
                StockValue += (ItemLedEntry."Cost Amount (Actual)" / ItemLedEntry.Quantity) * ItemLedEntry."Remaining Quantity";
            until ItemLedEntry.Next() = 0;

        NetProfitt := 0;
        GLAcc.Reset();
        GLAcc.SetRange("Income/Balance", GLAcc."Income/Balance"::"Income Statement");
        GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
        GLAcc.SetRange("Date Filter", 20250401D, 20260331D);
        if GLAcc.FindFirst() then
            repeat
                GLAcc.CalcFields("Net Change");
                NetProfitt += GLAcc."Net Change";
            until GLAcc.Next() = 0;

        // TotalSaleAmtYTDLastYear := 0;
        // CLEAR(CLE);
        // CLE.ChangeCompany('I-tek Logics Pvt  Ltd old');
        // CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        // CLE.SetRange("Posting Date", 20210401D, Today - 365);
        // IF CLE.FINDFIRST THEN
        //     REPEAT
        //         TotalSaleAmtYTDLastYear += CLE."Sales (LCY)";
        //     UNTIL CLE.NEXT = 0;

        TotalSaleAmtYTDLastYear := 0;
        CLEAR(CLEOld);
        CLEOld.Setfilter("Document Type", '%1|%2', CLEOld."Document Type"::Invoice, CLEOld."Document Type"::"Credit Memo");
        CLEOld.SetRange("Posting Date", 20240401D, Today - 365);
        IF CLEOld.FINDFIRST THEN
            REPEAT
                TotalSaleAmtYTDLastYear += CLEOld."Sales (LCY)";
            UNTIL CLEOld.NEXT = 0;

        Clear(YTDResult);
        YTDResult := (((TotalSaleAmtYTD - TotalSaleAmtYTDLastYear) / TotalSaleAmtYTDLastYear) * 100) + 100;
    end;



    var
        ItemLedEntry: Record "Item Ledger Entry";
        TotalSaleAmtYTD: decimal;
        CLE: Record "Cust. Ledger Entry";
        CLEOld: Record "Cust. Ledger Entry";
        TotalSaleAmtToday: decimal;
        TotalSaleAmtMonth: decimal;
        StockValue: Decimal;
        ValueEntry: Record "Value Entry";
        NetProfitt: Decimal;
        GLAcc: Record "G/L Account";
        StartDate: Date;
        EndDate: date;
        StartDateY: Date;
        EndDateY: date;
        TotalSaleAmtYTDLastYear: Decimal;
        YTDResult: Decimal;
        PowerBI: Text;



}
