page 50123 "Job Work List Part"
{
    PageType = ListPart;
    // ApplicationArea = All;
    // UsageCategory = Lists;
    SourceTable = "Job work Line";


    layout
    {
        area(Content)
        {
            grid(Mygrid)
            {
                repeater(Outward)
                {

                    // field("Outward Challan No."; Rec."Outward Challan No.")
                    // {
                    //     ApplicationArea = All;

                    // }
                    // field("Line No."; Rec."Line No.")
                    // {
                    //     ApplicationArea = All;

                    // }
                    field("Outward Item No."; Rec."Outward Item No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Item Discription"; Rec."Outward Item Discription")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Quantity"; Rec."Outward Quantity")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Unit of Measure"; Rec."Outward Unit of Measure")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Amount"; Rec."Outward Amount")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Types of goods"; Rec."Outward Types of goods")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward Discription of goods"; Rec."Outward Discription of goods")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward GST"; Rec."Outward GST")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward CGST"; Rec."Outward CGST")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward IGST"; Rec."Outward IGST")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Outward SGST"; Rec."Outward SGST")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }

                }
                repeater(Inward)
                {
                    field("Inward Item no."; Rec."Inward Item no.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Inward Item Description"; Rec."Inward Item Description")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Received Qty"; Rec."Received Qty")
                    {
                        Caption = 'Inward Quantity';
                        ApplicationArea = All;
                    }
                    field("Received UOM"; Rec."Received UOM")
                    {
                        Caption = 'Inward Unit Of Measure';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Balance Qty";Rec."Balance Qty")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Received Amount"; Rec."Received Amount")
                    {
                        Caption = 'Inward Amount';
                        ApplicationArea = All;

                    }

                    field("Inward Types of goods"; Rec."Inward Types of goods")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Inward Discription of goods"; Rec."Inward Discription of goods")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Inward GST"; Rec."Inward GST")
                    {
                        ApplicationArea = All;

                    }
                    field("Inward CGST"; Rec."Inward CGST")
                    {
                        ApplicationArea = All;
                    }
                    field("Inward IGST"; Rec."Inward IGST")
                    {
                        ApplicationArea = All;
                    }
                    field("Inward SGST"; Rec."Inward SGST")
                    {
                        ApplicationArea = All;
                    }



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