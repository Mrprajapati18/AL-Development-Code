
table 50002 "BC Transfer Setup"
{
     DataClassification = CustomerContent;
    Caption = 'BC Cross-Environment Transfer Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(10; "Source Tenant ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Tenant ID';
            ToolTip = 'Azure AD Tenant (Directory) ID of the SOURCE environment.';
        }
        field(11; "Source Environment Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Environment Name';
            ToolTip = 'BC environment name for the SOURCE (e.g. Production, Sandbox).';
        }
        field(12; "Source Client ID"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Client ID';
            ToolTip = 'Azure App Registration Client ID that has access to the SOURCE environment.';
        }
        field(13; "Source Client Secret"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Client Secret';
            ExtendedDatatype = Masked;
            ToolTip = 'Client Secret for the SOURCE environment app registration.';
        }
        field(14; "Source Company ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Company ID (GUID)';
            ToolTip = 'GUID of the company in the SOURCE environment.';
        }
        field(15; "Source Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Company Name';
            ToolTip = 'Display name of the source company (for reference only).';
        }

        field(20; "Target Tenant ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Tenant ID';
            ToolTip = 'Azure AD Tenant (Directory) ID of the TARGET environment.';
        }
        field(21; "Target Environment Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Environment Name';
            ToolTip = 'BC environment name for the TARGET (e.g. Production, Sandbox).';
        }
        field(22; "Target Client ID"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Client ID';
            ToolTip = 'Azure App Registration Client ID that has access to the TARGET environment.';
        }
        field(23; "Target Client Secret"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Client Secret';
            ExtendedDatatype = Masked;
            ToolTip = 'Client Secret for the TARGET environment app registration.';
        }
        field(24; "Target Company ID"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Company ID (GUID)';
            ToolTip = 'GUID of the company in the TARGET environment.';
        }
        field(25; "Target Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Company Name';
            ToolTip = 'Display name of the target company (for reference only).';
        }
        field(40; "Transfer Customers"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer Customers';
            InitValue = true;
        }
        field(41; "Transfer Vendors"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer Vendors';
            InitValue = true;
        }
        field(42; "Transfer Items"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer Items';
            InitValue = true;
        }
        field(43; "Skip Existing Records"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Skip Existing Records';
            InitValue = true;
            ToolTip = 'Enabled = skip records that already exist in the target. Disabled = update them via PATCH.';
        }
        field(50; "Last Transfer DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Transfer Date/Time';
            Editable = false;
        }
        field(51; "Last Transfer Status"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Transfer Status';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }

    procedure GetSetup(var Rec: Record "BC Transfer Setup")
    begin
        if not Rec.Get('') then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert(true);
        end;
    end;
}
