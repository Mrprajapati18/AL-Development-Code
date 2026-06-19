table 50130 "Job Work Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.get();
                    // NoSeriesMgt.TestManual(SalesSetup."Job Work Challan No.");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; "Outward challan No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Transfer Shipment Header"."No.";
            trigger OnValidate()
            var
                RecTransfrShpmntHdr: Record "Transfer Shipment Header";
                RecTransfrShpmntLine: Record "Transfer Shipment Line";
                Reclocation: Record Location;
                RecGst: Record "Detailed GST Ledger Entry";
                CGST: Decimal;
                IGST: Decimal;
                SGST: Decimal;
                TotalGst: Decimal;
                Item: Record Item;
            begin
             
                RecTransfrShpmntHdr.Reset();
                RecTransfrShpmntHdr.SetRange("No.", Rec."Outward challan No.");
                if RecTransfrShpmntHdr.FindFirst() then begin
                    Rec."JobWork Location Code" := RecTransfrShpmntHdr."Transfer-to Code";
                    rec."JobWork Location Name" := RecTransfrShpmntHdr."Transfer-to Name";
                end;
               


                RecTransfrShpmntLine.Reset();
                RecTransfrShpmntLine.SetRange("document no.", Rec."Outward challan No.");
                if RecTransfrShpmntLine.FindFirst() then begin
                    repeat
                        ///......
                        // IF (STRPOS(RecTransfrShpmntLine."Item No.", 'CT-') = 1) then begin  
                        JobWorkLine.Init();
                        JobWorkLine."No." := Rec."No.";
                        JobWorkLine."Line No." := RecTransfrShpmntLine."Line No.";
                        JobWorkLine.Insert();
                        JobWorkLine."Outward Challan No." := RecTransfrShpmntLine."Document No.";
                        JobWorkLine.validate("Outward Item No.", RecTransfrShpmntLine."Item No.");
                        Item.Get(RecTransfrShpmntLine."Item No.");
                        JobWorkLine."Outward Item Discription" := Item.Description;
                        JobWorkLine."Outward Quantity" := RecTransfrShpmntLine.Quantity;
                        JobWorkLine."Outward Unit of Measure" := RecTransfrShpmntLine."Unit of Measure";
                        JobWorkLine."Outward Amount" := RecTransfrShpmntLine.Amount;
                        JobWorkLine."JobWork Location Code" := Rec."JobWork Location Code";
                        JobWorkLine."JobWork Location Name" := Rec."JobWork Location Name";
                        JobWorkLine.modify();

                        RecGst.Reset();
                        RecGst.SetRange("Document No.", Rec."Outward challan No.");
                        RecGst.SetRange("Document Line No.", JobWorkLine."Line No.");
                        If RecGst.FindFirst() then begin
                            If RecGst."GST Component Code" = 'CGST' then begin
                                JobWorkLine."Outward CGST" := ABS(RecGst."GST Amount");
                            end;
                            if RecGst."GST Component Code" = 'SGST' then begin
                                JobWorkLine."Outward SGST" := ABS(RecGst."GST Amount");

                            end;
                            if RecGst."GST Component Code" = 'IGST' then begin
                                JobWorkLine."Outward IGST" := ABS(RecGst."GST Amount");
                            end;
                        end;
                        JobWorkLine.Modify();
            
                    until RecTransfrShpmntLine.Next() = 0;

                end;
                RecTransfrShpmntHdr.Reset();
                RecTransfrShpmntHdr.SetRange("No.", Rec."Outward challan No.");
                if RecTransfrShpmntHdr.FindFirst() then begin
                    Rec."Outward Date" := RecTransfrShpmntHdr."Posting Date";
                    Reclocation.Reset();
                    Reclocation.SetRange(Code, RecTransfrShpmntHdr."Transfer-to Code");
                    if Reclocation.FindFirst() then begin
                        Rec."Outward Gst No." := Reclocation."GST Registration No.";
                        Rec."Outward State" := Reclocation."State Code";
                        Rec."Outward Type" := 'SEZ';

                    end;
                    // rec."Processing Type" := RecTransfrShpmntHdr."Processing Type"; // Durgehs
                end;

                //TotalGst := CGST + IGST + SGST;
                //Message('%1', TotalGst);
                // end;
            end;
        }

        field(3; "Outward Gst No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Outward State"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Outward Type"; text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Outward Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        
        field(7; "Inward challan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RecTransfrShpmntHdr: Record "Transfer Shipment Header";
                RecTransfrShpmntLine: Record "Transfer Shipment Line";
                Reclocation: Record Location;
                JobWorkLine: Record "Job work Line";
                JobworkLine2: Record "Job work Line";
                Item: Record Item;
            begin
                RecTransfrShpmntHdr.Reset();
                RecTransfrShpmntHdr.SetRange("No.", Rec."Outward challan No.");
                if RecTransfrShpmntHdr.FindFirst() then begin
                    Rec."Inward Date" := Today;
                    Reclocation.Reset();
                    Reclocation.SetRange(Code, RecTransfrShpmntHdr."Transfer-to Code");
                    if Reclocation.FindFirst() then begin
                        Rec."Inward Gst" := Reclocation."GST Registration No.";
                        Rec."Inward State" := Reclocation."State Code";
                        Rec."Inward Type" := 'SEZ';
                    end;

                end;

                // JobWorkLine.Reset();
                // JobWorkLine.SetRange("No.", rec."No.");
                // if JobWorkLine.FindFirst() then begin
                //     repeat
                //         RecTransfrShpmntLine.Get(rec."Outward Challan No.", JobWorkLine."Line No.");
                //         JobWorkLine.validate("Inward Item no.", RecTransfrShpmntLine."Item No.");
                //         Item.Get(RecTransfrShpmntLine."Item No.");
                //         JobWorkLine."Inward Item Description" := Item.Description;
                //         JobWorkLine."Received UOM" := RecTransfrShpmntLine."Unit of Measure";
                //         JobWorkLine.Modify();
                //     until JobWorkLine.Next() = 0;
                // end;


            end;


        }
        field(8; "Inward Gst"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Inward State"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Inward Type"; Text[25])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Inward Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "JobWork Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(14; "JobWork Location Name"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        
        field(15; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Processing Type"; enum Process)
        {
            DataClassification = ToBeClassified;
        }
       

    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var

    begin
        //  Number := NoSeriesMgt.GetNextNo('J001', Today, true);
        // Rec."No." := Number;
        // if "No." = '' then begin
        //     SalesSetup.Get();
        //     //TestNoSeries;
        //     NoSeriesMgt.InitSeries(SalesSetup."Job Work Challan No.", xRec."No. Series", 0D, "No.", "No. Series");
        // end;
        // if "No." = '' then begin
        //     SalesSetup.Get();
        //     SalesSetup.TestField("Job Work Challan No.");
        //     NoSeriesMgt.InitSeries(SalesSetup."Job Work Challan No.", xRec."No. Series", 0D, "No.", "No. Series");
        // end;
        
    end;


    var
        JobWorkLine: Record "Job work Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        Number: Code[20];
        SalesSetup: Record "Sales & Receivables Setup";
        OutwardQty: Decimal;
        INwardQty: Decimal;



}