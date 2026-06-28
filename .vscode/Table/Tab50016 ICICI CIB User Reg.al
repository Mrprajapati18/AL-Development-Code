table 50016 "ICICI CIB User Reg."
{
    Caption = 'ICICI CIB User Registration';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Corp ID"; Text[32])
        {
            Caption = 'Corporate ID (CIB)';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "User ID"; Text[32])
        {
            Caption = 'User ID (CIB)';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(4; "URN"; Text[40])
        {
            Caption = 'Unique Reference Number (URN)';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(5; "Alias ID"; Text[32])
        {
            Caption = 'Alias ID (optional)';
            DataClassification = CustomerContent;
        }
        field(6; "Registration Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Pending Approval,Success,Failure';
            OptionMembers = " ","Pending Approval",Success,Failure;
            DataClassification = CustomerContent;
        }
        field(7; "Response Message"; Text[500])
        {
            Caption = 'Response Message';
            DataClassification = CustomerContent;
        }
        field(8; "Error Code"; Text[20])
        {
            Caption = 'Error Code';
            DataClassification = CustomerContent;
        }
        field(9; "Registration DateTime"; DateTime)
        {
            Caption = 'Registration Date Time';
            DataClassification = CustomerContent;
        }
        field(10; "Raw Request JSON"; Blob)
        {
            Caption = 'Raw Request JSON';
            DataClassification = CustomerContent;
        }
        field(11; "Raw Response JSON"; Blob)
        {
            Caption = 'Raw Response JSON';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(UserKey; "Corp ID", "User ID")
        {

        }
        key(URNKey; "URN")
        {

        }
    }
}