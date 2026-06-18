
pageextension 50101 "Vendor Ledger Entry Aadhar PBS" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;
                Caption = 'Aadhar No.';
                Editable = false;
            }
        }
    }
}
