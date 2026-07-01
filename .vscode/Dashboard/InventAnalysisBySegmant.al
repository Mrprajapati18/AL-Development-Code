page 50085 "Inventory Analysis By Segment"
{
    Caption = 'Inventory Analysis By Segment';
    PageType = CardPart;


    layout
    {
        area(content)
        {
            cuegroup(control1)
            {
                Caption = 'Inventory Aging Details CSG';

                field(InvBlow45; InvBlow45CSG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv Blow 45 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 45 Days CSG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(1);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv45to90; Inv45to90CSG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 45 to 90 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv 45-90 Days CSG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(2);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv91to180; Inv91to180CSG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 91 to 180 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 91-180 Days CSG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(3);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv181to360; Inv181to360CSG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 181 to 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 181-360 Days CSG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(4);
                        ITEMDetails.Run();
                    end;
                }
                field(InvAbove360; InvAbove360CSG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv above 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Above 360 Days CSG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(5);
                        ITEMDetails.Run();
                    end;
                }
            }
            cuegroup(control2)
            {
                Caption = 'Inventory Aging Details ISG';

                field(InvBlow45ISG; InvBlow45ISG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv Blow 45 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 45 Days ISG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(6);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv45to90ISG; Inv45to90ISG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 45 to 90 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv 45-90 Days ISG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(7);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv91to180ISG; Inv91to180ISG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 91 to 180 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 91-180 Days ISG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(8);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv181to360ISG; Inv181to360ISG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 181 to 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 181-360 Days ISG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(9);
                        ITEMDetails.Run();
                    end;
                }
                field(InvAbove360ISG; InvAbove360ISG)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv above 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Above 360 Days ISG", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(10);
                        ITEMDetails.Run();
                    end;
                }
            }
            cuegroup(control3)
            {
                Caption = 'Inventory Aging Details Blank';
                Visible = false;

                field(InvBlow45Blank; InvBlow45Blank)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv Blow 45 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 45 Days Blank", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(11);
                        ITEMDetails.Run();
                    end;

                }
                field(Inv45to90Blank; Inv45to90Blank)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 45 to 90 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv 45-90 Days Blank", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(12);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv91to180Blank; Inv91to180Blank)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 91 to 180 Days';
                    Style = Favorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 91-180 Days Blank", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(13);
                        ITEMDetails.Run();
                    end;
                }
                field(Inv181to360Blank; Inv181to360Blank)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 181 to 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Below 181-360 Days Blank", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(14);
                        ITEMDetails.Run();
                    end;
                }
                field(InvAbove360Blank; InvAbove360Blank)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv above 360 Days';
                    Style = Unfavorable;
                    StyleExpr = true;

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Clear(ITEMDetails);
                        ItemCatRec.Reset();
                        ItemCatRec.SetFilter("Inv Above 360 Days Blank", '<>%1', 0);
                        ITEMDetails.SetTableView(ItemCatRec);
                        ITEMDetails.SetPageFilter(15);
                        ITEMDetails.Run();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        ItemRec: Record Item;
    begin

        //For CSG
        Clear(InvBlow45CSG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '>=%1', Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::CSG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvBlow45CSG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv45to90CSG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 90, Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::CSG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv45to90CSG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv91to180CSG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 180, Today - 91);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::CSG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv91to180CSG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv181to360CSG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 360, Today - 181);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::CSG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv181to360CSG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(InvAbove360CSG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '<%1', Today - 360);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::CSG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvAbove360CSG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        //For ISG
        Clear(InvBlow45ISG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '>=%1', Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvBlow45ISG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv45to90ISG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 90, Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv45to90ISG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv91to180ISG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 180, Today - 91);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv91to180ISG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv181to360ISG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 360, Today - 181);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv181to360ISG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(InvAbove360ISG);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '<%1', Today - 360);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" = ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvAbove360ISG += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        //For Blank
        Clear(InvBlow45Blank);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '>=%1', Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::CSG) and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvBlow45Blank += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv45to90Blank);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 90, Today - 45);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::CSG) and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv45to90Blank += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv91to180Blank);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 180, Today - 91);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::CSG) and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv91to180Blank += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(Inv181to360Blank);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetRange("Posting Date", Today - 360, Today - 181);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::CSG) and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        Inv181to360Blank += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

        Clear(InvAbove360Blank);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Posting Date", '<%1', Today - 360);
        if ILE.FindSet() then
            repeat
                if ItemRec.Get(ILE."Item No.") and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::CSG) and (ItemRec."Prod Segment" <> ItemRec."Prod Segment"::ISG) then begin
                    ILE.CalcFields("Cost Amount (Actual)");
                    if ILE.Quantity <> 0 then
                        InvAbove360Blank += (ILE."Cost Amount (Actual)" / ILE.Quantity) * ILE."Remaining Quantity";
                end;
            until ILE.Next() = 0;

    end;

    var
        ILE: Record "Item Ledger Entry";
        InvBlow45CSG: Decimal;
        Inv45to90CSG: Decimal;
        Inv91to180CSG: Decimal;
        Inv181to360CSG: Decimal;
        InvAbove360CSG: Decimal;
        InvBlow45ISG: Decimal;
        Inv45to90ISG: Decimal;
        Inv91to180ISG: Decimal;
        Inv181to360ISG: Decimal;
        InvAbove360ISG: Decimal;
        InvBlow45Blank: Decimal;
        Inv45to90Blank: Decimal;
        Inv91to180Blank: Decimal;
        Inv181to360Blank: Decimal;
        InvAbove360Blank: Decimal;
        ITEMDetails: Page "Brand Inv Details";
        ItemCatRec: Record "Item Category";
}