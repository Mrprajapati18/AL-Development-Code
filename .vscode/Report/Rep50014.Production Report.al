report 50047 "Production Report"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Production Reprot';
    RDLCLayout = 'Layouts\Production Report.rdl';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Search_Description; "Search Description")
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Compinfo_Name; COMP_rec.Name)
            {
            }
            column(Compinfo_name2; COMP_rec."Name 2")
            {
            }
            column(Compinfo_Address; COMP_rec.Address)
            {
            }
            column(Compinfo_Address2; COMP_rec."Address 2")
            {
            }
            column(Compinfo_Picture; COMP_rec.Picture)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(INPUTQty; INPUTQty)
            {
            }
            column(Source_No_; "Source No.")
            {
            }
            column(OutPut2; OutPut2)
            {
            }
            column(diffrance; diffrance)
            {
            }
            column(Refresh_No_; '')
            {
            }
            column(Packing_In_Charge;'')
            {
            }
            column(Head_Of_Production;'')
            {
            }
            dataitem("Item Journal Line"; "Item Journal Line")
            {
                DataItemLinkReference = "Production Order";
                //DataItemTableView = sorting("Item No.") where("Entry Type" = filter(Consumption | Output));
                DataItemTableView = where("Entry Type"=filter(Consumption|Output));
                DataItemLink = "Order No."=field("No.");

                column(Item_No_; "Item No.")
                {
                }
                column(ConsumpQty; Abs(ConsumpQty))
                {
                }
                column(Order_No_; "Order No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Location_Code_LINE; "Location Code")
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(ItemNo; ItemNo)
                {
                }
                column(Quantity_line; Quantity)
                {
                }
                column(OutPutQty; Abs(OutPutQty))
                {
                }
                column(Output_Quantity; "Output Quantity")
                {
                }
                column(Posting_Date; "Posting Date")
                {
                }
                column(Item_Journal_Quantity; Quantity)
                {
                }
                column(NegitiveQTY; Abs(NegitiveQTY))
                {
                }
                column(ConsuptionQTY; ConsuptionQTY)
                {
                }
                column(MKMK; MKMK)
                {
                }
                column(Bag; '')
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(OutPutQty);
                    Clear(ConsumpQty);
                    Clear(NegitiveQTY);
                    Clear(ConsuptionQTY);
                    Clear(MKMK);
                    // if ItemNo = "Item Journal Line"."Item No." then
                    //     CurrReport.Skip()
                    // else
                    //     ItemNo := "Item Journal Line"."Item No.";
                    if("Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Consumption)then // and ("Item Journal Line".Quantity > 0) then
 ConsumpQty:="Item Journal Line".Quantity;
                    if("Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Consumption) and ("Item Journal Line".Quantity < 0)then NegitiveQTY+="Item Journal Line".Quantity;
                    if("Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Consumption) and ("Item Journal Line".Quantity > 0)then ConsuptionQTY+="Item Journal Line".Quantity;
                    MKMK+=(NegitiveQTY) + ConsuptionQTY;
                    // if ("Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Consumption) and ("Item Journal Line".Quantity < 0) then
                    //     OutPutQty := "Item Journal Line".Quantity;
                    if "Item Journal Line"."Entry Type" = "Item Journal Line"."Entry Type"::Output then OutPutQty:="Item Journal Line".Quantity;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
            end;
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
            // "Production Order".SetRange("Due Date", StartDate, EndDate);
            end;
        }
    }
    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                // field(StartDate; StartDate)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Start Date';
                // }
                // field(EndDate; EndDate)
                // {
                //     ApplicationArea = all;
                //     Caption = 'End Date';
                // }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        COMP_rec.Get();
        COMP_rec.CalcFields(Picture)end;
    var MKMK: Decimal;
    ConsuptionQTY: Decimal;
    NegitiveQTY: Decimal;
    myInt: Integer;
    COMP_rec: Record "Company Information";
    StartDate: Date;
    EndDate: Date;
    ItemNo: Text;
    ITEMJOuLine: Record "Item Journal Line";
    INPUTQty: Decimal;
    OutPutQty: Decimal;
    diffrance: Decimal;
    OutPut2: Decimal;
    ConsumpQty: Decimal;
}
