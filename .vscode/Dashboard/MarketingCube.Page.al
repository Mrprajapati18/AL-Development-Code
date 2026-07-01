/// <summary>
/// Page Today Schedule (ID 50123).
/// </summary>
page 50081 "Marketing"
{
    // ApplicationArea = All;
    Caption = 'Marketing';
    PageType = CardPart;

    layout
    {
        area(content)
        {
            cuegroup(Control1)
            {
                ShowCaption = false;
                field(Contacts; Contacts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contacts List';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ContactList: Page "Contact List";
                    begin
                        ContactList.Run();
                    end;

                }

            }

        }
    }
    var
        Contacts: Integer;



}