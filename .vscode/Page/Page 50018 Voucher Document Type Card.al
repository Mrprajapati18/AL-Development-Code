page 50018 "Voucher Document Type card"
{
    ApplicationArea = All;
    Caption = 'Voucher Document Type Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Voucher Document Type";

    layout
    {
        area(Content)
        {
            group("Voucher Document Type")
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