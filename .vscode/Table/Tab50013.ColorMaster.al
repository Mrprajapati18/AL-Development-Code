
table 50013 "Color Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Color Master';
    LookupPageId = "Color Master List";
    DrillDownPageId = "Color Master List";

    fields
    {
        field(1; "Color Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Code';
            NotBlank = true;
        }
        field(2; "Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Name';
            NotBlank = true;
        }
        field(3; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(4; "Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(PK; "Color Code")
        {
            Clustered = true;
        }
        key(K2; "Color Name") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Color Code", "Color Name") { }
        fieldgroup(Brick; "Color Code", "Color Name") { }
    }
}
