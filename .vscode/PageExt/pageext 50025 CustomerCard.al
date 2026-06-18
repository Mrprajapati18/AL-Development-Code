pageextension 50025 "Customer card PBS1" extends 21
{
    layout
    {
        addafter(Name)
        {
            field("Aadhar No"; Rec."Aadhar No.")
            {
                ApplicationArea = all;
                Caption = 'Aadhar No.';
            }
        }
    }
}