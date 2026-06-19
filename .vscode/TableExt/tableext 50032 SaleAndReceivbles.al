tableextension 50032 "Sales Setup Job Work Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Job Work Challan No."; Code[20])
        {
            Caption = 'Job Work Challan No.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}