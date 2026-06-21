Report 50400 "Item Wise Inward & OutwardNew"
{
    UsageCategory = ReportsAndAnalysis;
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    RDLCLayout = 'Layouts\ItemWiseInward&OutwardNew_1.rdl';
    DefaultLayout = RDLC;
    Caption = 'Inward & Outward';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", "Posting Date") order(ascending) where("Entry Type" = filter(<> Transfer));
            RequestFilterFields = "Item No.", "Posting Date";

            column(HideForAll; HideForAll)
            {
            }
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemName; Item.Description)
            {
            }
            Column(PSI_Temp; '')
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Date; Format("Item Ledger Entry"."Posting Date"))
            {
            }
            column(EntryType; "Item Ledger Entry"."Entry Type")
            {
            }
            column(VendoName; VendorName)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(CustHandle; CustHandle)
            {
            }
            column(Station; '')
            {
            }
            column(VchType; "Item Ledger Entry"."Entry Type")
            {
            }
            column(VchType2; "Item Ledger Entry"."Document Type")
            {
            }
            column(VchNo; "Item Ledger Entry"."External Document No.")
            {
            }
            column(Qty; "Item Ledger Entry".Quantity)
            {
            }
            column(OutwordAmnt; OutwordAmnt)
            {
            }
            column(InwordAmnt; InwordAmnt)
            {
            }
            column(RemaningQty; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(RemaningAmnt; CostAmnt_p)
            {
                AutoCalcField = true;
            }
            column(CompanyName; Companyinfo.Name)
            {
            }
            column(CompanyAddress; Companyinfo.Address)
            {
            }
            column(CompayAddress2; Companyinfo."Address 2")
            {
            }
            column(CompanyCity; Companyinfo.City)
            {
            }
            column(Companypostcode; Companyinfo."Post Code")
            {
            }
            column(CompanyGST; Companyinfo."GST Registration No.")
            {
            }
            column(OpeningValue; OpeningValue)
            {
            }
            column(RunValue; RunValue)
            {
            }
            column(InQty; InQty)
            {
            }
            column(OutQty; OutQty)
            {
            }
            column(RunValueAmt; RunValueAmt)
            {
            }
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(AllFilter; AllFilter)
            {
            }
            column(Rate; InRate)
            {
            }
            column(OutRate; OutRate)
            {
            }
            trigger OnPreDataItem();
            begin

                RunValue += "Item Ledger Entry".Quantity;
                OpeningValue := 0;
                OpeningAmt := 0;
                ClosingValue := 0;
                ClosingAmt := 0;
                RunValue := 0;
                RunValueAmt := 0;


                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Please enter the Start Date End Date ');

                CurrentItemNoFilter := "Item Ledger Entry".GetFilter("Item No.");
                CurrentLocationCodeFilter := "Item Ledger Entry".GetFilter("Location Code");

                TempItemLedgerEntry.Reset();

                if CurrentItemNoFilter <> '' then
                    TempItemLedgerEntry.SetFilter("Item No.", CurrentItemNoFilter);

                if CurrentLocationCodeFilter <> '' then
                    TempItemLedgerEntry.SetFilter("Location Code", CurrentLocationCodeFilter);

                TempItemLedgerEntry.SetRange("Posting Date", 0D, StartDate - 1);

                if TempItemLedgerEntry.FindSet() then begin
                    repeat
                        TempItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                        OpeningValue += TempItemLedgerEntry.Quantity;
                        OpeningAmt += TempItemLedgerEntry."Cost Amount (Actual)";
                    until TempItemLedgerEntry.Next() = 0;
                end;


                TempItemLedgerEntry.Reset();

                if CurrentItemNoFilter <> '' then
                    TempItemLedgerEntry.SetFilter("Item No.", CurrentItemNoFilter);

                if CurrentLocationCodeFilter <> '' then
                    TempItemLedgerEntry.SetFilter("Location Code", CurrentLocationCodeFilter);


                TempItemLedgerEntry.SetRange("Posting Date", 0D, EndDate);

                if TempItemLedgerEntry.FindSet() then begin
                    repeat
                        TempItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                        ClosingValue += TempItemLedgerEntry.Quantity;
                        ClosingAmt += TempItemLedgerEntry."Cost Amount (Actual)";
                    until TempItemLedgerEntry.Next() = 0;
                end;


                SetRange("Posting Date", StartDate, EndDate);


                RunValue := OpeningValue;
                RunValueAmt := OpeningAmt;

                AllFilter := GetFilters;
                Clear(UserSetup);
                if UserSetup.Get(UserId) then begin
                    HideForAll := true;
                    // if (UserSetup."Type of User" in [UserSetup."Type of User"::Admin, UserSetup."Type of User"::Purchase]) or (UserId = 'SUMIT') then
                    HideForAll := false;
                end;
            end;

            trigger OnAfterGetRecord();
            var
                ValueEntry_gRec: Record "Value Entry";
            begin

                CustomerName := '';
                VendorName := '';
                CostAmnt_p := 0;
                CustHandle := '';
                Station := '';
                InQty := 0;
                OutQty := 0;
                InwordAmnt := 0;
                OutwordAmnt := 0;
                InRate := 0;
                OutRate := 0;


                if Item.Get("Item No.") then;
                if Customer.Get("Source No.") then begin
                    CustomerName := Customer.Name;
                    // CustHandle := Customer.CustomerHandlyByName;
                    // Station := Customer.Station;
                end else
                    if Vendor.Get("Source No.") then
                        VendorName := Vendor.Name;


                ValueEntry_gRec.Reset();
                ValueEntry_gRec.SetRange("Item Ledger Entry No.", "Entry No.");
                if ValueEntry_gRec.FindFirst() then
                    CostAmnt_p := Round(ValueEntry_gRec."Cost per Unit" * "Remaining Quantity", 0.01);

                CalcFields("Cost Amount (Actual)", "Sales Amount (Actual)");

                if Positive then begin
                    InQty := Quantity;
                    InwordAmnt := "Cost Amount (Actual)";
                    RunValueAmt += "Cost Amount (Actual)";
                    if InQty <> 0 then
                        InRate := InwordAmnt / InQty;
                end else begin
                    OutQty := Quantity;
                    OutwordAmnt := "Sales Amount (Actual)";
                    RunValueAmt -= "Sales Amount (Actual)";
                    if OutQty <> 0 then
                        OutRate := OutwordAmnt / OutQty;
                end;


                RunValue += Quantity;


            end;
            //  end;

        }

    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = Basic;
                }



            }
        }

        actions
        {
        }

    }

    trigger OnInitReport()
    begin

        TodayMonth := Date2dmy(today, 2);
        if TodayMonth in [1, 2, 3] then begin
            StartDate := Dmy2date(1, 4, Date2dmy(today, 3) - 1);
        end else begin
            StartDate := Dmy2date(1, 4, Date2dmy(today, 3));
        end;

        //   StartDate := 20210401D;
        EndDate := Today;
        AllFilter := '';
        HideForAll := true;



    end;


    var
        US: Record "User Setup";
        HideForAll: Boolean;

        TodayMonth: Integer;
        Item: Record Item;
        TempItem: Record "Item";
        Customer: Record Customer;
        Vendor: Record Vendor;
        ItemLedgerEntry: Record "Item Ledger Entry";
        CustInword: Integer;
        CustQty: Decimal;
        Type: Option;
        VendOutword: Integer;
        VendQty: Decimal;
        ClosingQty: Integer;
        CloseAmnt: Decimal;
        VendorName: Text;
        CustomerName: Text;
        PurBool: Boolean;
        SaleBool: Boolean;
        ValueEntry_gRec: Record "Value Entry";
        CostAmnt_p: Decimal;
        Companyinfo: Record "Company Information";
        OpeningValue: Decimal;
        StartDate: Date;
        EndDate: Date;
        InQty: Decimal;
        OutQty: Decimal;
        RunValue: Decimal;
        RunValueAmt: Decimal;
        OpeningAmt: Decimal;
        AllFilter: Text;
        OutwordAmnt: Decimal;
        InwordAmnt: Decimal;
        InRate: Decimal;
        OutRate: Decimal;
        CustHandle: Text;
        Station: Text;
        ClosingValue: Decimal;
        ClosingAmt: Decimal; // Closing balance variable for total quantity and amount

        TempItemLedgerEntry: Record "Item Ledger Entry";
        CurrentItemNoFilter: Text;          // Item No. filter store karne ke liye
        CurrentLocationCodeFilter: Text;
        UserSetup: Record "User Setup";

}
