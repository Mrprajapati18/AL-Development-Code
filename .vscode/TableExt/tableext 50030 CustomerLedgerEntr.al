tableextension 50030 "Customer Ledger Entry Pbs" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Aadhar No."; Code[12])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aadhar No.';
        }
    }
}