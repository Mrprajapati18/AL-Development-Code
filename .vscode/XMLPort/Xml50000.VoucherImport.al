xmlport 50000 "Voucher Import"
{
    Format = VariableText;
    TextEncoding = WINDOWS;
    UseRequestPage = false;

    schema
    {
        textelement(VoucherImport)
        {
            MinOccurs = Zero;
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoSave = false;
                XmlName = 'VoucherImport';
                textelement(PostingDate)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentType)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentNo)
                {
                    MinOccurs = Zero;
                }
                textelement(PartyType)
                {
                    MinOccurs = Zero;
                }
                textelement(PartyCode)
                {
                    MinOccurs = Zero;
                }
                textelement(AccountType)
                {
                    MinOccurs = Zero;
                }
                textelement(AccountNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Description)
                {
                    MinOccurs = Zero;
                }
                textelement(Advance)
                {
                    MinOccurs = Zero;
                }
                textelement(PrincipleAmount)
                {
                    MinOccurs = Zero;
                }
                textelement(TDSNatureOfDeduction)
                {
                    MinOccurs = Zero;
                }
                textelement(AmountValue)
                {
                    MinOccurs = Zero;
                }
                textelement(DebitAmount)
                {
                    MinOccurs = Zero;
                }
                textelement(CreditAmount)
                {
                    MinOccurs = Zero;
                }
                textelement(BalAccountType)
                {
                    MinOccurs = Zero;
                }
                textelement(BalAccountNo)
                {
                    MinOccurs = Zero;
                }
                textelement(LocationCode)
                {
                    MinOccurs = Zero;
                }
                textelement(AppToDocType)
                {
                    MinOccurs = Zero;
                }
                textelement(AppToDocNo)
                {
                    MinOccurs = Zero;
                }
                textelement(BranceResCode)
                {
                    MinOccurs = Zero;
                }
                textelement(PaymentRefNo)
                {
                    MinOccurs = Zero;
                }
                textelement(PaymantRefDate)
                {
                    MinOccurs = Zero;
                }
                textelement(TDSTCSBaseAmt)
                {
                    MinOccurs = Zero;
                }
                textelement(TDSTCSAmt)
                {
                    MinOccurs = Zero;
                }
                textelement(TDSTCSPer)
                {
                    MinOccurs = Zero;
                }
                textelement(BankRefNo)
                {
                    MinOccurs = Zero;
                }
                textelement(ExternalDocNo)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentDate)
                {
                    MinOccurs = Zero;
                }
                textelement(LineNarration)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                var
                    DebitAmt: Decimal;
                    CreditAmt: Decimal;
                begin
                    intCounter += 1;
                    if (intCounter > 1) and (AccountType <> '') then begin
                        recGenLine.Init;
                        recGenLine.Validate("Journal Template Name", cdTemplateCode);
                        recGenLine.Validate("Journal Batch Name", cdBatchCode);
                        intLineNo += 10000;
                        recGenLine.Validate("Line No.", intLineNo);
                        recGenLine.Insert(true);
                        recGenLine.Reset;
                        recGenLine.SetRange("Journal Template Name", cdTemplateCode);
                        recGenLine.SetRange("Journal Batch Name", cdBatchCode);
                        recGenLine.SetRange("Line No.", intLineNo);
                        recGenLine.FindFirst;
                        Evaluate(recGenLine."Posting Date", PostingDate);
                        recGenLine.Validate("Posting Date");
                        if DocumentType <> '' then Evaluate(recGenLine."Document Type", DocumentType);
                        recGenLine.Validate("Document Type");
                        if DocumentNo <> '' then cdDocumentNo := DocumentNo;
                        recGenLine.Validate("Document No.", cdDocumentNo);
                        if DocumentDate <> '' then Evaluate(recGenLine."Document Date", DocumentDate);
                        recGenLine.Validate("Document Date");
                        recGenLine."External Document No." := ExternalDocNo;
                        if LocationCode <> '' then Evaluate(recGenLine."Location Code", LocationCode);
                        recGenLine.Validate("Location Code");
                        if PartyType <> '' then Evaluate(recGenLine."Party Type", PartyType);
                        recGenLine.Validate("Party Type");
                        if PartyCode <> '' then recGenLine.Validate("Party Code", PartyCode);
                        Evaluate(recGenLine."Account Type", AccountType);
                        recGenLine.Validate("Account Type");
                        recGenLine.Validate("Account No.", AccountNo);
                        recGenLine.Validate(Description, Description);
                        // Evaluate(recGenLine.Advance, Advance);
                        // Evaluate(recGenLine."Principle Amount", PrincipleAmount);
                        // recGenLine.Validate("Principle Amount");

                        if BalAccountType <> '' then Evaluate(recGenLine."Bal. Account Type", BalAccountType);
                        recGenLine.Validate("Bal. Account Type");
                        recGenLine.Validate("Bal. Account No.", BalAccountNo);

                        Clear(DebitAmt);
                        Clear(CreditAmt);

                        // IF AmountValue<>'' THEN EVALUATE(recGenLine.Amount,AmountValue);
                        //recGenLine.VALIDATE(Amount);
                        if DebitAmount <> '' then Evaluate(DebitAmt, DebitAmount);
                        if DebitAmt <> 0 then
                            recGenLine.Validate("Debit Amount", DebitAmt);

                        if CreditAmount <> '' then Evaluate(CreditAmt, CreditAmount);
                        if CreditAmt <> 0 then
                            recGenLine.Validate("Credit Amount", CreditAmt);
                        // if TDSNatureOfDeduction <> '' then recGenLine.Validate("TDS Nature of Deduction", TDSNatureOfDeduction);
                        // if TDSTCSBaseAmt <> '' then Evaluate(recGenLine."TDS/TCS Base Amount", TDSTCSBaseAmt);
                        // recGenLine.Validate("TDS/TCS Base Amount");
                        // if TDSTCSPer <> '' then Evaluate(recGenLine."TDS/TCS %", TDSTCSPer);
                        // recGenLine.Validate("TDS/TCS %");
                        // if TDSTCSAmt <> '' then Evaluate(recGenLine."TDS/TCS Amount", TDSTCSAmt);
                        // recGenLine.Validate("TDS/TCS Amount");

                        if AppToDocType <> '' then Evaluate(recGenLine."Applies-to Doc. Type", AppToDocType);
                        recGenLine.Validate("Applies-to Doc. Type");
                        recGenLine.Validate("Applies-to Doc. No.", AppToDocNo);
                        recGenLine.Validate("Shortcut Dimension 1 Code", BranceResCode);
                        // if PaymentRefNo <> '' then Evaluate(recGenLine."Payment Ref.", PaymentRefNo);
                        // recGenLine.Validate("Payment Ref.");
                        // if PaymantRefDate <> '' then Evaluate(recGenLine."Payment Ref. Date", PaymantRefDate);
                        // recGenLine.Validate("Payment Ref. Date");
                        // if BankRefNo <> '' then Evaluate(recGenLine."Bank Refrence No.", BankRefNo);
                        recGenLine.Modify(true);
                        if BalAccountNo = '' then decTotalAmount += recGenLine.Amount;
                        if decTotalAmount = 0 then begin
                            if LineNarration <> '' then begin
                                recGenNarration.Reset();
                                recGenNarration.SetRange("Journal Template Name", cdTemplateCode);
                                recGenNarration.SetRange("Journal Batch Name", cdBatchCode);
                                recGenNarration.SetRange("Document No.", cdDocumentNo);
                                recGenNarration.SetRange("Gen. Journal Line No.", 0);
                                if recGenNarration.FindFirst() then recGenNarration.DeleteAll();
                                recGenNarration.Init();
                                recGenNarration."Journal Template Name" := cdTemplateCode;
                                recGenNarration."Journal Batch Name" := cdBatchCode;
                                recGenNarration."Document No." := cdDocumentNo;
                                recGenNarration."Gen. Journal Line No." := 0;
                                recGenNarration."Line No." := 10000;
                                recGenNarration.Narration := LineNarration;
                                recGenNarration.Insert();
                            end;
                            cdDocumentNo := IncStr(cdDocumentNo);
                        end;
                    end;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        Message('Data has been successfully uploaded');
    end;

    trigger OnPreXmlPort()
    begin
        if (cdTemplateCode = '') or (cdBatchCode = '') then Error('The Template or Batch code must not be blank.');
        recGenLine.Reset;
        recGenLine.SetRange("Journal Template Name", cdTemplateCode);
        recGenLine.SetRange("Journal Batch Name", cdBatchCode);
        if recGenLine.FindLast then begin
            intLineNo := recGenLine."Line No.";
            cdDocumentNo := IncStr(recGenLine."Document No.");
        end
        else begin
            intLineNo := 0;
            recGenBatch.Get(cdTemplateCode, cdBatchCode);
            if recGenBatch."No. Series" <> '' then begin
                recGenBatch.TestField("No. Series");
                recNoSeriesLine.Reset();
                recNoSeriesLine.SetRange("Series Code", recGenBatch."No. Series");
                recNoSeriesLine.SetFilter("Starting Date", '..%1', WorkDate());
                recNoSeriesLine.FindLast();
                if recNoSeriesLine."Last No. Used" = '' then
                    cdDocumentNo := recNoSeriesLine."Starting No."
                else
                    cdDocumentNo := IncStr(recNoSeriesLine."Last No. Used");
            end
            else
                cdDocumentNo := '1';
        end;
        intCounter := 0;
        decTotalAmount := 0;
    end;

    var
        cdTemplateCode: Code[10];
        cdBatchCode: Code[10];
        recGenLine: Record "Gen. Journal Line";
        intLineNo: Integer;
        intCounter: Integer;
        cdDocumentNo: Code[20];
        recGenBatch: Record "Gen. Journal Batch";
        recNoSeriesLine: Record "No. Series Line";
        decTotalAmount: Decimal;
        cdTempCode: Code[20];
        recGenNarration: Record "Gen. Journal Narration";
        cuCalculateTax: Codeunit "Purch.-Post";


    procedure SetTemplateBatch(TemplateCode: Code[10]; BatchName: Code[10])
    begin
        cdTemplateCode := TemplateCode;
        cdBatchCode := BatchName;
    end;
}

