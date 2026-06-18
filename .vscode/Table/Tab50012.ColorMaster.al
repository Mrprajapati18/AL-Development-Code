table 50012 ColorMaster
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Colors Code"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Colors Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Colors Code")
        {
            Clustered = true;
        }
    }

}