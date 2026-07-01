tableextension 50034 "Item Dashboard Fields" extends Item
{
    fields
    {
        field(50120; "Item Brand"; Code[20])
        {
            Caption = 'Item Brand';
            DataClassification = CustomerContent;
        }
        field(50121; "Prod Segment"; Option)
        {
            Caption = 'Prod Segment';
            DataClassification = CustomerContent;
            OptionMembers = CSG,ISG,Blank;
            OptionCaption = 'CSG,ISG,Blank';
        }
        field(50122; "Inv Below 45 Days"; Decimal)
        {
            Caption = 'Inv Below 45 Days';
            DataClassification = CustomerContent;
        }
        field(50123; "Inv 45-90 Days"; Decimal)
        {
            Caption = 'Inv 45-90 Days';
            DataClassification = CustomerContent;
        }
        field(50124; "Inv Below 91-180 Days"; Decimal)
        {
            Caption = 'Inv Below 91-180 Days';
            DataClassification = CustomerContent;
        }
        field(50125; "Inv Below 181-360 Days"; Decimal)
        {
            Caption = 'Inv Below 181-360 Days';
            DataClassification = CustomerContent;
        }
        field(50126; "Inv Above 360 Days"; Decimal)
        {
            Caption = 'Inv Above 360 Days';
            DataClassification = CustomerContent;
        }
        field(50127; "Inv Below 45 Days B2B"; Decimal)
        {
            Caption = 'Inv Below 45 Days B2B';
            DataClassification = CustomerContent;
        }
        field(50128; "Inv 45-90 Days B2B"; Decimal)
        {
            Caption = 'Inv 45-90 Days B2B';
            DataClassification = CustomerContent;
        }
        field(50129; "Inv Below 91-180 Days B2B"; Decimal)
        {
            Caption = 'Inv Below 91-180 Days B2B';
            DataClassification = CustomerContent;
        }
        field(50130; "Inv Below 181-360 Days B2B"; Decimal)
        {
            Caption = 'Inv Below 181-360 Days B2B';
            DataClassification = CustomerContent;
        }
        field(50131; "Inv Above 360 Days B2B"; Decimal)
        {
            Caption = 'Inv Above 360 Days B2B';
            DataClassification = CustomerContent;
        }
        field(50132; "Inv Below 45 Days SNS"; Decimal)
        {
            Caption = 'Inv Below 45 Days SNS';
            DataClassification = CustomerContent;
        }
        field(50133; "Inv 45-90 Days SNS"; Decimal)
        {
            Caption = 'Inv 45-90 Days SNS';
            DataClassification = CustomerContent;
        }
        field(50134; "Inv Below 91-180 Days SNS"; Decimal)
        {
            Caption = 'Inv Below 91-180 Days SNS';
            DataClassification = CustomerContent;
        }
        field(50135; "Inv Below 181-360 Days SNS"; Decimal)
        {
            Caption = 'Inv Below 181-360 Days SNS';
            DataClassification = CustomerContent;
        }
        field(50136; "Inv Above 360 Days SNS"; Decimal)
        {
            Caption = 'Inv Above 360 Days SNS';
            DataClassification = CustomerContent;
        }
    }
}
