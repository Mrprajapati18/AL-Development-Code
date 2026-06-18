
tableextension 50023 "Item Journal Line Color Ext" extends "Item Journal Line"
{
    fields
    {
        field(50100; "Color Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Code';
            TableRelation = "Color Master"."Color Code";
            trigger OnValidate()
            var
                ColorMaster: Record "Color Master";
            begin
                if Rec."Color Code" <> '' then begin
                    if ColorMaster.Get(Rec."Color Code") then
                        Rec."Color Name" := ColorMaster."Color Name"
                    else
                        Rec."Color Name" := '';
                end else
                    Rec."Color Name" := '';
            end;
        }
        field(50101; "Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color Name';
            Editable = false;
        }
    }
}
