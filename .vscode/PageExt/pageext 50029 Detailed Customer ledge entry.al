pageextension 50029 "Detailed customer Ledger entry" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Aadhar No"; Rec."Aadhar No.")
            {
                ApplicationArea = All;
                Caption = 'Aadhar No.';
            }
        }
    }
}