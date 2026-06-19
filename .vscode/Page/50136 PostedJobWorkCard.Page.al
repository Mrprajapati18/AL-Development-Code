page 50141 "Posted Job Work Card"
{
    PageType = Card;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Job Work Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                grid(Mygrid)
                {
                    group(Outward)
                    {
                        // field("No."; Rec."No.")
                        // {
                        //     ApplicationArea = All;

                        // }
                        field("Outward challan No."; Rec."Outward challan No.")
                        {
                            ApplicationArea = All;

                        }
                        field("Outward Gst No."; Rec."Outward Gst No.")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Outward State"; Rec."Outward State")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Outward Type"; Rec."Outward Type")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Outward Date"; Rec."Outward Date")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("JobWork Location Code"; Rec."JobWork Location Code")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("JobWork Location Name";Rec."JobWork Location Name")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }

                    group(Inward)
                    {
                        // grid(Mygrid2)
                        // {
                        // group(gridform)
                        // {
                        field("Inward challan No."; Rec."Inward challan No.")
                        {
                            ApplicationArea = All;
                        }
                        field("Inward Gst"; Rec."Inward Gst")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Inward State"; Rec."Inward State")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Inward Type"; Rec."Inward Type")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Inward Date"; Rec."Inward Date")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }

                        // }

                        // }

                    }
                }
            }
            part(JobWork; "Job Work List Part")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
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
                var

                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}