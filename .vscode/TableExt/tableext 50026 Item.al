
tableextension 50026 "Item Color Ext" extends Item
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
                    if ColorMaster.Get(Rec."Color Code") then begin
                        if ColorMaster.Blocked then
                            Error('Color Code %1 (%2) blocked hai. Koi aur color select karein.',
                                  ColorMaster."Color Code", ColorMaster."Color Name");
                        Rec."Color Name" := ColorMaster."Color Name";
                    end else
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
