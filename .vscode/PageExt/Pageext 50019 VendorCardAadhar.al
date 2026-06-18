
pageextension 50100 "Vendor Card Aadhar Ext" extends "Vendor Card"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;
                Caption = 'Aadhar No.';
                ToolTip = 'Fill the 12 digit Aadhar number here.';
            }
        }
    }
}
