
pageextension 50024 "Item Ledger Entries Color Ext" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Color Code"; Rec."Color Code")
            {
                ApplicationArea = All;
                Caption = 'Color Code';
                Editable = false;
            }
            field("Color Name"; Rec."Color Name")
            {
                ApplicationArea = All;
                Caption = 'Color Name';
                Editable = false;
            }
        }
    }
}
