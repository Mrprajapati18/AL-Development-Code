page 50019 "ICICI CIB Setup"
{
    Caption = 'ICICI CIB API Setup';
    PageType = Card;
    SourceTable = "ICICI CIB Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(APIConfig)
            {
                Caption = 'API Configuration';

                field("AGGR ID"; Rec."AGGR ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aggregator ID assigned by ICICI Bank offline.';
                }
                field("AGGR Name"; Rec."AGGR Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Aggregator Name assigned by ICICI Bank offline.';
                }
                field("API Key"; Rec."API Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'API Key for HTTP header apikey.';
                    ExtendedDatatype = Masked;
                }
                field("UAT Mode"; Rec."UAT Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'TRUE = Sandbox/UAT. FALSE = Production.';
                }
                field("Client IP"; Rec."Client IP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Your whitelisted server IP for x-forwarded-for header.';
                }
            }
            group(EncryptionConfig)
            {
                Caption = 'Encryption';

                field("ICICI Public Key PEM"; Rec."ICICI Public Key PEM")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'ICICI Bank Public Key Certificate in Base64 PEM. Used by Azure Function for RSA encryption.';
                }
                field("Azure Function URL"; Rec."Azure Function URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Azure Function URL that handles RSA+AES Hybrid encryption/decryption. Required for BC Cloud.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(InitSetup)
            {
                Caption = 'Initialize Setup';
                ApplicationArea = All;
                Image = Setup;
                ToolTip = 'Create default setup record.';

                trigger OnAction()
                begin
                    if not Rec.Get('DEFAULT') then begin
                        Rec.Init();
                        Rec."Primary Key" := 'DEFAULT';
                        Rec."UAT Mode" := true;
                        Rec.Insert(true);
                        Message('Setup initialized. Please fill all fields.');
                    end else
                        Message('Setup already exists.');
                end;
            }
            action(ValidateSetup)
            {
                Caption = 'Validate Setup';
                ApplicationArea = All;
                Image = CheckRulesSyntax;

                trigger OnAction()
                var
                    Mgt: Codeunit "ICICI CIB Reg. Mgt.";
                begin
                    Mgt.ValidateSetup(Rec);
                    Message('Validation passed. All required fields are filled correctly.');
                end;
            }
            action(ImportPrivKey)
            {
                Caption = 'Import Client Private Key';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Store Client Private Key securely in Isolated Storage.';

                trigger OnAction()
                begin
                    Page.Run(50103);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('DEFAULT') then begin
            Rec.Init();
            Rec."Primary Key" := 'DEFAULT';
            Rec."UAT Mode" := true;
            Rec.Insert(true);
        end;
    end;
}