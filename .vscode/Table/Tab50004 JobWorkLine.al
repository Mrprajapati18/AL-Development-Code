table 50004 "Job work Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(25; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Outward Challan No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Outward Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecGst: Record "Detailed GST Ledger Entry";

            begin
                RecGst.Reset();
                RecGst.SetRange("Document No.", Rec."Outward challan No.");
                RecGst.SetRange("Document Line No.", Rec."Line No.");
                If RecGst.FindFirst() then begin
                    If RecGst."GST Component Code" = 'CGST' then begin
                        Rec."Outward CGST" := ABS(RecGst."GST Amount");
                    end;
                    if RecGst."GST Component Code" = 'SGST' then begin
                        Rec."Outward SGST" := ABS(RecGst."GST Amount");
                    end;
                    if RecGst."GST Component Code" = 'IGST' then begin
                        Rec."Outward IGST" := ABS(RecGst."GST Amount");
                    end;
                end;
            end;

        }
        field(4; "Outward Item Discription"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Outward Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Outward Unit of Measure"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Outward Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Outward Types of goods"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Outward Discription of goods"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Outward GST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Outward CGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Outward IGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Outward SGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Inward Item no."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Item: Record Item;
                JobworkLine: Record "Job work Line";
                QtyReceived: Decimal;

            begin
                if Item.Get("Inward Item no.") then
                    "Inward Item Description" := Item.Description;


                JobworkLine.Reset();
                JobworkLine.SetRange("Outward Challan No.", Rec."Outward Challan No.");
                JobworkLine.SetRange("Inward Item no.", Rec."Inward Item no.");
                JobworkLine.SetRange(Posted, true);
                JobworkLine.CalcSums("Received Qty");

                QtyReceived := JobworkLine."Received Qty";

                Rec."Balance Qty" := "Outward Quantity" - QtyReceived;
            end;
        }
        field(15; "Inward Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Received Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Received Qty" > "Balance Qty" then
                    Error('Received Qty cannot be greater then Balance Qty');
            end;
        }
        field(17; "Received UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
        field(18; "Received Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Inward Types of goods"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Inward Discription of goods"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Inward GST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Inward CGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Inward IGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Inward SGST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "JobWork Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(27; "JobWork Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(28; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Balance Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }



    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
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