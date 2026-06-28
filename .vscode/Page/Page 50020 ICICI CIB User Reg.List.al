page 50020 "ICICI CIB User Reg. List"
{
    Caption = 'ICICI CIB User Registration';
    PageType = List;
    SourceTable = "ICICI CIB User Reg.";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "ICICI CIB User Reg. Card";

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Corp ID"; Rec."Corp ID")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("URN"; Rec."URN")
                {
                    ApplicationArea = All;
                }
                field("Alias ID"; Rec."Alias ID")
                {
                    ApplicationArea = All;
                }
                field("Registration Status"; Rec."Registration Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StatusStyle;
                }
                field("Response Message"; Rec."Response Message")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Registration DateTime"; Rec."Registration DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RegisterUser)
            {
                Caption = 'Register at ICICI CIB';
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    Mgt: Codeunit "ICICI CIB Reg. Mgt.";
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindSet() then
                        repeat
                            Mgt.RegisterCIBUser(Rec);
                        until Rec.Next() = 0;
                end;
            }
            action(ViewRawResponse)
            {
                Caption = 'View Raw Response';
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    IStream: InStream;
                    RawText: Text;
                begin
                    Rec."Raw Response JSON".CreateInStream(IStream);
                    IStream.ReadText(RawText);
                    if RawText = '' then
                        Message('No response stored yet.')
                    else
                        Message('Raw Response:\%1', CopyStr(RawText, 1, 1000));
                end;
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec."Registration Status" of
            Rec."Registration Status"::"Pending Approval":
                StatusStyle := 'Ambiguous';
            Rec."Registration Status"::Success:
                StatusStyle := 'Favorable';
            Rec."Registration Status"::Failure:
                StatusStyle := 'Unfavorable';
            else
                StatusStyle := 'None';
        end;
    end;
}
