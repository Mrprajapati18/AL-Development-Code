
page 50002 "BC Transfer Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BC Transfer Log";
    Caption = 'BC Transfer Log';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Width = 6;
                }
                field("Transfer DateTime"; Rec."Transfer DateTime")
                {
                    ApplicationArea = All;
                    Width = 14;
                }
                field("Record Type"; Rec."Record Type")
                {
                    ApplicationArea = All;
                    Width = 8;
                }
                field("Record No."; Rec."Record No.")
                {
                    ApplicationArea = All;
                    Width = 10;
                }
                field("Record Name"; Rec."Record Name")
                {
                    ApplicationArea = All;
                    Width = 20;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Width = 8;
                    StyleExpr = StatusStyle;
                }
                field("Action Taken"; Rec."Action Taken")
                {
                    ApplicationArea = All;
                    Width = 8;
                }
                field("HTTP Status Code"; Rec."HTTP Status Code")
                {
                    ApplicationArea = All;
                    Width = 6;
                }
                field("Source Environment"; Rec."Source Environment")
                {
                    ApplicationArea = All;
                    Width = 20;
                }
                field("Target Environment"; Rec."Target Environment")
                {
                    ApplicationArea = All;
                    Width = 20;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Width = 50;
                    StyleExpr = ErrorStyle;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowErrorsOnly)
            {
                ApplicationArea = All;
                Caption = 'Show Errors Only';
                Image = ErrorLog;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.FilterGroup(2);
                    Rec.SetRange(Status, Rec.Status::Error);
                    Rec.FilterGroup(0);
                    CurrPage.Update(false);
                end;
            }

            action(ShowAll)
            {
                ApplicationArea = All;
                Caption = 'Show All';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.FilterGroup(2);
                    Rec.SetRange(Status);
                    Rec.FilterGroup(0);
                    CurrPage.Update(false);
                end;
            }

            action(ClearLog)
            {
                ApplicationArea = All;
                Caption = 'Clear Log';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LogEntry: Record "BC Transfer Log";
                begin
                    if Confirm('Delete all transfer log entries?', false) then begin
                        LogEntry.DeleteAll(true);
                        Message('Transfer log cleared.');
                    end;
                end;
            }
        }
    }

    var
        StatusStyle: Text;
        ErrorStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Success:
                StatusStyle := 'Favorable';
            Rec.Status::Error:
                StatusStyle := 'Unfavorable';
            Rec.Status::Skipped:
                StatusStyle := 'StrongAccent';
            else
                StatusStyle := 'Standard';
        end;

        if Rec.Status = Rec.Status::Error then
            ErrorStyle := 'Unfavorable'
        else
            ErrorStyle := 'Standard';
    end;
}
