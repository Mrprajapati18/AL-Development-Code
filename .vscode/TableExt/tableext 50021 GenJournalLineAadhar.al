
tableextension 50101 "Gen. Journal Line Aadhar Ext" extends "Gen. Journal Line"
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
