tableextension 50033 "TransfrShpmntHrd" extends "Transfer Shipment Header"
{
  fields
  {
    field(50000; "Processing Type"; Enum Process)
    {
      DataClassification = ToBeClassified;
    }
  }
}