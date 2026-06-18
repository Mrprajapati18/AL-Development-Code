
pageextension 50102 "Bank PaymentVoucher Aadhar PBS" extends "Bank Payment Voucher"
{
    layout
    {
        addafter("Document No.")
        {
            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;
                Caption = 'Aadhar No.';
                Editable = false;
            }
        }
    }
}
