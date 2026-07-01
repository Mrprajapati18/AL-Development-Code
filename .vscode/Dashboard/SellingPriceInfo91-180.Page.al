page 50063 "Selling Price Info 91-180"
{
    ApplicationArea = All;
    Caption = 'Selling Price Information 91-180 Inv Days';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    UsageCategory = Lists;
    SourceTableView = where(Open = const(true), "Inventory Days" = filter(91 .. 180));
    Permissions = tabledata "Item Ledger Entry" = RM;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item in the entry.';
                }
                field("Vendor Item No"; Rec."Vendor Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; ItemDesc)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Purchase Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a serial number if the posted item carries such a number.';
                }
                field(Cost_Amount; CostAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the adjusted cost, in LCY, of the quantity posting.';
                }
                field("Item Category Code"; ItemCategoryName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Inventory Days"; Rec."Inventory Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Days field.';
                }
                field(FinanceCost; FinanceCost)
                {
                    Caption = 'Finance Cost As On Today';
                    ApplicationArea = all;
                }
                field(SellingPrice; SellingPrice)
                {
                    ApplicationArea = all;
                    Caption = 'Selling Price';
                }
                field("Location"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                }

            }
            group("Total Quantity ")
            {
                ShowCaption = false;

                field("Total Quantity"; TotalQuantity)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;

                }
                field("Total Inv Value"; TotalInvValue)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }
                field("Total Finance Cost"; TotalFinCost)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Style = StandardAccent;
                    StyleExpr = true;
                }

            }
        }
    }
    var
        FinanceCost: Decimal;
        ItemRec: Record Item;
        ItemCatCodeRec: Record "Item Category";
        ItemCategoryName: Text;
        ItemDesc: Text;
        ItemCatFilter: Text;
        InveDaysFilter: Text;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        TotalInvValue: Decimal;
        TotalFinCost: Decimal;
        ItemCatRec: Record "Item Category";
        SellingPrice: Decimal;
        CostAmount: Decimal;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Rec."Inventory Days" := Today - Rec."Posting Date";
        Rec.Modify();

        Clear(CostAmount);
        Rec.CalcFields("Cost Amount (Actual)");
        CostAmount := (Rec."Cost Amount (Actual)" / Rec.Quantity) * Rec."Remaining Quantity";

        Clear(FinanceCost);
        ItemCatRec.Reset();
        ItemCatRec.SetRange(Code, Rec."Item Category Code");
        //  CalcFields("Cost Amount (Actual)");
        if ItemCatRec.FindFirst() then
            FinanceCost := ((CostAmount * ItemCatRec."Finance Cost Percentage" / 100) / 365) * Rec."Inventory Days";

        Clear(SellingPrice);
        ItemCatRec.Reset();
        ItemCatRec.SetRange(Code, Rec."Item Category Code");
        // CalcFields("Cost Amount (Actual)");
        if ItemCatCodeRec.FindFirst() then
            SellingPrice := CostAmount + FinanceCost + (CostAmount * ItemCatRec."Margin 91-180 Days" / 100);


        Clear(ItemDesc);
        ItemRec.Reset();
        ItemRec.SetRange("No.", Rec."Item No.");
        if ItemRec.FindFirst() then
            ItemDesc := ItemRec.Description;

        Clear(ItemCategoryName);
        ItemCatCodeRec.Reset();
        ItemCatCodeRec.SetRange(Code, Rec."Item Category Code");
        if ItemCatCodeRec.FindFirst() then
            ItemCategoryName := ItemCatCodeRec.Description;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        TotalQuantity := 0;
        TotalFinCost := 0;
        TotalInvValue := 0;

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.COPYFILTERS(Rec);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                 ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                TotalQuantity += ItemLedgerEntry."Remaining Quantity";
                TotalInvValue += CostAmount;

                ItemCatRec.Reset();
                ItemCatRec.SetRange(Code, ItemLedgerEntry."Item Category Code");
                 ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                if ItemCatRec.FindFirst() then
                    TotalFinCost += ((CostAmount * ItemCatRec."Finance Cost Percentage" / 100) / 365) * ItemLedgerEntry."Inventory Days";

            UNTIL ItemLedgerEntry.NEXT = 0;
    end;
}