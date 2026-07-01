tableextension 50036 "ILE Dashboard Fields" extends "Item Ledger Entry"
{
    fields
    {
        field(50190; "Inventory Days"; Integer)
        {
            Caption = 'Inventory Days';
            DataClassification = CustomerContent;
        }
        field(50191; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            OptionMembers = "Stock & Sales",B2B,Blank;
            OptionCaption = 'Stock & Sales,B2B,Blank';
            DataClassification = CustomerContent;
        }
    }
}
