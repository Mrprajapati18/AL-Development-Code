page 50084 "Brand Inv Details"
{
    Caption = 'Brand Inventory Details';
    PageType = List;
    SourceTable = "Item Category";
    UsageCategory = Lists;
    SourceTableView = where(Indentation = filter(0));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Brand';
                    ApplicationArea = all;
                }

                field("Inv Below 45 Days CSG"; Rec."Inv Below 45 Days CSG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty1;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 45 Days field.';
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::CSG);
                        Item.SetFilter("Inv Below 45 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(1);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv 45-90 Days CSG"; Rec."Inv 45-90 Days CSG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty2;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::CSG);
                        Item.SetFilter("Inv 45-90 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(2);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 91-180 Days CSG"; Rec."Inv Below 91-180 Days CSG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty3;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::CSG);
                        Item.SetFilter("Inv Below 91-180 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(3);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 181-360 Days CSG"; Rec."Inv Below 181-360 Days CSG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty4;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::CSG);
                        Item.SetFilter("Inv Below 181-360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(4);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Above 360 Days CSG"; Rec."Inv Above 360 Days CSG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty5;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::CSG);
                        Item.SetFilter("Inv Above 360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(5);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 45 Days ISG"; Rec."Inv Below 45 Days ISG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty6;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 45 Days field.';
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 45 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(1);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv 45-90 Days ISG"; Rec."Inv 45-90 Days ISG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty7;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv 45-90 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(2);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 91-180 Days ISG"; Rec."Inv Below 91-180 Days ISG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty8;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 91-180 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(3);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 181-360 Days ISG"; Rec."Inv Below 181-360 Days ISG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty9;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 181-360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(4);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Above 360 Days ISG"; Rec."Inv Above 360 Days ISG")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty10;
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetRange("Prod Segment", Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Above 360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(5);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 45 Days Blank"; Rec."Inv Below 45 Days Blank")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty11;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inv Below 45 Days field.';

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetFilter("Prod Segment", '<>%1 & <>%2', Item."Prod Segment"::CSG, Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 45 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(1);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv 45-90 Days Blank"; Rec."Inv 45-90 Days Blank")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty12;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetFilter("Prod Segment", '<>%1 & <>%2', Item."Prod Segment"::CSG, Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv 45-90 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(2);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 91-180 Days Blank"; Rec."Inv Below 91-180 Days Blank")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty13;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetFilter("Prod Segment", '<>%1 & <>%2', Item."Prod Segment"::CSG, Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 91-180 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(3);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Below 181-360 Days Blank"; Rec."Inv Below 181-360 Days Blank")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty14;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetFilter("Prod Segment", '<>%1 & <>%2', Item."Prod Segment"::CSG, Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Below 181-360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(4);
                        ITEMDetails.Run();
                    end;

                }
                field("Inv Above 360 Days Blank"; Rec."Inv Above 360 Days Blank")
                {
                    Caption = 'Brand Inventory';
                    Visible = InvenVisibilty15;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        Item.Reset();
                        Item.SetRange("Item Brand", Rec.Code);
                        Item.SetFilter("Prod Segment", '<>%1 & <>%2', Item."Prod Segment"::CSG, Item."Prod Segment"::ISG);
                        Item.SetFilter("Inv Above 360 Days", '<>%1', 0);
                        ITEMDetails.SetTableView(Item);
                        ITEMDetails.SetPageFilter(5);
                        ITEMDetails.Run();
                    end;

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
                            InvenVisibilty5 := true
                        else
                            if InventAgeDaysvar = 6 then
                                InvenVisibilty6 := true
                            else
                                if InventAgeDaysvar = 7 then
                                    InvenVisibilty7 := true
                                else
                                    if InventAgeDaysvar = 8 then
                                        InvenVisibilty8 := true
                                    else
                                        if InventAgeDaysvar = 9 then
                                            InvenVisibilty9 := true
                                        else
                                            if InventAgeDaysvar = 10 then
                                                InvenVisibilty10 := true
                                            else
                                                if InventAgeDaysvar = 11 then
                                                    InvenVisibilty11 := true
                                                else
                                                    if InventAgeDaysvar = 12 then
                                                        InvenVisibilty12 := true
                                                    else
                                                        if InventAgeDaysvar = 13 then
                                                            InvenVisibilty13 := true
                                                        else
                                                            if InventAgeDaysvar = 14 then
                                                                InvenVisibilty14 := true
                                                            else
                                                                if InventAgeDaysvar = 15 then
                                                                    InvenVisibilty15 := true;
    end;

    procedure SetPageFilter(InventAgeDays: Integer)
    begin
        InventAgeDaysvar := InventAgeDays;
    end;


    var
        InventAgeDaysvar: Integer;
        InvenVisibilty1: Boolean;
        InvenVisibilty2: Boolean;
        InvenVisibilty3: Boolean;
        InvenVisibilty4: Boolean;
        InvenVisibilty5: Boolean;
        InvenVisibilty6: Boolean;
        InvenVisibilty7: Boolean;
        InvenVisibilty8: Boolean;
        InvenVisibilty9: Boolean;
        InvenVisibilty10: Boolean;
        InvenVisibilty11: Boolean;
        InvenVisibilty12: Boolean;
        InvenVisibilty13: Boolean;
        InvenVisibilty14: Boolean;
        InvenVisibilty15: Boolean;
        ITEMDetails: Page "Item Inv Details";
        ItemRec: Record Item;
}