
pageextension 50022 "Item Journal Color Ext" extends "Item Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Color Code"; Rec."Color Code")
            {
                ApplicationArea = All;
                Caption = 'Color Code';
                ToolTip = 'Item se automatically aayega, ya manually change kar sakte hain';
            }
            field("Color Name"; Rec."Color Name")
            {
                ApplicationArea = All;
                Caption = 'Color Name';
                Editable = false;
                ToolTip = 'Color Code ke basis par automatically fill hoga';
            }
        }
    }
}
