report 50003 "Getdata And Set Date report"
{
    ApplicationArea = All;
    Caption = 'Getdata And Set Date report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\GetDataSetdata.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(ItemNo; "Item No.")
            {
            }
            column(ItemDescription; "Item Description")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
