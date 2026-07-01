tableextension 50030 "Customer Ledger Entry Pbs" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "Aadhar No."; Code[12])
        {
            DataClassification = ToBeClassified;
            Caption = 'Aadhar No.';
        }
        field(50001; "Business Type"; Option)
        {
            OptionMembers = " ",SNS,B2B,B2C;
            DataClassification = ToBeClassified;
        }
    }
}