
pageextension 50023 "Value Entries Color Ext" extends "Value Entries"
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
