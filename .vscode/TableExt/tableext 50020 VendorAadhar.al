
tableextension 50100 "Vendor Aadhar Ext" extends Vendor
{
    fields
    {
        field(50100; "Aadhar No."; Code[12])
        {
            Caption = 'Aadhar No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
               ValidateAadharNo("Aadhar No.");
            end;
        }
    }

    procedure ValidateAadharNo(AadharNo: Code[12])
    var
        AadharErr: Label 'Aadhar No. only one 12 digit numbers allowed.';
        i: Integer;
    begin
        if AadharNo = '' then
            exit;

        if StrLen(AadharNo) <> 12 then
            Error(AadharErr);

        for i := 1 to StrLen(AadharNo) do
            if not (AadharNo[i] in ['0' .. '9']) then
                Error(AadharErr);
    end;
}
