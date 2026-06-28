page 50021 "ICICI CIB User Reg. Card"
{
    Caption = 'ICICI CIB Registration Card';
    PageType = Card;
    SourceTable = "ICICI CIB User Reg.";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(UserDetails)
            {
                Caption = 'User Details';

                field("Corp ID"; Rec."Corp ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Same Corporate ID used for CIB portal login.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'User ID under Corporate ID in CIB portal.';
                }
                field("URN"; Rec."URN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique Reference Number - must be same in all future API calls.';
                }
                field("Alias ID"; Rec."Alias ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fill only if user has Alias ID in CIB. Leave blank otherwise.';
                }
            }
            group(ResponseDetails)
            {
                Caption = 'Response';
                Editable = false;

                field("Registration Status"; Rec."Registration Status")
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Response Message"; Rec."Response Message")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Error Code"; Rec."Error Code")
                {
                    ApplicationArea = All;
                }
                field("Registration DateTime"; Rec."Registration DateTime")
                {
                    ApplicationArea = All;
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
                    Mgt.RegisterCIBUser(Rec);
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