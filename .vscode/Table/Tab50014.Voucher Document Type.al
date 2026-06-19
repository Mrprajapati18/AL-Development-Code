table 50014 "Voucher Document Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Payment","Credit Memo","Invoice","Refound","Reminder","Finance Charge Memo";

        }
        field(50001; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Custom Document Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}