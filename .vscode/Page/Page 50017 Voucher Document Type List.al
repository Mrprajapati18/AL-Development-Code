Page 50017 "Voucher Docuemnt Type"
{
    PageType = List;
    Caption = 'Voucher Docuemnt Type';
    ApplicationArea = All;
    UsageCategory =  Lists;
    SourceTable = "Voucher Document Type";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Custom Document Type"; Rec."Custom Document Type")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}