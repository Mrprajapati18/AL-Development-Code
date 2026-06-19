
// report 60507 "Voucher Wise Ledger "  // Durgesh 09062026
// {
//     ApplicationArea = All;
//     Caption = 'Voucher Wise Ledger';
//     UsageCategory = ReportsAndAnalysis;
//     RDLCLayout = 'Layouts\VoucherWiseLegerReport.rdl';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem("CustLedgerEntry"; "Cust. Ledger Entry")
//         {
//             RequestFilterFields = "Customer No.", "Global Dimension 1 Code";

//             column(runningbalance; runningbalance) { }
//             column(Document_Type; "Document Type") { }
//             column(CompanyInformPics; CompanyInformation.Picture) { }
//             column(CompanyName; CompanyInformation.Name) { }
//             column(CompanyAddress; CompanyInformation.Address) { }
//             column(CompanyAddress2; CompanyInformation."Address 2") { }
//             column(CompanyCity; CompanyInformation.City) { }
//             column(CompanyState; CompanyInformation.County) { }
//             column(CompanyPinCode; CompanyInformation."Post Code") { }
//             column(Customer_No_; "Customer No.") { }
//             column(AccountingBranch; GetFilter("Global Dimension 1 Code")) { }

//             // Location Address
//             column(LocAddress; LocAddress) { }
//             column(LocAddress2; LocAddress2) { }
//             column(LocCity; LocCity) { }
//             column(LocPostCode; LocPostCode) { }
//             column(LocState; LocState) { }
//             column(LocStateName; LocStateName) { }

//             column(RunningBalanceText; RunningBalanceText) { }
//             column(OpeningBalanceText; OpeningBalanceText) { }
//             column(DocumentTypeText; DocumentTypeText) { }
//             column(CustomerName; CustomerName) { }
//             column(CustAddress; CustAddress) { }
//             column(CustAddress2; CustAddress2) { }
//             column(CustCity; CustCity) { }
//             column(CustPostCode; CustPostCode) { }
//             column(CustState; CustState) { }
//             column(CustStateName; CustStateName) { }
//             column(Posting_Date; "Posting Date") { }
//             column(Credit_Amount__LCY_; "Credit Amount (LCY)") { }
//             column(Debit_Amount__LCY_; "Debit Amount (LCY)") { }
//             column(StartDate; StartDate) { }
//             column(EndDate; EndDate) { }
//             column(OpeningDebit; OpeningDebit) { }
//             column(OpeningCredit; OpeningCredit) { }
//             column(OpeningBalance; OpeningBalance) { }
//             column(Document_No_; "Document No.") { }
//             column(Description_; Description) { }
//             column(NetAmount; NetAmount) { }

//             trigger OnPreDataItem()
//             begin
//                 CompanyInformation.Get();
//                 CompanyInformation.CalcFields(Picture);

//                 if StartDate = 0D then
//                     Error('Please enter Start Date.');

//                 if EndDate = 0D then
//                     Error('Please enter End Date.');

//                 if StartDate > EndDate then
//                     Error('Start Date cannot be greater than End Date.');

//                 // Document Type Filter
//                 SetFilter("Document Type", '%1|%2|%3|%4|%5',
//                     "Document Type"::"Credit Memo",
//                     "Document Type"::Invoice,
//                     "Document Type"::Payment,
//                     "Document Type"::Refund,
//                     "Document Type"::" ");

//                 Clear(OpeningBalance);
//                 Clear(OpeningDebit);
//                 Clear(OpeningCredit);

//                 CustLedgerEntryOpening.Reset();

//                 if GetFilter("Customer No.") <> '' then
//                     CustLedgerEntryOpening.SetFilter("Customer No.", GetFilter("Customer No."));

//                 if GetFilter("Global Dimension 1 Code") <> '' then
//                     CustLedgerEntryOpening.SetFilter("Global Dimension 1 Code", GetFilter("Global Dimension 1 Code"));

//                 CustLedgerEntryOpening.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', StartDate));

//                 // Same Document Type filter
//                 CustLedgerEntryOpening.SetFilter("Document Type", '%1|%2|%3|%4|%5',
//                     CustLedgerEntryOpening."Document Type"::"Credit Memo",
//                     CustLedgerEntryOpening."Document Type"::Invoice,
//                     CustLedgerEntryOpening."Document Type"::Payment,
//                     CustLedgerEntryOpening."Document Type"::Refund,
//                     CustLedgerEntryOpening."Document Type"::" ");

//                 if CustLedgerEntryOpening.FindSet() then
//                     repeat
//                         CustLedgerEntryOpening.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
//                         OpeningDebit += CustLedgerEntryOpening."Debit Amount (LCY)";
//                         OpeningCredit += CustLedgerEntryOpening."Credit Amount (LCY)";
//                         OpeningBalance += CustLedgerEntryOpening."Debit Amount (LCY)" - CustLedgerEntryOpening."Credit Amount (LCY)";
//                     until CustLedgerEntryOpening.Next() = 0;

//                 if OpeningBalance < 0 then
//                     OpeningBalanceText := 'Cr'
//                 else
//                     OpeningBalanceText := 'Dr';

//                 SetCurrentKey("Document Type");
//                 SetAscending("Document Type", true);
//                 SetRange("Posting Date", StartDate, EndDate);
//                 runningbalance := OpeningBalance;
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");

//                 // Customer Details
//                 if Customer.Get("Customer No.") then begin
//                     CustomerName := Customer.Name;
//                     CustAddress := Customer.Address;
//                     CustAddress2 := Customer."Address 2";
//                     CustCity := Customer.City;
//                     CustPostCode := Customer."Post Code";
//                     CustState := Customer.County;

//                     Clear(CustStateName);
//                     if StateRec.Get(Customer."State Code") then
//                         CustStateName := StateRec.Description;
//                 end;

//                 // From Location Address 
//                 Clear(LocAddress);
//                 Clear(LocAddress2);
//                 Clear(LocCity);
//                 Clear(LocPostCode);
//                 Clear(LocState);
//                 Clear(LocStateName);

//                 if LocationRec.Get("Location Code") then begin
//                     LocAddress := LocationRec.Address;
//                     LocAddress2 := LocationRec."Address 2";
//                     LocCity := LocationRec.City;
//                     LocPostCode := LocationRec."Post Code";
//                     LocState := LocationRec.County;

//                     if StateRec.Get(LocationRec."State Code") then
//                         LocStateName := StateRec.Description;
//                 end;

//                 runningbalance := runningbalance + "Debit Amount (LCY)" - "Credit Amount (LCY)";
//                 if runningbalance < 0 then
//                     RunningBalanceText := 'Cr'
//                 else
//                     RunningBalanceText := 'Dr';
//                 if OpeningBalance < 0 then
//                     OpeningBalanceText := 'Cr'
//                 else
//                     OpeningBalanceText := 'Dr';

//                 DocumentTypeText := Format("Document Type");
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
//                 group(DateFilter)
//                 {
//                     Caption = 'Date Filter';

//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Start Date';
//                     }

//                     field(EndDate; EndDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'End Date';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(Processing)
//             {
//             }
//         }
//     }

//     var
//         CompanyInformation: Record "Company Information";
//         Customer: Record Customer;
//         StateRec: Record State;
//         CustLedgerEntryOpening: Record "Cust. Ledger Entry";

//         CustomerName: Text[100];
//         CustAddress: Text[100];
//         CustAddress2: Text[100];
//         CustCity: Text[50];
//         CustPostCode: Code[20];
//         CustState: Text[50];
//         CustStateName: Text[50];

//         StartDate: Date;
//         EndDate: Date;

//         CustomerNo: Code[20];
//         NetAmount: Decimal;
//         OpeningBalance: Decimal;
//         OpeningDebit: Decimal;
//         OpeningCredit: Decimal;
//         runningbalance: Decimal;

//         DebitAmountDisplay: Text[30];
//         CreditAmountDisplay: Text[30];

//         DayWiseReport: Boolean;
//         MonthWiseReport: Boolean;
//         VoucherWiseLedger: Boolean;
//         RunningBalanceText: Text[30];
//         OpeningBalanceText: Text[30];
//         DocumentTypeText: Text[30];
//         LocationRec: Record Location;
//         LocAddress: Text[100];
//         LocAddress2: Text[100];
//         LocCity: Text[50];
//         LocPostCode: Code[20];
//         LocState: Text[50];
//         LocStateName: Text[50];

// }



report 60507 "Voucher Wise Ledger "  // Durgesh 09062026
{
    ApplicationArea = All;
    Caption = 'Voucher Wise Ledger';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts\VoucherWiseLegerReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("CustLedgerEntry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.", "Global Dimension 1 Code";

            column(runningbalance; runningbalance) { }
            column(Document_Type; "Document Type") { }
            column(CompanyInformPics; CompanyInformation.Picture) { }
            column(CompanyName; CompanyInformation.Name) { }
            column(CompanyAddress; CompanyInformation.Address) { }
            column(CompanyAddress2; CompanyInformation."Address 2") { }
            column(CompanyCity; CompanyInformation.City) { }
            column(CompanyState; CompanyInformation.County) { }
            column(CompanyPinCode; CompanyInformation."Post Code") { }
            column(Customer_No_; "Customer No.") { }
            column(AccountingBranch; GetFilter("Global Dimension 1 Code")) { }

            // Location Address
            column(LocAddress; LocAddress) { }
            column(LocAddress2; LocAddress2) { }
            column(LocCity; LocCity) { }
            column(LocPostCode; LocPostCode) { }
            column(LocState; LocState) { }
            column(LocStateName; LocStateName) { }

            column(RunningBalanceText; RunningBalanceText) { }
            column(OpeningBalanceText; OpeningBalanceText) { }
            column(DocumentTypeText; DocumentTypeText) { }
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
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(OpeningDebit; OpeningDebit) { }
            column(OpeningCredit; OpeningCredit) { }
            column(OpeningBalance; OpeningBalance) { }
            column(Document_No_; "Document No.") { }
            column(Description_; Description) { }
            column(NetAmount; NetAmount) { }

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

                // Document Type Filter
                SetFilter("Document Type", '%1|%2|%3|%4|%5',
                    "Document Type"::"Credit Memo",
                    "Document Type"::Invoice,
                    "Document Type"::Payment,
                    "Document Type"::Refund,
                    "Document Type"::" ");

                Clear(OpeningBalance);
                Clear(OpeningDebit);
                Clear(OpeningCredit);

                CustLedgerEntryOpening.Reset();

                if GetFilter("Customer No.") <> '' then
                    CustLedgerEntryOpening.SetFilter("Customer No.", GetFilter("Customer No."));

                if GetFilter("Global Dimension 1 Code") <> '' then
                    CustLedgerEntryOpening.SetFilter("Global Dimension 1 Code", GetFilter("Global Dimension 1 Code"));

                CustLedgerEntryOpening.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', StartDate));

                // Same Document Type filter
                CustLedgerEntryOpening.SetFilter("Document Type", '%1|%2|%3|%4|%5',
                    CustLedgerEntryOpening."Document Type"::"Credit Memo",
                    CustLedgerEntryOpening."Document Type"::Invoice,
                    CustLedgerEntryOpening."Document Type"::Payment,
                    CustLedgerEntryOpening."Document Type"::Refund,
                    CustLedgerEntryOpening."Document Type"::" ");

                if CustLedgerEntryOpening.FindSet() then
                    repeat
                        CustLedgerEntryOpening.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                        OpeningDebit += CustLedgerEntryOpening."Debit Amount (LCY)";
                        OpeningCredit += CustLedgerEntryOpening."Credit Amount (LCY)";
                        OpeningBalance += CustLedgerEntryOpening."Debit Amount (LCY)" - CustLedgerEntryOpening."Credit Amount (LCY)";
                    until CustLedgerEntryOpening.Next() = 0;

                if OpeningBalance < 0 then
                    OpeningBalanceText := 'Cr'
                else
                    OpeningBalanceText := 'Dr';

                SetCurrentKey("Document Type");
                SetAscending("Document Type", true);
                SetRange("Posting Date", StartDate, EndDate);
                runningbalance := OpeningBalance;
            end;

            trigger OnAfterGetRecord()
            begin
                CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");

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

                runningbalance := runningbalance + "Debit Amount (LCY)" - "Credit Amount (LCY)";
                if runningbalance < 0 then
                    RunningBalanceText := 'Cr'
                else
                    RunningBalanceText := 'Dr';
                if OpeningBalance < 0 then
                    OpeningBalanceText := 'Cr'
                else
                    OpeningBalanceText := 'Dr';


                Clear(VoucherDocType);
                if VoucherDocType.Get("Document Type") then
                    DocumentTypeText := VoucherDocType."Custom Document Type"
                else
                    DocumentTypeText := Format("Document Type");
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
        DocumentTypeText: Text[30];
        LocationRec: Record Location;
        LocAddress: Text[100];
        LocAddress2: Text[100];
        LocCity: Text[50];
        LocPostCode: Code[20];
        LocState: Text[50];
        LocStateName: Text[50];
        VoucherDocType: Record "Voucher Document Type";

}
