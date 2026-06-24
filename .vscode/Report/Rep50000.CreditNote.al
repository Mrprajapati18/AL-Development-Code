report 50000 "Credit Note" // Durgesh 06 May 2026
{
    ApplicationArea = All;
    Caption = 'Credit Note';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\CreditNote.rdl';
    dataset
    {
        dataitem(SalesCrMemoHeader; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            // Company Information
            column(No; "No.")
            {
            }
            column(CompInfoName; CompInfoRec.Name)
            {
            }
            column(CompInfoAdd1; CompInfoRec.Address)
            {
            }
            column(CompInfoAdd2; CompInfoRec."Address 2")
            {
            }
            column(CompInfoCity; CompInfoRec.City)
            {
            }
            column(CompInfoPostCode; CompInfoRec."Post Code")
            {
            }
            column(CompInfoGstReg; CompInfoRec."GST Registration No.")
            {
            }
            column(CompInfoEmail; CompInfoRec."E-Mail")
            {
            }
            column(Due_Date; Format("Due Date"))
            {
            }
            column(Document_Date; Format("Document Date"))
            {
            }

            // Bill To Address
            column(BilltoAddress; "Bill-to Address")
            {
            }
            column(BilltoAddress2; "Bill-to Address 2")
            {
            }
            column(BilltoCity; "Bill-to City")
            {
            }
            column(BilltoCountryRegionCode; "Bill-to Country/Region Code")
            {
            }
            column(BilltoCounty; "Bill-to County")
            {
            }
            column(BilltoCustomerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoName; "Bill-to Name")
            {
            }
            column(BilltoName2; "Bill-to Name 2")
            {
            }
            column(BilltoPostCode; "Bill-to Post Code")
            {
            }

            column(GrandTotalBaseAmt; GrandTotalBaseAmt)
            {
            }
            column(GrandTotalGSTAmt; GrandTotalGSTAmt)
            {
            }
            column(GrandFinalTotal; GrandFinalTotal)
            {
            }

            // GST Calculation
            column(TotalCGSTPer; TotalCGSTPer)
            {
            }
            column(TotalIGSTPer; TotalIGSTPer)
            {
            }
            column(TotalSGSTPer; TotalSGSTPer)
            {
            }
            column(TotalBaseAmt; TotalBaseAmt)
            {
            }
            column(TotalCGSTAmt; TotalCGSTAmt)
            {
            }
            column(TotalIGSTAmt; TotalIGSTAmt)
            {
            }
            column(TotalSGSTAmt; TotalSGSTAmt)
            {
            }
            column(AllGstPer; AllGstPer)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(TotalAmtLineGSt; TotalAmtLineGSt)
            {
            }
            column(FinalTotalAmount; FinalTotalAmount)
            {
            }

            // Amount in Words Columns
            column(AmountInWords1; Amountinwords[1])
            {
            }
            column(AmountInWords2; Amountinwords[2])
            {
            }
            column(AmountInWordsCaptionLbl; AmountInWordsCaptionLbl)
            {
            }

            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLinkReference = SalesCrMemoHeader;
                DataItemLink = "Document No." = FIELD("No.");
                column(Sno; Sno)
                {
                }
                column(Description; Description)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Qty__per_Unit_of_Measure; "Qty. per Unit of Measure")
                {
                }
                column(TotalLineAmount; TotalLineAmount)
                {
                }
                column(Line_Amount; "Line Amount")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if (Quantity = 0) or ("Qty. per Unit of Measure" = 0) then
                        CurrReport.Skip();

                    Sno += 1;

                    // GST Calculation (Line Level)
                    Clear(TotalCGSTPer);
                    Clear(TotalIGSTPer);
                    Clear(TotalSGSTPer);
                    Clear(TotalCGSTAmt);
                    Clear(TotalIGSTAmt);
                    Clear(TotalSGSTAmt);
                    Clear(TotalBaseAmt);
                    Clear(GSTAmount);
                    Clear(AllGstPer);
                    Clear(SaveGSTPer);

                    DetailedGSTLedgerEntry.Reset();
                    DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                    DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                    DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                    DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                    DetailedGSTLedgerEntry.SetRange("HSN/SAC Code", "HSN/SAC Code");
                    DetailedGSTLedgerEntry.CalcSums(DetailedGSTLedgerEntry."GST Amount", "GST Base Amount");
                    TotalBaseAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");

                    if DetailedGSTLedgerEntry.FindFirst() then begin
                        repeat
                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
                                TotalCGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                                TotalCGSTPer := DetailedGSTLedgerEntry."GST %";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
                                TotalIGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                                TotalIGSTPer := DetailedGSTLedgerEntry."GST %";
                            end;
                            if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
                                TotalSGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                                TotalSGSTPer := DetailedGSTLedgerEntry."GST %";
                            end;
                        until DetailedGSTLedgerEntry.Next() = 0;
                    end;

                    if (TotalCGSTPer > 0) and (TotalSGSTPer > 0) then
                        AllGstPer := TotalCGSTPer + TotalCGSTPer
                    else
                        if TotalIGSTPer > 0 then
                            AllGstPer := TotalIGSTPer;

                    TotalAmount := Abs(Amount);
                    TotalAmtLineGSt := TotalIGSTAmt + TotalCGSTAmt + TotalSGSTAmt;
                    FinalTotalAmount := "Line Amount" + TotalAmtLineGSt;

                    TotalLineAmount += "Line Amount"; 
                end;
            }

            trigger OnAfterGetRecord()
            var
                CrMemoLine: Record "Sales Cr.Memo Line";
                TempGSTEntry: Record "Detailed GST Ledger Entry";
            begin
               
                CrMemoLine.SetRange("Document No.", "No.");
                CrMemoLine.CalcSums("Line Amount");
                GrandTotalBaseAmt := CrMemoLine."Line Amount";

                
                GrandTotalGSTAmt := 0;
                if CrMemoLine.FindSet() then
                    repeat
                        if (CrMemoLine.Quantity <> 0) and (CrMemoLine."Qty. per Unit of Measure" <> 0) then begin
                            TempGSTEntry.Reset();
                            TempGSTEntry.SetRange("Document No.", "No.");
                            TempGSTEntry.SetRange("Document Line No.", CrMemoLine."Line No.");
                            TempGSTEntry.SetRange("Transaction Type", TempGSTEntry."Transaction Type"::Sales);
                            TempGSTEntry.SetRange("Entry Type", TempGSTEntry."Entry Type"::"Initial Entry");
                            TempGSTEntry.CalcSums("GST Amount");
                            GrandTotalGSTAmt += Abs(TempGSTEntry."GST Amount");
                        end;
                    until CrMemoLine.Next() = 0;

                GrandFinalTotal := GrandTotalBaseAmt + GrandTotalGSTAmt;

                FormatNoText(Amountinwords, GrandFinalTotal, "Currency Code");
            end;

            trigger OnPreDataItem()
            begin
                CompInfoRec.Get();

                TotalAmtLine := 0;
                Sno := 0;

                Clear(TotalLineAmount);
                Clear(GrandTotalBaseAmt);
                Clear(GrandTotalGSTAmt);
                Clear(GrandFinalTotal);

                InitTextVariable();
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CompInfoRec: Record "Company Information";
        Sno: Integer;
        TotalAmtLine: Decimal;
        TotalAmtLineGSt: Decimal;
        FinalTotalAmount: Decimal;
        TotalLineAmount: Decimal;

        GrandTotalBaseAmt: Decimal;
        GrandTotalGSTAmt: Decimal;
        GrandFinalTotal: Decimal;

        // Gst Calculation
        AllGstPer: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TotalCGSTPer: Decimal;
        TotalIGSTPer: Decimal;
        TotalSGSTPer: Decimal;
        TotalCGSTAmt: Decimal;
        TotalIGSTAmt: Decimal;
        TotalSGSTAmt: Decimal;
        TotalBaseAmt: Decimal;
        SaveGSTPer: Decimal;
        GSTAmount: Decimal;
        TotalAmount: Decimal;

        // Amount in Words
        Amountinwords: array[2] of Text[100];
        Notext1: array[2] of Text[100];
        Notext2: array[2] of Text[100];

        Text16526: Label 'Zero';
        Text16527: Label 'Hundred';
        Text16528: Label 'And';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'One';
        Text16533: Label 'Two';
        Text16534: Label 'Three';
        Text16535: Label 'Four';
        Text16536: Label 'Five';
        Text16537: Label 'Six';
        Text16538: Label 'Seven';
        Text16539: Label 'Eight';
        Text16540: Label 'Nine';
        Text16541: Label 'Ten';
        Text16542: Label 'Eleven';
        Text16543: Label 'Twelve';
        Text16544: Label 'Thirteen';
        Text16545: Label 'Fourteen';
        Text16546: Label 'Fifteen';
        Text16547: Label 'Sixteen';
        Text16548: Label 'Seventeen';
        Text16549: Label 'Eighteen';
        Text16550: Label 'Nineteen';
        Text16551: Label 'Twenty';
        Text16552: Label 'Thirty';
        Text16553: Label 'Forty';
        Text16554: Label 'Fifty';
        Text16555: Label 'Sixty';
        Text16556: Label 'Seventy';
        Text16557: Label 'Eighty';
        Text16558: Label 'Ninety';
        Text16559: Label 'Thousand';
        Text16560: Label 'Million';
        Text16561: Label 'Billion';
        Text16562: Label 'Lakh';
        Text16563: Label 'Crore';

        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];

        AmountInWordsCaptionLbl: Label 'Amount (in words):';

        Heading1: Label '"I/We hereby certify that my/our registration certificate under the Goods and Service Tax Act, 2017 is in force on the date on which the sale of the goods specified in this tax invoice is made by me/us and that the transaction of sale covered by this tax invoice has been effected by me/us and it shall be accounted for the turnover of sales while filing of return and the tax, if any, payable on the sale has been paid or shali be paid"';

        Heading2: Label 'Declaration: We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct. The above mentioned products may be subject to U.S. Law. Re-export or transfer to restricted countries or denied parties contrary to U.S. or Local Law is strictly prohibited without the prior consent in writing of Avery Dennisons Law Department.';

    procedure FormatNoText(var NoText: array[2] of Text[100]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'Rupees');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);

        IF (CurrencyCode <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' Only')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' Paisa Only');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[100]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
        ExponentText[5] := '';
    end;
}





// report 50002 "Credit Debit Note"
// {
//     ApplicationArea = All;
//     Caption = 'Credit/Debit Note';
//     UsageCategory = ReportsAndAnalysis;
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Layouts\CreditNote.rdl';

//     dataset
//     {
//         dataitem(SalesCrMemoHeader; "Sales Cr.Memo Header")
//         {
//             RequestFilterFields = "No.";

//             column(CN_No; "No.") { }
//             column(CN_CompInfoName; CompInfoRec.Name) { }
//             column(CN_CompInfoAdd1; CompInfoRec.Address) { }
//             column(CN_CompInfoAdd2; CompInfoRec."Address 2") { }
//             column(CN_CompInfoCity; CompInfoRec.City) { }
//             column(CN_CompInfoPostCode; CompInfoRec."Post Code") { }
//             column(CN_CompInfoGstReg; CompInfoRec."GST Registration No.") { }
//             column(CN_CompInfoEmail; CompInfoRec."E-Mail") { }
//             column(CN_Due_Date; Format("Due Date")) { }
//             column(CN_Document_Date; Format("Document Date")) { }

//             column(CN_BilltoAddress; "Bill-to Address") { }
//             column(CN_BilltoAddress2; "Bill-to Address 2") { }
//             column(CN_BilltoCity; "Bill-to City") { }
//             column(CN_BilltoCountryRegionCode; "Bill-to Country/Region Code") { }
//             column(CN_BilltoCounty; "Bill-to County") { }
//             column(CN_BilltoCustomerNo; "Bill-to Customer No.") { }
//             column(CN_BilltoName; "Bill-to Name") { }
//             column(CN_BilltoName2; "Bill-to Name 2") { }
//             column(CN_BilltoPostCode; "Bill-to Post Code") { }

//             column(CN_GrandTotalBaseAmt; CN_GrandTotalBaseAmt) { }
//             column(CN_GrandTotalGSTAmt; CN_GrandTotalGSTAmt) { }
//             column(CN_GrandFinalTotal; CN_GrandFinalTotal) { }

//             column(CN_TotalCGSTPer; CN_TotalCGSTPer) { }
//             column(CN_TotalIGSTPer; CN_TotalIGSTPer) { }
//             column(CN_TotalSGSTPer; CN_TotalSGSTPer) { }
//             column(CN_TotalBaseAmt; CN_TotalBaseAmt) { }
//             column(CN_TotalCGSTAmt; CN_TotalCGSTAmt) { }
//             column(CN_TotalIGSTAmt; CN_TotalIGSTAmt) { }
//             column(CN_TotalSGSTAmt; CN_TotalSGSTAmt) { }
//             column(CN_AllGstPer; CN_AllGstPer) { }
//             column(CN_TotalAmount; CN_TotalAmount) { }
//             column(CN_TotalAmtLineGSt; CN_TotalAmtLineGSt) { }
//             column(CN_FinalTotalAmount; CN_FinalTotalAmount) { }

//             column(CN_AmountInWords1; CN_Amountinwords[1]) { }
//             column(CN_AmountInWords2; CN_Amountinwords[2]) { }
//             column(CN_AmountInWordsCaptionLbl; AmountInWordsCaptionLbl) { }

//             dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
//             {
//                 DataItemLinkReference = SalesCrMemoHeader;
//                 DataItemLink = "Document No." = FIELD("No.");

//                 column(CN_Sno; CN_Sno) { }
//                 column(CN_Description; Description) { }
//                 column(CN_HSN_SAC_Code; "HSN/SAC Code") { }
//                 column(CN_Quantity; Quantity) { }
//                 column(CN_Qty_per_Unit_of_Measure; "Qty. per Unit of Measure") { }
//                 column(CN_TotalLineAmount; CN_TotalLineAmount) { }
//                 column(CN_Line_Amount; "Line Amount") { }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if (Quantity = 0) or ("Qty. per Unit of Measure" = 0) then
//                         CurrReport.Skip();

//                     CN_Sno += 1;

//                     Clear(CN_TotalCGSTPer);
//                     Clear(CN_TotalIGSTPer);
//                     Clear(CN_TotalSGSTPer);
//                     Clear(CN_TotalCGSTAmt);
//                     Clear(CN_TotalIGSTAmt);
//                     Clear(CN_TotalSGSTAmt);
//                     Clear(CN_TotalBaseAmt);
//                     Clear(CN_GSTAmount);
//                     Clear(CN_AllGstPer);
//                     Clear(CN_SaveGSTPer);

//                     DetailedGSTLedgerEntry.Reset();
//                     DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
//                     DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
//                     DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
//                     DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                     DetailedGSTLedgerEntry.SetRange("HSN/SAC Code", "HSN/SAC Code");
//                     DetailedGSTLedgerEntry.CalcSums(DetailedGSTLedgerEntry."GST Amount", "GST Base Amount");
//                     CN_TotalBaseAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");

//                     if DetailedGSTLedgerEntry.FindFirst() then begin
//                         repeat
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
//                                 CN_TotalCGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 CN_TotalCGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
//                                 CN_TotalIGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 CN_TotalIGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
//                                 CN_TotalSGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 CN_TotalSGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                         until DetailedGSTLedgerEntry.Next() = 0;
//                     end;

//                     if (CN_TotalCGSTPer > 0) and (CN_TotalSGSTPer > 0) then
//                         CN_AllGstPer := CN_TotalCGSTPer + CN_TotalSGSTPer
//                     else
//                         if CN_TotalIGSTPer > 0 then
//                             CN_AllGstPer := CN_TotalIGSTPer;

//                     CN_TotalAmount := Abs(Amount);
//                     CN_TotalAmtLineGSt := CN_TotalIGSTAmt + CN_TotalCGSTAmt + CN_TotalSGSTAmt;
//                     CN_FinalTotalAmount := "Line Amount" + CN_TotalAmtLineGSt;
//                     CN_TotalLineAmount += "Line Amount";
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 CrMemoLine: Record "Sales Cr.Memo Line";
//                 TempGSTEntry: Record "Detailed GST Ledger Entry";
//             begin
//                 CrMemoLine.SetRange("Document No.", "No.");
//                 CrMemoLine.CalcSums("Line Amount");
//                 CN_GrandTotalBaseAmt := CrMemoLine."Line Amount";

//                 CN_GrandTotalGSTAmt := 0;
//                 if CrMemoLine.FindSet() then
//                     repeat
//                         if (CrMemoLine.Quantity <> 0) and (CrMemoLine."Qty. per Unit of Measure" <> 0) then begin
//                             TempGSTEntry.Reset();
//                             TempGSTEntry.SetRange("Document No.", "No.");
//                             TempGSTEntry.SetRange("Document Line No.", CrMemoLine."Line No.");
//                             TempGSTEntry.SetRange("Transaction Type", TempGSTEntry."Transaction Type"::Sales);
//                             TempGSTEntry.SetRange("Entry Type", TempGSTEntry."Entry Type"::"Initial Entry");
//                             TempGSTEntry.CalcSums("GST Amount");
//                             CN_GrandTotalGSTAmt += Abs(TempGSTEntry."GST Amount");
//                         end;
//                     until CrMemoLine.Next() = 0;

//                 CN_GrandFinalTotal := CN_GrandTotalBaseAmt + CN_GrandTotalGSTAmt;
//                 FormatNoText(CN_Amountinwords, CN_GrandFinalTotal, "Currency Code");
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if ShowDebitNote then begin
//                     SalesCrMemoHeader.SetRange("No.", ''); 
//                     exit;
//                 end;

//                 CompInfoRec.Get();
//                 CN_Sno := 0;
//                 Clear(CN_TotalLineAmount);
//                 Clear(CN_GrandTotalBaseAmt);
//                 Clear(CN_GrandTotalGSTAmt);
//                 Clear(CN_GrandFinalTotal);
//                 InitTextVariable();
//             end;
//         }

//         dataitem("PurchCrMemoHdr"; "Purch. Cr. Memo Hdr.")
//         {
//             RequestFilterFields = "No.";

//             column(DN_No; "No.") { }
//             column(DN_CompInfoName; CompInfoRec.Name) { }
//             column(DN_CompInfoAdd1; CompInfoRec.Address) { }
//             column(DN_CompInfoAdd2; CompInfoRec."Address 2") { }
//             column(DN_CompInfoCity; CompInfoRec.City) { }
//             column(DN_CompInfoPostCode; CompInfoRec."Post Code") { }
//             column(DN_CompInfoGstReg; CompInfoRec."GST Registration No.") { }
//             column(DN_CompInfoEmail; CompInfoRec."E-Mail") { }
//             column(DN_Posting_Date; Format("Posting Date")) { }
//             column(DN_Document_Date; Format("Document Date")) { }

//             column(DN_Ship_to_Address; "Ship-to Address") { }
//             column(DN_Ship_to_Address_2; "Ship-to Address 2") { }
//             column(DN_Ship_to_City; "Ship-to City") { }
//             column(DN_Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
//             column(DN_Ship_to_County; "Ship-to County") { }
//             column(DN_Ship_to_Name; "Ship-to Name") { }
//             column(DN_Ship_to_Name_2; "Ship-to Name 2") { }
//             column(DN_Ship_to_Post_Code; "Ship-to Post Code") { }
//             column(DN_Vendor_GST_Reg_No; "Vendor GST Reg. No.") { }

//             column(DN_TotalCGSTPer; DN_TotalCGSTPer) { }
//             column(DN_TotalIGSTPer; DN_TotalIGSTPer) { }
//             column(DN_TotalSGSTPer; DN_TotalSGSTPer) { }
//             column(DN_TotalBaseAmt; DN_TotalBaseAmt) { }
//             column(DN_TotalCGSTAmt; DN_TotalCGSTAmt) { }
//             column(DN_TotalIGSTAmt; DN_TotalIGSTAmt) { }
//             column(DN_TotalSGSTAmt; DN_TotalSGSTAmt) { }
//             column(DN_AllGstPer; DN_AllGstPer) { }
//             column(DN_TotalAmount; DN_TotalAmount) { }
//             column(DN_TotalAmtLineGSt; DN_TotalAmtLineGSt) { }
//             column(DN_FinalTotalAmount; DN_FinalTotalAmount) { }

//             column(DN_GrandTotalBaseAmt; DN_GrandTotalBaseAmt) { }
//             column(DN_GrandTotalGSTAmt; DN_GrandTotalGSTAmt) { }
//             column(DN_GrandFinalTotal; DN_GrandFinalTotal) { }

//             column(DN_AmountInWords1; DN_Amountinwords[1]) { }
//             column(DN_AmountInWords2; DN_Amountinwords[2]) { }
//             column(DN_AmountInWordsCaptionLbl; AmountInWordsCaptionLbl) { }

//             dataitem("PurchCrMemoLine"; "Purch. Cr. Memo Line")
//             {
//                 DataItemLinkReference = PurchCrMemoHdr;
//                 DataItemLink = "Document No." = FIELD("No.");

//                 column(DN_Sno; DN_Sno) { }
//                 column(DN_Description; Description) { }
//                 column(DN_HSN_SAC_Code; "HSN/SAC Code") { }
//                 column(DN_Quantity; Quantity) { }
//                 column(DN_Direct_Unit_Cost; "Direct Unit Cost") { }
//                 column(DN_TotalLineAmount; DN_TotalLineAmount) { }
//                 column(DN_Line_Amount; "Line Amount") { }

//                 trigger OnAfterGetRecord()
//                 begin
//                     if Quantity = 0 then
//                         CurrReport.Skip();

//                     DN_Sno += 1;

//                     Clear(DN_TotalCGSTPer);
//                     Clear(DN_TotalIGSTPer);
//                     Clear(DN_TotalSGSTPer);
//                     Clear(DN_TotalCGSTAmt);
//                     Clear(DN_TotalIGSTAmt);
//                     Clear(DN_TotalSGSTAmt);
//                     Clear(DN_TotalBaseAmt);
//                     Clear(DN_GSTAmount);
//                     Clear(DN_AllGstPer);
//                     Clear(DN_SaveGSTPer);

//                     DetailedGSTLedgerEntry.Reset();
//                     DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
//                     DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
//                     DetailedGSTLedgerEntry.SetRange("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Purchase);
//                     DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                     DetailedGSTLedgerEntry.SetRange("HSN/SAC Code", "HSN/SAC Code");
//                     DetailedGSTLedgerEntry.CalcSums(DetailedGSTLedgerEntry."GST Amount", "GST Base Amount");
//                     DN_TotalBaseAmt := Abs(DetailedGSTLedgerEntry."GST Base Amount");

//                     if DetailedGSTLedgerEntry.FindFirst() then begin
//                         repeat
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then begin
//                                 DN_TotalCGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 DN_TotalCGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then begin
//                                 DN_TotalIGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 DN_TotalIGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                             if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then begin
//                                 DN_TotalSGSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//                                 DN_TotalSGSTPer := DetailedGSTLedgerEntry."GST %";
//                             end;
//                         until DetailedGSTLedgerEntry.Next() = 0;
//                     end;

//                     if (DN_TotalCGSTPer > 0) and (DN_TotalSGSTPer > 0) then
//                         DN_AllGstPer := DN_TotalCGSTPer + DN_TotalSGSTPer
//                     else
//                         if DN_TotalIGSTPer > 0 then
//                             DN_AllGstPer := DN_TotalIGSTPer;

//                     DN_TotalAmount := Abs(Amount);
//                     DN_TotalAmtLineGSt := DN_TotalIGSTAmt + DN_TotalCGSTAmt + DN_TotalSGSTAmt;
//                     DN_FinalTotalAmount := "Line Amount" + DN_TotalAmtLineGSt;
//                     DN_GrandTotalGSTAmt += DN_TotalAmtLineGSt;
//                     DN_GrandFinalTotal := DN_GrandTotalBaseAmt + DN_GrandTotalGSTAmt;

//                     FormatNoText(DN_Amountinwords, DN_GrandFinalTotal, PurchCrMemoHdr."Currency Code");
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             var
//                 CrMemoLine: Record "Purch. Cr. Memo Line";
//             begin
//                 CrMemoLine.Reset();
//                 CrMemoLine.SetRange("Document No.", "No.");
//                 CrMemoLine.SetFilter(Quantity, '<>%1', 0);
//                 CrMemoLine.CalcSums("Line Amount");
//                 DN_GrandTotalBaseAmt := CrMemoLine."Line Amount";

//                 DN_GrandTotalGSTAmt := 0;
//                 DN_GrandFinalTotal := 0;
//                 Clear(DN_Amountinwords);
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if not ShowDebitNote then begin
//                     "PurchCrMemoHdr".SetRange("No.", ''); 
//                     exit;
//                 end;

//                 CompInfoRec.Get();
//                 DN_Sno := 0;
//                 Clear(DN_GrandTotalBaseAmt);
//                 Clear(DN_GrandTotalGSTAmt);
//                 Clear(DN_GrandFinalTotal);
//                 Clear(DN_Amountinwords);
//                 InitTextVariable();
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(ShowDebitNoteField; ShowDebitNote)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Show Debit Note';
//                     }
//                 }
//             }
//         }
//     }

//     var
//         ShowDebitNote: Boolean;
//         CompInfoRec: Record "Company Information";
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";

//         // Credit Note Variables
//         CN_Sno: Integer;
//         CN_TotalAmtLine: Decimal;
//         CN_TotalAmtLineGSt: Decimal;
//         CN_FinalTotalAmount: Decimal;
//         CN_TotalLineAmount: Decimal;
//         CN_GrandTotalBaseAmt: Decimal;
//         CN_GrandTotalGSTAmt: Decimal;
//         CN_GrandFinalTotal: Decimal;
//         CN_AllGstPer: Decimal;
//         CN_TotalCGSTPer: Decimal;
//         CN_TotalIGSTPer: Decimal;
//         CN_TotalSGSTPer: Decimal;
//         CN_TotalCGSTAmt: Decimal;
//         CN_TotalIGSTAmt: Decimal;
//         CN_TotalSGSTAmt: Decimal;
//         CN_TotalBaseAmt: Decimal;
//         CN_SaveGSTPer: Decimal;
//         CN_GSTAmount: Decimal;
//         CN_TotalAmount: Decimal;
//         CN_Amountinwords: array[2] of Text[100];

//         // Debit Note Variables
//         DN_Sno: Integer;
//         DN_TotalAmtLine: Decimal;
//         DN_TotalAmtLineGSt: Decimal;
//         DN_FinalTotalAmount: Decimal;
//         DN_TotalLineAmount: Decimal;
//         DN_GrandTotalBaseAmt: Decimal;
//         DN_GrandTotalGSTAmt: Decimal;
//         DN_GrandFinalTotal: Decimal;
//         DN_AllGstPer: Decimal;
//         DN_TotalCGSTPer: Decimal;
//         DN_TotalIGSTPer: Decimal;
//         DN_TotalSGSTPer: Decimal;
//         DN_TotalCGSTAmt: Decimal;
//         DN_TotalIGSTAmt: Decimal;
//         DN_TotalSGSTAmt: Decimal;
//         DN_TotalBaseAmt: Decimal;
//         DN_SaveGSTPer: Decimal;
//         DN_GSTAmount: Decimal;
//         DN_TotalAmount: Decimal;
//         DN_Amountinwords: array[2] of Text[100];

//         // Shared
//         AmountInWordsCaptionLbl: Label 'Amount (in words):';
//         Notext1: array[2] of Text[100];
//         Notext2: array[2] of Text[100];

//         Text16526: Label 'Zero';
//         Text16527: Label 'Hundred';
//         Text16528: Label 'And';
//         Text16529: Label '%1 results in a written number that is too long.';
//         Text16532: Label 'One';
//         Text16533: Label 'Two';
//         Text16534: Label 'Three';
//         Text16535: Label 'Four';
//         Text16536: Label 'Five';
//         Text16537: Label 'Six';
//         Text16538: Label 'Seven';
//         Text16539: Label 'Eight';
//         Text16540: Label 'Nine';
//         Text16541: Label 'Ten';
//         Text16542: Label 'Eleven';
//         Text16543: Label 'Twelve';
//         Text16544: Label 'Thirteen';
//         Text16545: Label 'Fourteen';
//         Text16546: Label 'Fifteen';
//         Text16547: Label 'Sixteen';
//         Text16548: Label 'Seventeen';
//         Text16549: Label 'Eighteen';
//         Text16550: Label 'Nineteen';
//         Text16551: Label 'Twenty';
//         Text16552: Label 'Thirty';
//         Text16553: Label 'Forty';
//         Text16554: Label 'Fifty';
//         Text16555: Label 'Sixty';
//         Text16556: Label 'Seventy';
//         Text16557: Label 'Eighty';
//         Text16558: Label 'Ninety';
//         Text16559: Label 'Thousand';
//         Text16560: Label 'Million';
//         Text16561: Label 'Billion';
//         Text16562: Label 'Lakh';
//         Text16563: Label 'Crore';

//         OnesText: array[20] of Text[30];
//         TensText: array[10] of Text[30];
//         ExponentText: array[5] of Text[30];

//         Heading1: Label '"I/We hereby certify that my/our registration certificate under the Goods and Service Tax Act, 2017 is in force on the date on which the sale of the goods specified in this tax invoice is made by me/us and that the transaction of sale covered by this tax invoice has been effected by me/us and it shall be accounted for the turnover of sales while filing of return and the tax, if any, payable on the sale has been paid or shali be paid"';
//         Heading2: Label 'Declaration: We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.';

//     procedure FormatNoText(var NoText: array[2] of Text[100]; No: Decimal; CurrencyCode: Code[10])
//     var
//         PrintExponent: Boolean;
//         Ones: Integer;
//         Tens: Integer;
//         Hundreds: Integer;
//         Exponent: Integer;
//         NoTextIndex: Integer;
//         Currency: Record 4;
//         TensDec: Integer;
//         OnesDec: Integer;
//     begin
//         CLEAR(NoText);
//         NoTextIndex := 1;
//         NoText[1] := '';

//         IF No < 1 THEN
//             AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
//         ELSE BEGIN
//             FOR Exponent := 4 DOWNTO 1 DO BEGIN
//                 PrintExponent := FALSE;
//                 IF No > 99999 THEN BEGIN
//                     Ones := No DIV (POWER(100, Exponent - 1) * 10);
//                     Hundreds := 0;
//                 END ELSE BEGIN
//                     Ones := No DIV POWER(1000, Exponent - 1);
//                     Hundreds := Ones DIV 100;
//                 END;
//                 Tens := (Ones MOD 100) DIV 10;
//                 Ones := Ones MOD 10;
//                 IF Hundreds > 0 THEN BEGIN
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
//                 END;
//                 IF Tens >= 2 THEN BEGIN
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
//                     IF Ones > 0 THEN
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
//                 END ELSE
//                     IF (Tens * 10 + Ones) > 0 THEN
//                         AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
//                 IF PrintExponent AND (Exponent > 1) THEN
//                     AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
//                 IF No > 99999 THEN
//                     No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
//                 ELSE
//                     No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
//             END;
//         END;

//         IF CurrencyCode <> '' THEN BEGIN
//             Currency.GET(CurrencyCode);
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
//         END ELSE
//             AddToNoText(NoText, NoTextIndex, PrintExponent, 'Rupees');

//         AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

//         TensDec := ((No * 100) MOD 100) DIV 10;
//         OnesDec := (No * 100) MOD 10;
//         IF TensDec >= 2 THEN BEGIN
//             AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
//             IF OnesDec > 0 THEN
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
//         END ELSE
//             IF (TensDec * 10 + OnesDec) > 0 THEN
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
//             ELSE
//                 AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);

//         IF (CurrencyCode <> '') THEN
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' Only')
//         ELSE
//             AddToNoText(NoText, NoTextIndex, PrintExponent, ' Paisa Only');
//     end;

//     local procedure AddToNoText(var NoText: array[2] of Text[100]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
//     begin
//         PrintExponent := TRUE;
//         WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
//             NoTextIndex := NoTextIndex + 1;
//             IF NoTextIndex > ARRAYLEN(NoText) THEN
//                 ERROR(Text16529, AddText);
//         END;
//         NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
//     end;

//     procedure InitTextVariable()
//     begin
//         OnesText[1] := Text16532;
//         OnesText[2] := Text16533;
//         OnesText[3] := Text16534;
//         OnesText[4] := Text16535;
//         OnesText[5] := Text16536;
//         OnesText[6] := Text16537;
//         OnesText[7] := Text16538;
//         OnesText[8] := Text16539;
//         OnesText[9] := Text16540;
//         OnesText[10] := Text16541;
//         OnesText[11] := Text16542;
//         OnesText[12] := Text16543;
//         OnesText[13] := Text16544;
//         OnesText[14] := Text16545;
//         OnesText[15] := Text16546;
//         OnesText[16] := Text16547;
//         OnesText[17] := Text16548;
//         OnesText[18] := Text16549;
//         OnesText[19] := Text16550;

//         TensText[1] := '';
//         TensText[2] := Text16551;
//         TensText[3] := Text16552;
//         TensText[4] := Text16553;
//         TensText[5] := Text16554;
//         TensText[6] := Text16555;
//         TensText[7] := Text16556;
//         TensText[8] := Text16557;
//         TensText[9] := Text16558;

//         ExponentText[1] := '';
//         ExponentText[2] := Text16559;
//         ExponentText[3] := Text16562;
//         ExponentText[4] := Text16563;
//         ExponentText[5] := '';
//     end;
// }