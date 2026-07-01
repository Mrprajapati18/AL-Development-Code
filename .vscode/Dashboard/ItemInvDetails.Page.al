page 50082 "Item Inv Details"
{
    Caption = 'Item Inv Details';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite, Assembly, Service;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item.';
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what you are selling.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the category that the item belongs to. Item categories also contain any assigned item attributes.';
                }
                field("Prod Segment"; Rec."Prod Segment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prod Segment field.';
                }
                field("Inv Below 45 Days"; Rec."Inv Below 45 Days")
                {
                    Visible = InvenVisibilty1;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 45 Days field.';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ILE: Record "Item Ledger Entry";
                        InvBelow45days: Page "Selling Price Information <45";
                    begin
                        Clear(InvBelow45days);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Rec."No.");
                        ILE.SetRange(Open, true);
                        ILE.SetFilter("Posting Date", '>=%1', Today - 45);
                        InvBelow45days.SetTableView(ILE);
                        InvBelow45days.Run();
                    end;
                }
                field("Inv 45-90 Days"; Rec."Inv 45-90 Days")
                {
                    Visible = InvenVisibilty2;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv 45-90 Days field.';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ILE: Record "Item Ledger Entry";
                        InvBelow45days: Page "Selling Price Info 45-90";
                    begin
                        Clear(InvBelow45days);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Rec."No.");
                        ILE.SetRange(Open, true);
                        ILE.SetRange("Posting Date", Today - 90, Today - 45);
                        InvBelow45days.SetTableView(ILE);
                        InvBelow45days.Run();
                    end;
                }
                field("Inv Below 91-180 Days"; Rec."Inv Below 91-180 Days")
                {
                    Visible = InvenVisibilty3;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 91-180 Days field.';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ILE: Record "Item Ledger Entry";
                        InvBelow45days: Page "Selling Price Info 91-180";
                    begin
                        Clear(InvBelow45days);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Rec."No.");
                        ILE.SetRange(Open, true);
                        ILE.SetRange("Posting Date", Today - 180, Today - 91);
                        InvBelow45days.SetTableView(ILE);
                        InvBelow45days.Run();
                    end;
                }
                field("Inv Below 181-360 Days"; Rec."Inv Below 181-360 Days")
                {
                    Visible = InvenVisibilty4;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 181-360 Days field.';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ILE: Record "Item Ledger Entry";
                        InvBelow45days: Page "Selling Price Info 181-360";
                    begin
                        Clear(InvBelow45days);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Rec."No.");
                        ILE.SetRange(Open, true);
                        ILE.SetRange("Posting Date", Today - 360, Today - 181);
                        InvBelow45days.SetTableView(ILE);
                        InvBelow45days.Run();
                    end;
                }
                field("Inv Above 360 Days"; Rec."Inv Above 360 Days")
                {
                    Visible = InvenVisibilty5;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Above 360 Days field.';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ILE: Record "Item Ledger Entry";
                        InvBelow45days: Page "Selling Price Information >360";
                    begin
                        Clear(InvBelow45days);
                        ILE.Reset();
                        ILE.SetRange("Item No.", Rec."No.");
                        ILE.SetRange(Open, true);
                        ILE.SetFilter("Posting Date", '<%1', Today - 360);
                        InvBelow45days.SetTableView(ILE);
                        InvBelow45days.Run();
                    end;
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if InventAgeDaysvar = 1 then
            InvenVisibilty1 := true
        else
            if InventAgeDaysvar = 2 then
                InvenVisibilty2 := true
            else
                if InventAgeDaysvar = 3 then
                    InvenVisibilty3 := true
                else
                    if InventAgeDaysvar = 4 then
                        InvenVisibilty4 := true
                    else
                        if InventAgeDaysvar = 5 then
                            InvenVisibilty5 := true;
    end;

    procedure SetPageFilter(InventAgeDays: Integer)
    begin
        InventAgeDaysvar := InventAgeDays;
    end;

    trigger OnAfterGetRecord()
    begin
    end;

    var
        InventAgeDaysvar: Integer;
        InvenVisibilty1: Boolean;
        InvenVisibilty2: Boolean;
        InvenVisibilty3: Boolean;
        InvenVisibilty4: Boolean;
        InvenVisibilty5: Boolean;
}
