report 60506 "Month Wise Ledger" // Durgesh 09062026
{
    ApplicationArea = All;
    Caption = 'Month Wise Ledger';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts\MonthWiseLedReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("CustLedgerEntry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.", "Global Dimension 1 Code";

            column(runningbalance; runningbalance) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyInformPics; CompanyInformation.Picture) { }
            column(CompanyAddress; CompanyInformation.Address) { }
            column(CompanyAddress2; CompanyInformation."Address 2") { }
            column(CompanyCity; CompanyInformation.City) { }
            column(CompanyState; CompanyInformation.County) { }
            column(CompanyPinCode; CompanyInformation."Post Code") { }
            column(Customer_No_; "Customer No.") { }
            column(AccountingBranch; "Global Dimension 1 Code") { }
            column(RunningBalanceText; RunningBalanceText) { }

            // Location Address
            column(LocAddress; LocAddress) { }
            column(LocAddress2; LocAddress2) { }
            column(LocCity; LocCity) { }
            column(LocPostCode; LocPostCode) { }
            column(LocState; LocState) { }
            column(LocStateName; LocStateName) { }


            column(OpeningBalanceText; OpeningBalanceText) { }
            column(CustomerName; CustomerName) { }
            column(CustAddress; CustAddress) { }
            column(CustAddress2; CustAddress2) { }
            column(CustCity; CustCity) { }
            column(CustPostCode; CustPostCode) { }
            column(CustState; CustState) { }
            column(CustStateName; CustStateName) { }

            column(Posting_Date; "Posting Date") { }
            column(Credit_Amount__LCY_; "Credit Amount (LCY)") { }
            column(Debit_Amount__LCY_; "Debit Amount (LCY)") { }

            column(NetAmount; NetAmount) { }

            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }

            column(OpeningDebit; OpeningDebit) { }
            column(OpeningCredit; OpeningCredit) { }
            column(OpeningBalance; OpeningBalance) { }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                if StartDate = 0D then
                    Error('Please enter Start Date.');

                if EndDate = 0D then
                    Error('Please enter End Date.');

                if StartDate > EndDate then
                    Error('Start Date cannot be greater than End Date.');

                Clear(OpeningBalance);
                Clear(OpeningDebit);
                Clear(OpeningCredit);

                CustLedgerEntryOpening.Reset();
                CustLedgerEntryOpening.CopyFilters("CustLedgerEntry");
                CustLedgerEntryOpening.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', StartDate));

                if CustLedgerEntryOpening.FindSet() then
                    repeat
                        CustLedgerEntryOpening.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                        OpeningDebit += CustLedgerEntryOpening."Debit Amount (LCY)";
                        OpeningCredit += CustLedgerEntryOpening."Credit Amount (LCY)";
                        OpeningBalance += CustLedgerEntryOpening."Debit Amount (LCY)" - CustLedgerEntryOpening."Credit Amount (LCY)";
                    until CustLedgerEntryOpening.Next() = 0;

                SetCurrentKey("Posting Date");
                SetAscending("Posting Date", true);
                SetRange("Posting Date", StartDate, EndDate);
                runningbalance := OpeningBalance;

            end;

            trigger OnAfterGetRecord()
            begin

                CustLedgerEntry.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");

                // Customer Details
                if Customer.Get("Customer No.") then begin
                    CustomerName := Customer.Name;
                    CustAddress := Customer.Address;
                    CustAddress2 := Customer."Address 2";
                    CustCity := Customer.City;
                    CustPostCode := Customer."Post Code";
                    CustState := Customer.County;

                    Clear(CustStateName);
                    if StateRec.Get(Customer."State Code") then
                        CustStateName := StateRec.Description;
                end;

                // From Location Address 
                Clear(LocAddress);
                Clear(LocAddress2);
                Clear(LocCity);
                Clear(LocPostCode);
                Clear(LocState);
                Clear(LocStateName);

                if LocationRec.Get("Location Code") then begin
                    LocAddress := LocationRec.Address;
                    LocAddress2 := LocationRec."Address 2";
                    LocCity := LocationRec.City;
                    LocPostCode := LocationRec."Post Code";
                    LocState := LocationRec.County;

                    if StateRec.Get(LocationRec."State Code") then
                        LocStateName := StateRec.Description;
                end;


                // Net Amount aur Running Balance
                NetAmount := "Debit Amount (LCY)" - "Credit Amount (LCY)";
                runningbalance := runningbalance + "Debit Amount (LCY)" - "Credit Amount (LCY)";


                // Running Balance
                if runningbalance < 0 then
                    RunningBalanceText := 'Cr'
                else
                    RunningBalanceText := 'Dr';

                // Opening Balance 
                if OpeningBalance < 0 then
                    OpeningBalanceText := 'Cr'
                else
                    OpeningBalanceText := 'Dr';


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
                group(DateFilter)
                {
                    Caption = 'Date Filter';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
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
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        StateRec: Record State;
        CustLedgerEntryOpening: Record "Cust. Ledger Entry";

        CustomerName: Text[100];
        CustAddress: Text[100];
        CustAddress2: Text[100];
        CustCity: Text[50];
        CustPostCode: Code[20];
        CustState: Text[50];
        CustStateName: Text[50];

        StartDate: Date;
        EndDate: Date;

        CustomerNo: Code[20];
        NetAmount: Decimal;
        OpeningBalance: Decimal;
        OpeningDebit: Decimal;
        OpeningCredit: Decimal;
        runningbalance: Decimal;

        DebitAmountDisplay: Text[30];
        CreditAmountDisplay: Text[30];

        DayWiseReport: Boolean;
        MonthWiseReport: Boolean;
        VoucherWiseLedger: Boolean;
        RunningBalanceText: Text[30];
        OpeningBalanceText: Text[30];
        LocationRec: Record Location;
        LocAddress: Text[100];
        LocAddress2: Text[100];
        LocCity: Text[50];
        LocPostCode: Code[20];
        LocState: Text[50];
        LocStateName: Text[50];


}