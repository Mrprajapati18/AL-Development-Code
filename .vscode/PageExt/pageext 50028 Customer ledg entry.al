pageextension 50028 "Customer Ledg entry Pbs" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer Name")
        {
            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;
            }

        }
    }
}