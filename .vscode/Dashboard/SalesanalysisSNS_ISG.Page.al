page 50040 "Sales analysis SNS ISG"
{
    Caption = 'Sales Analysis SNS ISG';
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
                field(GrossProfitt; GrossProfitt)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Gross Profit';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                // field(YTDResult; YTDResult)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'YTD Growth %';
                //     Style = Favorable;
                //     StyleExpr = true;

                // }
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
                if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", CLE."Document No.");
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    if SalesInvLine.FindFirst() then
                        repeat
                            ItemRec.Get(SalesInvLine."No.");
                            ItemRec.CalcFields("Prod Segment");
                            if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                             then
                                TotalSaleAmtYTD += SalesInvLine."Line Amount";
                        until SalesInvLine.Next() = 0;
                end
                else
                    if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                        SaleCrMemoLine.Reset();
                        SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                        SaleCrMemoLine.SetRange(Type, SaleCrMemoLine.Type::Item);
                        if SaleCrMemoLine.FindFirst() then
                            repeat
                                ItemRec.Get(SaleCrMemoLine."No.");
                                ItemRec.CalcFields("Prod Segment");
                                if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                                 then
                                    TotalSaleAmtYTD -= SaleCrMemoLine."Line Amount";
                            until SaleCrMemoLine.Next() = 0;
                    end;

                if true then begin
                    if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", CLE."Document No.");
                        SalesInvLine.SetFilter(Type, '<>%1', SalesInvLine.Type::Item);
                        SalesInvLine.SetFilter("No.", '<>%1', '');
                        if SalesInvLine.FindFirst() then
                            repeat
                                TotalSaleAmtYTD += SalesInvLine."Line Amount";
                            until SalesInvLine.Next() = 0;
                    end
                    else
                        if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                            SaleCrMemoLine.Reset();
                            SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                            SaleCrMemoLine.SetFilter(Type, '<>%1', SaleCrMemoLine.Type::Item);
                            SaleCrMemoLine.SetFilter("No.", '<>%1', '');
                            if SaleCrMemoLine.FindFirst() then
                                repeat
                                    TotalSaleAmtYTD -= SaleCrMemoLine."Line Amount";
                                until SaleCrMemoLine.Next() = 0;
                        end;
                end;

            UNTIL CLE.NEXT = 0;

        TotalSaleAmtToday := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", Today);
        IF CLE.FINDFIRST THEN
            REPEAT
                if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", CLE."Document No.");
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    if SalesInvLine.FindFirst() then
                        repeat
                            ItemRec.Get(SalesInvLine."No.");
                            ItemRec.CalcFields("Prod Segment");
                            if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                             then
                                TotalSaleAmtToday += SalesInvLine."Line Amount";
                        until SalesInvLine.Next() = 0;
                end
                else
                    if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                        SaleCrMemoLine.Reset();
                        SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                        SaleCrMemoLine.SetRange(Type, SaleCrMemoLine.Type::Item);
                        if SaleCrMemoLine.FindFirst() then
                            repeat
                                ItemRec.Get(SaleCrMemoLine."No.");
                                ItemRec.CalcFields("Prod Segment");
                                if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                                 then
                                    TotalSaleAmtToday -= SaleCrMemoLine."Line Amount";
                            until SaleCrMemoLine.Next() = 0;
                    end;

                if true then begin
                    if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", CLE."Document No.");
                        SalesInvLine.SetFilter(Type, '<>%1', SalesInvLine.Type::Item);
                        if SalesInvLine.FindFirst() then
                            repeat
                                TotalSaleAmtToday += SalesInvLine."Line Amount";
                            until SalesInvLine.Next() = 0;
                    end
                    else
                        if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                            SaleCrMemoLine.Reset();
                            SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                            SaleCrMemoLine.SetFilter(Type, '<>%1', SaleCrMemoLine.Type::Item);
                            if SaleCrMemoLine.FindFirst() then
                                repeat
                                    TotalSaleAmtToday -= SaleCrMemoLine."Line Amount";
                                until SaleCrMemoLine.Next() = 0;
                        end;
                end;
            UNTIL CLE.NEXT = 0;

        TotalSaleAmtMonth := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", StartDate, EndDate);
        IF CLE.FINDFIRST THEN
            REPEAT
                if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                    SalesInvLine.Reset();
                    SalesInvLine.SetRange("Document No.", CLE."Document No.");
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    if SalesInvLine.FindFirst() then
                        repeat
                            ItemRec.Get(SalesInvLine."No.");
                            ItemRec.CalcFields("Prod Segment");
                            if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                             then
                                TotalSaleAmtMonth += SalesInvLine."Line Amount";
                        until SalesInvLine.Next() = 0;
                end
                else
                    if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                        SaleCrMemoLine.Reset();
                        SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                        SaleCrMemoLine.SetRange(Type, SaleCrMemoLine.Type::Item);
                        if SaleCrMemoLine.FindFirst() then
                            repeat
                                ItemRec.Get(SaleCrMemoLine."No.");
                                ItemRec.CalcFields("Prod Segment");
                                if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
                                 then
                                    TotalSaleAmtMonth -= SaleCrMemoLine."Line Amount";
                            until SaleCrMemoLine.Next() = 0;
                    end;

                if true then begin
                    if CLE."Document Type" = CLE."Document Type"::Invoice then begin
                        SalesInvLine.Reset();
                        SalesInvLine.SetRange("Document No.", CLE."Document No.");
                        SalesInvLine.SetFilter(Type, '<>%1', SalesInvLine.Type::Item);
                        if SalesInvLine.FindFirst() then
                            repeat
                                TotalSaleAmtMonth += SalesInvLine."Line Amount";
                            until SalesInvLine.Next() = 0;
                    end
                    else
                        if CLE."Document Type" = CLE."Document Type"::"Credit Memo" then begin
                            SaleCrMemoLine.Reset();
                            SaleCrMemoLine.SetRange("Document No.", CLE."Document No.");
                            SaleCrMemoLine.SetFilter(Type, '<>%1', SaleCrMemoLine.Type::Item);
                            if SaleCrMemoLine.FindFirst() then
                                repeat
                                    TotalSaleAmtMonth -= SaleCrMemoLine."Line Amount";
                                until SaleCrMemoLine.Next() = 0;
                        end;
                end;

            UNTIL CLE.NEXT = 0;

        StockValue := 0;
        // ValueEntry.Reset();
        // ValueEntry.SetRange("Purchase Type", ValueEntry."Purchase Type"::"Stock & Sales");
        // if ValueEntry.FindFirst() then
        //     repeat
        //         ItemRec.Get(ValueEntry."Item No.");
        //         ItemRec.CalcFields("Prod Segment");
        //         if ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG
        //          then
        //             StockValue += ValueEntry."Cost Amount (Actual)";
        //     until ValueEntry.Next() = 0;

        ItemLedEntry.Reset();
        // ItemLedEntry.SetRange("Purchase Type", ItemLedEntry."Purchase Type"::"Stock & Sales");
        ItemLedEntry.SetRange(Open, true);
        ItemLedEntry.SetRange(Open, true);
        if ItemLedEntry.FindFirst() then
            repeat
                ItemLedEntry.CalcFields("Cost Amount (Actual)");
                StockValue += (ItemLedEntry."Cost Amount (Actual)" / ItemLedEntry.Quantity) * ItemLedEntry."Remaining Quantity";
            until ItemLedEntry.Next() = 0;


        GrossProfitt := 0;
        CLEAR(CLE);
        CLE.Setfilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::"Credit Memo");
        CLE.SetRange("Posting Date", 20250401D, 20260331D);
        IF CLE.FINDFIRST THEN
            REPEAT
                GrossProfitt += CLE."Sales (LCY)";
            UNTIL CLE.NEXT = 0;

        // TotalSaleAmtYTDLastYear := 0;
        // CLEAR(CLEOld);
        // CLEOld.Setfilter("Document Type", '%1|%2', CLEOld."Document Type"::Invoice, CLEOld."Document Type"::"Credit Memo");
        // CLEOld.SetRange("Posting Date", 20220401D, Today - 365);
        // IF CLEOld.FINDFIRST THEN
        //     REPEAT
        //         TotalSaleAmtYTDLastYear += CLEOld."Sales (LCY)";
        //     UNTIL CLEOld.NEXT = 0;

        // Clear(YTDResult);
        // YTDResult := (((TotalSaleAmtYTD - TotalSaleAmtYTDLastYear) / TotalSaleAmtYTDLastYear) * 100) + 100;
    end;



    var
        SRAmountgl: Decimal;
        SIAmountgl: Decimal;
        ItemRec: Record Item;
        SalesInvLine: Record "Sales Invoice Line";
        SaleCrMemoLine: Record "Sales Cr.Memo Line";
        TotalSaleAmtYTD: decimal;
        CLE: Record "Cust. Ledger Entry";
        TotalSaleAmtToday: decimal;
        TotalSaleAmtMonth: decimal;
        StockValue: Decimal;
        ValueEntry: Record "Value Entry";
        ItemLedEntry: Record "Item Ledger Entry";
        GrossProfitt: Decimal;
        GLAcc: Record "G/L Account";
        StartDate: Date;
        EndDate: date;
        StartDateY: Date;
        EndDateY: date;
        TotalSaleAmtYTDLastYear: Decimal;
        YTDResult: Decimal;
        SalesPersonRec: Record "Salesperson/Purchaser";

}
