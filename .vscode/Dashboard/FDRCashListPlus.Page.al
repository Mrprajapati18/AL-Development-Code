page 50049 "FDR&Cash ListPlus"
{
    Caption = 'FDR & Cash Balance';
    PageType = ListPart;
    SourceTable = "G/L Account";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    SourceTableView = where("No." = filter(2910 | 2950 | 2960 | 2970 | 8610 | 2007 | 2008 | 2014 .. 2019 | 2021 | 2035 | 2803 | 8219 | 8237), Balance = filter(> 0));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the cash account.';
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the balance of the cash account.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
