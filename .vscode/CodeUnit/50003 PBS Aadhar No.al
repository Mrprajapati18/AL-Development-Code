
codeunit 50100 "Aadhar No. Event Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure OnAfterValidateAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    var
        Vendor: Record Vendor;
    begin
        if Rec."Account Type" <> Rec."Account Type"::Vendor then
            exit;
        if Rec."Account No." = '' then begin
            Rec."Aadhar No." := '';
            exit;
        end;
        if Vendor.Get(Rec."Account No.") then
            Rec."Aadhar No." := Vendor."Aadhar No."
        else
            Rec."Aadhar No." := '';
    end;
    // Gen. Journal Line 
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account Type', false, false)]
    local procedure OnAfterValidateAccountType(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    begin
        if Rec."Account Type" <> Rec."Account Type"::Vendor then
            Rec."Aadhar No." := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure OnAfterInitVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Aadhar No." := GenJournalLine."Aadhar No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Bal. Account No.', false, false)]
    local procedure OnAfterValidateBalAccountNo(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line")
    var
        Vendor: Record Vendor;
    begin
        if Rec."Bal. Account Type" <> Rec."Bal. Account Type"::Vendor then
            exit;

        if Rec."Bal. Account No." = '' then begin
            Rec."Aadhar No." := '';
            exit;
        end;
        if Vendor.Get(Rec."Bal. Account No.") then begin
            if Rec."Aadhar No." = '' then
                Rec."Aadhar No." := Vendor."Aadhar No.";
        end;
    end;




    // For Customer
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line",
        'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure OnAfterValidateAccountNo_Customer(
        var Rec: Record "Gen. Journal Line";
        var xRec: Record "Gen. Journal Line")
    var
        Customer: Record Customer;
    begin
        if Rec."Account Type" <> Rec."Account Type"::Customer then
            exit;

        if Rec."Account No." = '' then begin
            Rec."Aadhar No." := '';
            exit;
        end;

        if Customer.Get(Rec."Account No.") then
            Rec."Aadhar No." := Customer."Aadhar No."
        else
            Rec."Aadhar No." := '';
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line",
        'OnAfterValidateEvent', 'Account Type', false, false)]
    local procedure OnAfterValidateAccountType_Customer(
        var Rec: Record "Gen. Journal Line";
        var xRec: Record "Gen. Journal Line")
    begin
        if Rec."Account Type" <> Rec."Account Type"::Customer then
            Rec."Aadhar No." := '';
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line",
        'OnAfterValidateEvent', 'Bal. Account No.', false, false)]
    local procedure OnAfterValidateBalAccountNo_Customer(
        var Rec: Record "Gen. Journal Line";
        var xRec: Record "Gen. Journal Line")
    var
        Customer: Record Customer;
    begin
        if Rec."Bal. Account Type" <> Rec."Bal. Account Type"::Customer then
            exit;

        if Rec."Bal. Account No." = '' then begin
            Rec."Aadhar No." := '';
            exit;
        end;

        if Customer.Get(Rec."Bal. Account No.") then begin
            if Rec."Aadhar No." = '' then
                Rec."Aadhar No." := Customer."Aadhar No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line",
        'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnAfterInitCustLedgEntry(
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Aadhar No." := GenJournalLine."Aadhar No.";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Detailed Cust. Ledg. Entry",
        'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertDetailedCustLedgEntry(
        var Rec: Record "Detailed Cust. Ledg. Entry";
        RunTrigger: Boolean)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        if Rec."Aadhar No" <> '' then
            exit;

        if not CustLedgerEntry.Get(Rec."Cust. Ledger Entry No.") then
            exit;

        if CustLedgerEntry."Aadhar No." = '' then
            exit;

        Rec."Aadhar No" := CustLedgerEntry."Aadhar No.";
        Rec.Modify();
    end;
}
