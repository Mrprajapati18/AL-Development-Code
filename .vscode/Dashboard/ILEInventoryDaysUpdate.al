report 50183 "ILE Inventory Days Update"
{
    ApplicationArea = All;
    Caption = 'ILE Inventory Days Update';
    UsageCategory = ReportsAndAnalysis;
    Permissions = tabledata "Item Ledger Entry" = RM,
                  tabledata "Sent Email" = RMD;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                ItemLedgerEntry.SetRange(Open, true);
            end;

            trigger OnAfterGetRecord()
            var
                item: Record Item;
            begin
                ItemLedgerEntry."Inventory Days" := Today - ItemLedgerEntry."Posting Date";
                ItemLedgerEntry.Modify();

                item.Reset();
                item.SetRange("No.", ItemLedgerEntry."Item No.");
                if item.FindFirst() then begin
                    ItemLedgerEntry."Item Category Code" := item."Item Category Code";
                    ItemLedgerEntry.Modify();
                end;
            end;
        }
        dataitem("Sent Email"; "Sent Email")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if "Sent Email".FindFirst() then
                    repeat
                        "Sent Email".Delete();
                        Commit();
                    until "Sent Email".Next() = 0;

            end;
        }
    }
}