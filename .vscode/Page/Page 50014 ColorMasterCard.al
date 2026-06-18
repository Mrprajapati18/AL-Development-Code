
page 50014 "Color Master Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Color Master";
    Caption = 'Color Master Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
}
