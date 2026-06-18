
tableextension 50024 "Item Ledger Entry Color Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50100; "Color Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Code';
        }
        field(50101; "Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Name';
        }
    }
}
