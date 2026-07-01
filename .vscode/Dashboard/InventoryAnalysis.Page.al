page 50068 "Inventory Analysis"
{
    Caption = 'Inventory Analysis';
    PageType = CardPart;


    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                Caption = 'Inventory Aging Details';

                field(InvBlow45; InvBlow45)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv Blow 45 Days';

                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Selling Price Information <45");
                    end;
                }
                field(Inv45to90; Inv45to90)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 45 to 90 Days';

                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Selling Price Info 45-90");
                    end;
                }
                field(Inv91to180; Inv91to180)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 91 to 180 Days';

                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Selling Price Info 91-180");
                    end;
                }
                field(Inv181to360; Inv181to360)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv 181 to 360 Days';

                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Selling Price Info 181-360");
                    end;
                }
                field(InvAbove360; InvAbove360)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inv above 360 Days';

                    trigger OnDrillDown()
                    var
                    begin
                        Page.Run(Page::"Selling Price Information >360");
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin


        Clear(InvBlow45);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Inventory Days", '<%1', 45);
        if ILE.FindFirst() then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                InvBlow45 += ILE."Cost Amount (Actual)";
            until ILE.Next() = 0;

        Clear(Inv45to90);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Inventory Days", '%1..%2', 45, 90);
        if ILE.FindFirst() then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                Inv45to90 += ILE."Cost Amount (Actual)";
            until ILE.Next() = 0;

        Clear(Inv91to180);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Inventory Days", '%1..%2', 91, 180);
        if ILE.FindFirst() then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                Inv91to180 += ILE."Cost Amount (Actual)";
            until ILE.Next() = 0;

        Clear(Inv181to360);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Inventory Days", '%1..%2', 181, 360);
        if ILE.FindFirst() then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                Inv181to360 += ILE."Cost Amount (Actual)";
            until ILE.Next() = 0;

        Clear(InvAbove360);
        ILE.Reset();
        ILE.SetRange(Open, true);
        ILE.SetFilter("Inventory Days", '>%1', 360);
        if ILE.FindFirst() then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                InvAbove360 += ILE."Cost Amount (Actual)";
            until ILE.Next() = 0;

    end;

    var
        ILE: Record "Item Ledger Entry";
        InvBlow45: Decimal;
        Inv45to90: Decimal;
        Inv91to180: Decimal;
        Inv181to360: Decimal;
        InvAbove360: Decimal;
}