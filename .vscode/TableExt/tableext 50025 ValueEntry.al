
tableextension 50025 "Value Entry Color Ext" extends "Value Entry"
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
         field(50102; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","B2B";
        }
    }
}
