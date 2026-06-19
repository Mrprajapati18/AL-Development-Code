pageextension 50001 "Sales And Receivable" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Invoice Nos.")
        {
            field("Job Work Challan No."; Rec."Job Work Challan No.")
            {
                ApplicationArea = All;
            }

        }
    }
}