tableextension 50027 "Customer card PBS" extends Customer
{
    fields
    {
        field(50001; "Aadhar No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}