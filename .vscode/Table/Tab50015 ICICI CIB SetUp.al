table 50015 "ICICI CIB Setup"
{
    Caption = 'ICICI CIB API Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "AGGR ID"; Text[100])
        {
            Caption = 'Aggregator ID';
            DataClassification = CustomerContent;
        }
        field(3; "AGGR Name"; Text[100])
        {
            Caption = 'Aggregator Name';
            DataClassification = CustomerContent;
        }
        field(4; "API Key"; Text[250])
        {
            Caption = 'API Key (apikey header)';
            DataClassification = CustomerContent;
        }
        field(5; "UAT Mode"; Boolean)
        {
            Caption = 'UAT Mode (Sandbox)';
            DataClassification = CustomerContent;
        }
        field(6; "ICICI Public Key PEM"; Text[2048])
        {
            Caption = 'ICICI Public Key (Base64 PEM)';
            DataClassification = CustomerContent;
        }
        field(7; "Azure Function URL"; Text[500])
        {
            Caption = 'Azure Function URL (Encryption Helper)';
            DataClassification = CustomerContent;
        }
        field(8; "Client IP"; Text[100])
        {
            Caption = 'Client IP (x-forwarded-for header)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}