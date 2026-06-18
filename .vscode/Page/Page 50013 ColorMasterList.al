
page 50100 "Color Master List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Color Master";
    Caption = 'Color Master';
    CardPageId = "Color Master Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;

                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ExportColors)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                ToolTip = 'Color Master data export';
                trigger OnAction()
                begin
                    Message('Export functionality implement as per requirement.');
                end;
            }
        }
    }
}
