page 50096 "Sales analysis B2B"
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
                        CLERec.SetFilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;
                }

                field(TotalSaleAmtToday; TotalSaleAmtToday)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Today Sales Amt';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", Today);
                        CLERec.SetFilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;
                }

                field(TotalSaleAmtMonth; TotalSaleAmtMonth)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Month Sales Amt';

                    trigger OnDrillDown()
                    var
                        CLEPage: page "Customer Ledger Entries";
                        CLERec: Record "Cust. Ledger Entry";
                    begin
                        Clear(CLEPage);
                        CLERec.Reset();
                        CLERec.SetRange("Posting Date", StartDate, EndDate);
                        CLERec.SetFilter("Document Type", '%1|%2', CLERec."Document Type"::Invoice, CLERec."Document Type"::"Credit Memo");
                        CLEPage.SetTableView(CLERec);
                        CLEPage.Run();
                    end;
                }

                field(StockValue; StockValue)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Value';

                    trigger OnDrillDown()
                    begin
                    end;
                }

                field(GrossProfitt; GrossProfitt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gross Profit';

                    trigger OnDrillDown()
                    begin
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Clear(StartDate);
        Clear(EndDate);
        StartDate := CALCDATE('<-CM>', Today);
        EndDate := CALCDATE('<CM>', StartDate);

        TotalSaleAmtYTD := 0;
        CLE.Reset();
        CLE.SetFilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", 20250401D, 20260331D);
        CLE.CalcSums("Sales (LCY)");
        TotalSaleAmtYTD := CLE."Sales (LCY)";

        TotalSaleAmtToday := 0;
        CLE.Reset();
        CLE.SetFilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", Today);
        CLE.CalcSums("Sales (LCY)");
        TotalSaleAmtToday := CLE."Sales (LCY)";

        TotalSaleAmtMonth := 0;
        CLE.Reset();
        CLE.SetFilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", StartDate, EndDate);
        CLE.CalcSums("Sales (LCY)");
        TotalSaleAmtMonth := CLE."Sales (LCY)";

        StockValue := 0;
        ItemLedEntry.Reset();
        ItemLedEntry.SetRange(Open, true);
        if ItemLedEntry.FindSet() then
            repeat
                ItemLedEntry.CalcFields("Cost Amount (Actual)");
                if ItemLedEntry.Quantity <> 0 then
                    StockValue += (ItemLedEntry."Cost Amount (Actual)" / ItemLedEntry.Quantity) * ItemLedEntry."Remaining Quantity";
            until ItemLedEntry.Next() = 0;

        GrossProfitt := TotalSaleAmtYTD - StockValue;
    end;

    var
        ItemLedEntry: Record "Item Ledger Entry";
        TotalSaleAmtYTD: Decimal;
        CLE: Record "Cust. Ledger Entry";
        TotalSaleAmtToday: Decimal;
        TotalSaleAmtMonth: Decimal;
        StockValue: Decimal;
        GrossProfitt: Decimal;
        StartDate: Date;
        EndDate: Date;
}
