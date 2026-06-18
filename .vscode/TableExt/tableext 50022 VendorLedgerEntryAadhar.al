
tableextension 50102 "Vendor Ledger Entry Aadhar Ext" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100; "Aadhar No."; Code[12])
        {
            Caption = 'Aadhar No.';
            DataClassification = CustomerContent;
        }
    }
}
