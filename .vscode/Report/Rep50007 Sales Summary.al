report 50007 SummaryReport
{
    ApplicationArea = All;
    Caption = 'Summary Report';
    UsageCategory = Documents;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\SummaryReport.rdl';

    dataset
    {
        dataitem(SalesInvLine; "Sales Invoice Line")
        {
            DataItemTableView = where(Type=filter(Item));

            column(SIHExciseDuty; '')
            {
            }
            column(SILQty; SalesInvLine.Quantity)
            {
            }
            column(SILCapacity; '')
            {
            }
            column(SILAmount; SalesInvLine.Amount)
            {
            }
            column(FromDateFilter; FromDateFilter)
            {
            }
            column(ToDateFilter; ToDateFilter)
            {
            }
            column(CustName; customer.Name)
            {
            }
            column(CompInfo;'')
            {
            }
            column(No_; "No.")
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Rowno; Rowno)
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            column(Description; Description)
            {
            }
            trigger OnPreDataItem()
            begin
                SalesInvLine.SetRange("Posting Date", FromDateFilter, ToDateFilter);
                SalesInvLine.SetRange(SalesInvLine."No.", Item);
                SalesInvLine.SetCurrentKey("Sell-to Customer No.");
            end;
            trigger OnAfterGetRecord()
            begin
                CompInfo.Get();
                if Customer.get(SalesInvLine."Sell-to Customer No.")then;
                if OLDCustNo <> SalesInvLine."Sell-to Customer No." then begin
                    Rowno+=1;
                    OLDCustNo:=SalesInvLine."Sell-to Customer No.";
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Gen1)
                {
                }
                field(FromDateFilter; FromDateFilter)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(ToDateFilter; ToDateFilter)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;
                }
                field(Item; Item)
                {
                    Caption = 'Item';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    TableRelation = Item;
                }
            }
        }
    }
    var Companies: Record Company;
    CompInfo: Record "Company Information";
    SILCapacity: Code[20];
    SILAmount: Decimal;
    SILQty: Decimal;
    SIHExciseDuty: Decimal;
    FromDateFilter: Date;
    ToDateFilter: Date;
    Customer: Record Customer;
    Rowno: Integer;
    OLDCustNo: Code[20];
    Item: Code[20];
}
