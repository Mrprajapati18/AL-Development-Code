
codeunit 50004 "Color Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line",
                     'OnAfterValidateEvent', 'Item No.', false, false)]
    local procedure OnAfterValidateItemNoInJournal(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        Item: Record Item;
    begin
        if Rec."Item No." <> '' then begin
            if Item.Get(Rec."Item No.") then begin
                Rec."Color Code" := Item."Color Code";
                Rec."Color Name" := Item."Color Name";
            end;
        end else begin
            Rec."Color Code" := '';
            Rec."Color Name" := '';
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', false, false)]
    local procedure OnBeforeInsertValueEntry(var ValueEntry: Record "Value Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        ValueEntry."Color Code" := ItemJournalLine."Color Code";
        ValueEntry."Color Name" := ItemJournalLine."Color Name";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean)
    begin
        ItemLedgerEntry."Color Name" := ItemJournalLine."Color Name";
        ItemLedgerEntry."Color Code" := ItemJournalLine."Color Code";

    end;
}
