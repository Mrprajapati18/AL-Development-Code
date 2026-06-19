page 50122 "Job Work List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Job Work Header";
    CardPageId = 50121;
    SourceTableView = where(Posted = filter(false));


    layout
    {
        area(Content)
        {

            repeater(Outward)
            {

                // field("No."; Rec."No.")
                // {
                //     ApplicationArea = All;

                // }
                field("Outward challan No."; Rec."Outward challan No.")
                {
                    ApplicationArea = All;

                }
                // field("Outward Gst No."; Rec."Outward Gst No.")
                // {
                //     ApplicationArea = All;

                // }
                // field("Outward State"; Rec."Outward State")
                // {
                //     ApplicationArea = All;

                // }
                // field("Outward Type"; Rec."Outward Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Outward Date"; Rec."Outward Date")
                {
                    ApplicationArea = All;
                }

                // }
                // repeater(Inward)
                // {
                field("Inward challan No."; Rec."Inward challan No.")
                {
                    ApplicationArea = All;
                }
                // field("Inward Gst"; Rec."Inward Gst")
                // {
                //     ApplicationArea = All;
                // }
                // field("Inward State"; Rec."Inward State")
                // {
                //     ApplicationArea = All;
                // }
                // field("Inward Type"; Rec."Inward Type")
                // {
                //     ApplicationArea = All;
                // }
                field("Inward Date"; Rec."Inward Date")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}