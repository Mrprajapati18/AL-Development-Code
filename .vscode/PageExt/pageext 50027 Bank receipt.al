pageextension 50027 "Bank Rceipt Line" extends "Bank Receipt Voucher"
{
    layout
    {
        addafter("Account No.")
        {
            field("Aadhar No"; Rec."Aadhar No")
            {
                ApplicationArea = All;
                Caption = 'Aadhar No.';
            }
        }
    }
}