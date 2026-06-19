report 50008 "Vendor Statment"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Layouts\VendorStatement.rdl';
    DefaultLayout = RDLC;
    Caption = 'Vendor Statment'; // working properly
    ApplicationArea = All;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
             RequestFilterFields = "No.";
            column(Rp_Date; Rp_Date)
            {
            }
            column(CmpName; CmpInfo.Name)
            {
            }
            column(CmpAddr; CmpInfo.Address)
            {
            }
            column(CmpAddr2; CmpInfo."Address 2")
            {
            }
            column(CmpCity; CmpInfo.City)
            {
            }
            column(CmpPhone; CmpInfo."Phone No.")
            {
            }
            column(CmpPhone2; CmpInfo."Phone No. 2")
            {
            }
            column(CmpMail; CmpInfo."E-Mail")
            {
            }
            column(CmpPostCode; CmpInfo."Post Code")
            {
            }
            column(CmpCountry; CmpInfo.County)
            {
            }
            column(CmpTinNo; CmpInfo."GST Registration No.")
            {
            }
            column(CmpPanNo; CmpInfo."P.A.N. No.")
            {
            }
            column(CmpPicture; CmpInfo.Picture)
            {
            }
            column(Cust_No; Vendor."No.")
            {
            }
            column(Cust_Name; Vendor.Name)
            {
            }
            column(Cust_Addr; Vendor.Address)
            {
            }
            column(Cust_Addr2; Vendor."Address 2")
            {
            }
            // column(Cust_Addr3; Vendor."Address 2")//vk
            // {
            // }
            column(Cust_City; Vendor.City)
            {
            }
            column(Cust_Post_Code; Vendor."Post Code")
            {
            }
            column(Cust_Country; Vendor.County)
            {
            }
            column(Cust_Contact; Vendor.Contact)
            {
            }
            column(Cust_Phone; Vendor."Phone No.")
            {
            }
            column(Cust_Mob2; Vendor."GST Registration No.")
            {
            }
            column(Cust_Email; Vendor."E-Mail")
            {
            }
            column(Cust_TinNo; Vendor."GST Registration No.")
            {
            }
            column(Cust_Pan; Vendor."P.A.N. No.")
            {
            }
            column(CustOpAmt; CustOpAmt)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Naration_H; Naration_H)
            {
            }
            Column(RecNotFound; RecNotFound)
            {
            }
            column(CloseAmtToWord; CloseAmtToWord[1])
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No."=field("No.");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code")order(ascending);

                column(LedEntryNo; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(Credit_Amount; "Credit Amount")
                {
                }
                column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(Posting_Date; Format("Posting Date"))
                {
                }
                column(Doct_Type; DoctType)
                {
                }
                column(Doct_No; DocNo1)
                {
                }
                column(Doct_Desc; "Vendor Ledger Entry".Description)
                {
                }
                column(UserIdCrBy; "Vendor Ledger Entry"."User ID")
                {
                }
                column(DueDate; Format("Due Date"))
                {
                }
                column(Amount; "Vendor Ledger Entry".Amount)
                {
                }
                column(DrAmt; DrAmt)
                {
                }
                column(CrAmt; CrAmt)
                {
                }
                column(AmtToWords; NoText[1])
                {
                }
                column(NarrarionTeXt; NarrarionTeXt)
                {
                }
                column(TDSAmnt_1; TDSAmnt[1])
                {
                }
                column(TDSText_1; TDSText[1])
                {
                }
                column(TDSAmnt_2; TDSAmnt[2])
                {
                }
                column(TDSText_2; TDSText[2])
                {
                }
                column(TDSAmnt_3; TDSAmnt[3])
                {
                }
                column(TDSText_3; TDSText[3])
                {
                }
                column(TDSAmnt_4; TDSAmnt[4])
                {
                }
                column(TDSText_4; TDSText[4])
                {
                }
                column(TDSAmnt_5; TDSAmnt[5])
                {
                }
                column(TDSText_5; TDSText[5])
                {
                }
                column(RunningAmtVend; RunningAmtVend)
                {
                }
                column(CustOpAmt2; CustOpAmt)
                {
                }
                column(ItemQty; ItemQty)
                {
                }
                column(ItemRate; ItemRate)
                {
                }
                column(Vehcile; Vehcile)
                {
                }
                column(ItemAmount; totalAmout)
                {
                }
                column(ItemDescri; ItemDescri)
                {
                }
                column(ItemDEsc2; ItemDEsc2)
                {
                }
                column(FreightAmount; FreightAmount)
                {
                }
                column(FreightName; FreightName)
                {
                }
                column(Remaining_Amount; "Remaining Amount")
                {
                }
                column(AmountinWord; CloseAmtToWord[1])
                {
                }
                column(billtext; billtext)
                {
                }
                column(billdateetxt; billdateetxt)
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(Doco; Doco)
                {
                }
                column(BillNo; BillNo)
                {
                }
                column(Biildate; Biildate)
                {
                }
                column(text01; text01)
                {
                }
                dataitem("TDS Entry"; "TDS Entry")
                {
                    DataItemLink = "Document No."=field("Document No."), "Transaction No."=field("Transaction No.");

                    column(RunningAmt; RunningAmt)
                    {
                    }
                    /* column(Description_TDSEntry; "TDS Entry".Description)
                    {
                    } */
                    column(TDSBaseAmount_TDSEntry; "TDS Entry"."TDS Base Amount")
                    {
                    }
                    column(TDSNatureofDeduction_TDSEntry; TDS_Section.Code)
                    {
                    }
                    column(TDSAmount_TDSEntry; "TDS Entry"."TDS Amount")
                    {
                    }
                    column(DrAmt_TDS; DrAmt_TDS)
                    {
                    }
                    column(CrAmt_TDS; CrAmt_TDS)
                    {
                    }
                    column(DrAmt2; DrAmt)
                    {
                    }
                    column(CrAmt2; CrAmt)
                    {
                    }
                    trigger OnAfterGetRecord();
                    begin
                        //MESSAGE('TDS table  '+FORMAT("TDS Entry"."TDS Amount"));
                        RunningAmt+="TDS Entry"."TDS Amount";
                        Clear(TDS_Section);
                        if TDS_Section.Get("TDS Entry".Section)then //TDSNatureofDeduction.Get("TDS Entry"."TDS Nature of Deduction");
                            //CodeText := TDSNatureofDeduction.Code + ' ' + TDSNatureofDeduction.Description + ' ' + Format("TDS Entry"."TDS Section");
                            if "TDS Entry"."TDS Amount" >= 0 then DrAmt_TDS:="TDS Entry"."TDS Amount"
                            else
                                CrAmt_TDS:="TDS Entry"."TDS Amount";
                        Counter+=1;
                        if Counter > 1 then begin
                            DrAmt:=0;
                            CrAmt:=0;
                        end;
                    end;
                }
                trigger OnPreDataItem();
                begin
                    SetRange(Reversed, false);
                    SetRange("Posting Date", StartDate, EndDate);
                    RunningAmt:=CustOpAmt;
                    DocNo:='';
                    SetFilter("Document No.", '<>%1', 'TDSAJ-0000**');
                end;
                trigger OnAfterGetRecord();
                begin
                    //INVOICE
                    Clear(Biildate);
                    Clear(ItemQty);
                    Clear(ItemRate);
                    Clear(FreightAmount);
                    Clear(FreightName);
                    Clear(Vehcile);
                    Clear(ItemAmount);
                    Clear(ItemDEsc2);
                    Clear(ItemDescri);
                    Clear(BillNo);
                    Clear(totalAmout);
                    Clear(billdateetxt);
                    ItemAmount:=0;
                    Vehcile:='';
                    ItemQty:=0;
                    totalAmout:=0;
                    ItemDescri:='';
                    ItemDEsc2:='';
                    billdateetxt:='';
                    Biildate:=0D;
                    PHheader.Reset();
                    PHheader.SetRange("Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                    // if PHheader.FindSet() then begin
                    //     Vehcile := PHheader.Narration;
                    //     Biildate := PHheader."Vendor Invoice Date";
                    //     BillNo := PHheader."Vendor Invoice No.";
                    // end;
                    PHI.Reset();
                    PHI.SetRange("Document No.", PHheader."No.");
                    // PHI.SetRange("Buy-from Vendor No.", PHheader."Buy-from Vendor No.");
                    if PHI.FindFirst()then begin
                        repeat if "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Invoice then case PHI.Type of PHI.Type::Item: begin
                                    ItemQty+=PHI.Quantity;
                                    ItemRate:=PHI."Unit Cost";
                                    ItemDescri:=PHI.Description;
                                    ItemDEsc2:=PHI."Description 2";
                                    totalAmout+=PHI."Line Amount";
                                // ItemAmount := totalAmout / ItemQty;
                                end;
                                PHI.Type::"Charge (Item)": ChargeItemAMt+=PHI."Line Amount";
                                PHI.Type::"G/L Account": begin
                                    FreightName:=PHI.Description;
                                    FreightAmount+=PHI."Line Amount";
                                end;
                                end;
                        until PHI.Next = 0;
                    end;
                    // Clear(Biildate);
                    // Clear(ItemQty);
                    // Clear(ItemRate);
                    // Clear(FreightAmount);
                    // Clear(FreightName);
                    // Clear(Vehcile);
                    // Clear(ItemAmount);
                    // Clear(ItemDEsc2);
                    // Clear(ItemDescri);
                    // Clear(BillNo);
                    // Clear(totalAmout);
                    // Clear(billdateetxt);
                    PHcredheader.Reset();
                    PHcredheader.SetRange("Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                    if PHcredheader.FindSet()then begin
                        Vehcile:=PHcredheader."Vehicle No.";
                        // Biildate := PHcredheader."Vendor Invoice Date";
                        // BillNo := PHcredheader."Ex.Invoice No.";
                        billtext:='Bill No.';
                        billdateetxt:='Bill Date.';
                    end;
                    //CREDIT MEMO
                    PCHM.Reset();
                    PCHM.SetRange("Document No.", PHcredheader."No.");
                    // PHI.SetRange("Buy-from Vendor No.", PHheader."Buy-from Vendor No.");
                    if PCHM.FindFirst()then begin
                        repeat if "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::"Credit Memo" then case PCHM.Type of PCHM.Type::Item: begin
                                    ItemQty+=PCHM.Quantity;
                                    ItemRate:=PCHM."Unit Cost";
                                    ItemDescri:=PCHM.Description;
                                    text01:='N' + '' + ',@';
                                    ItemDEsc2:=PCHM."Description 2";
                                    totalAmout+=PCHM."Line Amount";
                                end;
                                PCHM.Type::"Charge (Item)": ChargeItemAMt+=PCHM."Line Amount";
                                PCHM.Type::"G/L Account": begin
                                    FreightName:=PCHM.Description + '' + ',@';
                                    FreightAmount+=PCHM."Line Amount";
                                end;
                                end;
                        until PCHM.Next = 0;
                    end;
                    Clear(Doco);
                    Clear(billtext);
                    if "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Payment then begin
                        Doco:="Vendor Ledger Entry"."Document No.";
                    end;
                    DrAmt:=0;
                    CrAmt:=0;
                    DocNo1:=DocNo1 + ' - ' + Format("Vendor Ledger Entry"."Entry No.");
                    NarrarionTeXt:='';
                    PostedNarration.Reset;
                    PostedNarration.SetRange("Entry No.", 0);
                    PostedNarration.SetRange("Transaction No.", "Transaction No.");
                    if PostedNarration.FindFirst then NarrarionTeXt:=PostedNarration.Narration;
                    //MESSAGE("Vendor Ledger Entry"."Document No."+'   '+FORMAT(Amount));
                    if(Amount - "Vendor Ledger Entry"."Total TDS Including SHE CESS") >= 0 then DrAmt:=Amount - "Vendor Ledger Entry"."Total TDS Including SHE CESS"
                    else
                        CrAmt:=Amount - "Vendor Ledger Entry"."Total TDS Including SHE CESS";
                    /*IF "Vendor Ledger Entry"."Posting Date" > 20210809D THEN
					  MESSAGE("Vendor Ledger Entry"."Document No." +'  '+FORMAT(DrAmt)+'  '+FORMAT(CrAmt)+'  '+FORMAT(RunningAmt));*/
                    RunningAmt:=RunningAmt + DrAmt + CrAmt;
                    if Format("Document Type") = '' then DoctType:='Journal'
                    else
                        DoctType:=Format("Document Type");
                    // AmtToWordsRep.InitTextVariable;
                    // AmtToWordsRep.FormatNoText(NoText, Abs(RunningAmt), Currency.Code);
                    RunningAmtVend:=RunningAmt;
                    Counter:=0;
                end;
            }
            trigger OnPreDataItem();
            begin
                if VendNo <> '' then SetRange("No.", VendNo);
                CmpInfo.Get;
                CmpInfo.CalcFields(Picture);
                if Location.Get('PAHARGANJ')then;
                if StartDate <> 0D then Rp_Date:='Date ' + Format(StartDate) + ' to ' + Format(EndDate);
                if Rp_Date = '' then Rp_Date:='Date ' + Format(WorkDate);
                // <<<  LOCATION FILTER >>>
                if LocationFilter <> '' then SetRange("Location Code", LocationFilter);
            end;
            trigger OnAfterGetRecord();
            begin
                CustOpAmt:=0;
                RunningAmt:=0;
                DetCustLedEnt.Reset;
                DetCustLedEnt.SetRange(DetCustLedEnt."Vendor No.", "No.");
                DetCustLedEnt.SetRange(DetCustLedEnt."Posting Date", 0D, StartDate - 1);
                DetCustLedEnt.CalcSums(DetCustLedEnt.Amount);
                CustOpAmt:=DetCustLedEnt.Amount;
                //new//
                RecNotFound:=FALSE;
                VLERec.RESET;
                VLERec.SETRANGE("Vendor No.", Vendor."No.");
                VLERec.SETRANGE("Posting Date", StartDate, EndDate);
                VLERec.SETRANGE(Reversed, FALSE);
                IF NOT VLERec.FINDFIRST THEN RecNotFound:=TRUE;
                CLEAR(CloseAmtToWord[1]);
                IF RecNotFound THEN BEGIN
                    // AmtToWordsRep.InitTextVariable;
                    // AmtToWordsRep.FormatNoText(CloseAmtToWord, ABS(CustOpAmt), Currency.Code);
                END;
            ////
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(Vendor; VendNo)
                {
                    ApplicationArea = Basic;
                    TableRelation = Vendor;
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = Basic;
                }
                field(Narration; Naration_H)
                {
                    ApplicationArea = Basic;
                    Caption = 'Narration';
                }
                field("Location"; LocationFilter)
                {
                    ApplicationArea = Basic;
                    TableRelation = Location;
                }
            }
        }
        actions
        {
        }
    }
    var LocationFilter: Code[20]; // New variable for filtering by location
    //  Doco: Code[20];
    LineNarration: Text;
    // PostedNarration: Record "Posted Narration";
    PurComLine: Record "Purch. Comment Line";
    GL: Record "G/L Account";
    Discription: Text[100];
    PHI: Record "Purch. Inv. Line";
    VenRec: Record Vendor;
    PurchaseLine: Record "Purchase Line";
    //  RecNotFound: Boolean;
    VLE: Record "Vendor Ledger Entry";
    totalgst: Decimal;
    ChargeItemAMt: Decimal;
    VenRecs: Record Vendor;
    Doco: Code[50];
    billtext: text[100];
    billdateetxt: Text[100];
    Purchaseheader: Record "Purchase Header";
    PCHM: Record "Purch. Cr. Memo Line";
    PHheader: Record "Purch. Inv. Header";
    PHcredheader: Record "Purch. Cr. Memo Hdr.";
    TotalAmount: Decimal;
    text01: Text[100];
    Biildate: Date;
    BillNo: Code[50];
    ItemDescri: Text[200];
    ItemQty: Decimal;
    ItemRate: Decimal;
    //        AmtToWordsRep: Report Check;
    Vehcile: Code[50];
    ItemAmount: Decimal;
    ItemDEsc2: Text[200];
    FreightAmount: Decimal;
    FreightName: Text[200];
    totalAmout: Decimal;
    StartDate: Date;
    EndDate: Date;
    DetCustLedEnt: Record "Detailed Vendor Ledg. Entry";
    CustOpAmt: Decimal;
    RunningAmt: Decimal;
    CmpInfo: Record "Company Information";
    VendNo: Code[20];
    DrAmt: Decimal;
    CrAmt: Decimal;
    DoctType: Text;
    // AmtToWordsRep: Report "Posted Voucher";
    NoText: array[2]of Text;
    Currency: Record Currency;
    NarrarionTeXt: Text;
    PostedNarration: Record "Posted Narration";
    Location: Record Location;
    TDSAmnt: array[10]of Decimal;
    TDSText: array[10]of Text;
    TDSEntry_Rec: Record "TDS Entry";
    Int: Integer;
    Naration_H: Boolean;
    Rp_Date: Text;
    //TDSNatureofDeduction: Record "TDS Nature of Deduction";
    CodeText: Text;
    DrAmt_TDS: Decimal;
    CrAmt_TDS: Decimal;
    RunningAmtVend: Decimal;
    Counter: Integer;
    DocNo: Text;
    DocNo1: Text;
    VLERec: Record "Vendor Ledger Entry";
    RecNotFound: Boolean;
    // CloseAmtToWord: Text;
    CloseAmtToWord: array[10]of Text;
    TDS_Section: Record "TDS Section";
    procedure SetData(StartDate1: Date; EndDate1: Date; CustomerNo1: Text)
    begin
        StartDate:=StartDate1;
        EndDate:=EndDate1;
        VendNo:=CustomerNo1;
    end;
}
