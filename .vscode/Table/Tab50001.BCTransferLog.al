
table 50101 "BC Transfer Log"
{
      DataClassification = CustomerContent;
    Caption = 'BC Transfer Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Transfer DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer Date/Time';
        }
        field(3; "Record Type"; Enum "BC Transfer Record Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Record Type';
        }
        field(4; "Record No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Record No.';
        }
        field(5; "Record Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Record Name';
        }
        field(6; "Status"; Enum "BC Transfer Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(7; "Error Message"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Error Message';
        }
        field(8; "Source Environment"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Environment';
        }
        field(9; "Target Environment"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Target Environment';
        }
        field(10; "HTTP Status Code"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'HTTP Status Code';
        }
        field(11; "Action Taken"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Action Taken';
            // Created / Updated / Skipped
        }
    }

    keys
    {
        key(PK; "Entry No.") { Clustered = true; }
        key(DateType; "Transfer DateTime", "Record Type") { }
        key(Status; "Status") { }
    }
}
