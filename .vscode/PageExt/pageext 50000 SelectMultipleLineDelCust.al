pageextension 50000 "Customer Multi Line Delete" extends "Customer List"
{
    actions
    {
        addafter("&Customer")
        {
            action("Multiple Line Delete")
            {
                ApplicationArea = All;
                Caption = 'Multiple Line Delete';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                begin
                    CurrPage.SetSelectionFilter(CustomerRec);
                    if CustomerRec.FindSet() then begin
                        if Confirm('Do you want to delete selected customers?', false) then begin

                            repeat
                                CustomerRec.Delete(true);
                            until CustomerRec.Next() = 0;

                            Message('Selected customers deleted successfully.');
                        end;

                    end else
                        Message('Please select customer records.');
                end;
            }
        }
    }
}