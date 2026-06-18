
page 50003 "BC Transfer Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BC Transfer Setup";
    Caption = 'BC Data Transfer Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(SourceGroup)
            {
                Caption = 'Source Environment';

                field("Source Tenant ID"; Rec."Source Tenant ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Azure Portal → Azure AD → Overview → Directory (Tenant) ID  [for the SOURCE tenant]';
                }
                field("Source Environment Name"; Rec."Source Environment Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'BC Admin Center environment name for the SOURCE (e.g. Production, Sandbox).';
                }
                field("Source Client ID"; Rec."Source Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'App Registration Client ID that has API access to the SOURCE BC environment.';
                }
                field("Source Client Secret"; Rec."Source Client Secret")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Client Secret for the SOURCE environment app registration.';
                }
                field("Source Company ID"; Rec."Source Company ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'GUID of the company in the SOURCE environment. Use "Fetch Source Company IDs".';
                }
                field("Source Company Name"; Rec."Source Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Display name of the source company (for reference only).';
                }
            }

            group(TargetGroup)
            {
                Caption = 'Target Environment';

                field("Target Tenant ID"; Rec."Target Tenant ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Azure Portal → Azure AD → Overview → Directory (Tenant) ID  [for the TARGET tenant]';
                }
                field("Target Environment Name"; Rec."Target Environment Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'BC Admin Center environment name for the TARGET (e.g. Production, Sandbox).';
                }
                field("Target Client ID"; Rec."Target Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'App Registration Client ID that has API access to the TARGET BC environment.';
                }
                field("Target Client Secret"; Rec."Target Client Secret")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Client Secret for the TARGET environment app registration.';
                }
                field("Target Company ID"; Rec."Target Company ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'GUID of the company in the TARGET environment. Use "Fetch Target Company IDs".';
                }
                field("Target Company Name"; Rec."Target Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Display name of the target company (for reference only).';
                }
            }
            group(OptionsGroup)
            {
                Caption = 'Transfer Options';

                field("Transfer Customers"; Rec."Transfer Customers")
                {
                    ApplicationArea = All;
                }
                field("Transfer Vendors"; Rec."Transfer Vendors")
                {
                    ApplicationArea = All;
                }
                field("Transfer Items"; Rec."Transfer Items")
                {
                    ApplicationArea = All;
                }
                field("Skip Existing Records"; Rec."Skip Existing Records")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enabled = skip records already in the target. Disabled = update them via PATCH.';
                }
            }
            group(LastRunGroup)
            {
                Caption = 'Last Transfer Summary';

                field("Last Transfer DateTime"; Rec."Last Transfer DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Transfer Status"; Rec."Last Transfer Status")
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
            // ---------- PRIMARY ACTION ----------
            action(RunTransfer)
            {
                ApplicationArea = All;
                Caption = 'Run Transfer';
                ToolTip = 'Transfer master data from the Source environment to the Target environment.';
                Image = TransferToGeneralJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TransferMgt: Codeunit "BC Data Transfer Mgt";
                begin
                    if Confirm(
                        'Start data transfer?\n\n' +
                        'Source : %1  [%2]\n' +
                        'Target : %3  [%4]\n\n' +
                        'Continue?',
                        false,
                        Rec."Source Company Name", Rec."Source Environment Name",
                        Rec."Target Company Name", Rec."Target Environment Name"
                    ) then
                        TransferMgt.RunTransfer();
                end;
            }

            action(ViewLog)
            {
                ApplicationArea = All;
                Caption = 'View Transfer Log';
                Image = Log;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "BC Transfer Log List";
            }

            // ---------- SOURCE TOOLS ----------
            group(SourceTools)
            {
                Caption = 'Source Tools';

                action(TestSourceConnection)
                {
                    ApplicationArea = All;
                    Caption = 'Test Source Connection';
                    ToolTip = 'Verifies the OAuth 2.0 connection to the SOURCE environment.';
                    Image = CheckRulesSyntax;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        OAuthMgr: Codeunit "BC OAuth Manager";
                        Token: Text;
                    begin
                        Token := OAuthMgr.GetSourceToken(
                            Rec."Source Tenant ID",
                            Rec."Source Client ID",
                            Rec."Source Client Secret"
                        );
                        if Token <> '' then
                            Message('Source connection successful! Token acquired for environment: %1', Rec."Source Environment Name")
                        else
                            Message('Source connection failed. Please check the Source credentials.');
                    end;
                }

                action(FetchSourceCompanyIDs)
                {
                    ApplicationArea = All;
                    Caption = 'Fetch Source Company IDs';
                    ToolTip = 'Lists all companies in the SOURCE environment so you can copy the GUID.';
                    Image = Find;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Fetcher: Codeunit "BC Company ID Fetcher";
                    begin
                        Fetcher.FetchSourceCompanyIDs(Rec);
                    end;
                }
            }

            // ---------- TARGET TOOLS ----------
            group(TargetTools)
            {
                Caption = 'Target Tools';

                action(TestTargetConnection)
                {
                    ApplicationArea = All;
                    Caption = 'Test Target Connection';
                    ToolTip = 'Verifies the OAuth 2.0 connection to the TARGET environment.';
                    Image = CheckRulesSyntax;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        OAuthMgr: Codeunit "BC OAuth Manager";
                        Token: Text;
                    begin
                        Token := OAuthMgr.GetTargetToken(
                            Rec."Target Tenant ID",
                            Rec."Target Client ID",
                            Rec."Target Client Secret"
                        );
                        if Token <> '' then
                            Message('Target connection successful! Token acquired for environment: %1', Rec."Target Environment Name")
                        else
                            Message('Target connection failed. Please check the Target credentials.');
                    end;
                }

                action(FetchTargetCompanyIDs)
                {
                    ApplicationArea = All;
                    Caption = 'Fetch Target Company IDs';
                    ToolTip = 'Lists all companies in the TARGET environment so you can copy the GUID.';
                    Image = Find;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Fetcher: Codeunit "BC Company ID Fetcher";
                    begin
                        Fetcher.FetchTargetCompanyIDs(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.GetSetup(Rec);
    end;
}
