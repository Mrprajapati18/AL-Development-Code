
pageextension 50026 "Item Card Color Ext" extends "Item Card"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            group(ColorGroup)
            {
                Caption = 'Color Information';
                ShowCaption = true;

                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';
                    ToolTip = 'Color Master se Color Code select karein';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ColorMaster: Record "Color Master";
                        ColorMasterList: Page "Color Master List";
                    begin
                        ColorMasterList.LookupMode(true);
                        if ColorMasterList.RunModal() = Action::LookupOK then begin
                            ColorMasterList.GetRecord(ColorMaster);
                            Rec.Validate("Color Code", ColorMaster."Color Code");
                        end;
                    end;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color Name';
                    Editable = false;
                    StyleExpr = ColorNameStyle;
                }
            }
        }
    }

    var
        ColorNameStyle: Text;

    trigger OnAfterGetRecord()
    begin
        if Rec."Color Code" <> '' then
            ColorNameStyle := 'Favorable'
        else
            ColorNameStyle := 'None';
    end;
}
