page 50121 "Job Work Card"
{
    PageType = Card;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Job Work Header";

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
                            //Editable = false;
                        }

                        // }

                        // }

                    }
                }
            }
            part(JobWork; "Job Work List Part")
            {
                SubPageLink = "No." = field("No.");
                SubPageView = where(Posted = filter(false));
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    JobWorkLine: Record "Job work Line";
                begin
                    JobWorkLine.SetRange("No.", Rec."No.");
                    if JobWorkLine.FindFirst() then begin
                        repeat
                            JobWorkLine.Posted := true;
                            JobWorkLine.Modify(true);
                        until JobWorkLine.Next() = 0;
                    end;
                    Rec.Posted := true;

                    Message('Document Posted');
                end;
            }
        }
    }

    var
        myInt: Integer;
}