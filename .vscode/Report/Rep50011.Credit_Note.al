Report 50005 "CreditNote"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\Credit-Note.rdl';
    ApplicationArea =  All;
    UsageCategory =  ReportsAndAnalysis;
    Caption = 'Credit_Note';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(FORMAT__Sales_Header___Document_Type____________Sales_Header___No__; "Sales Cr.Memo Header"."No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                column(ReportForNavId_1000000111;1000000111)
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(CopyText; StrSubstNo(CopyText))
                {
                }
                column(PageCaption; PageCaption)
                {
                }
                column(Sales_Header___Posting_Date_; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                column(Sales_Header___Document_Date_; "Sales Cr.Memo Header"."Document Date")
                {
                }
                column(LineComment; LineComment)
                {
                }
                column(Name_CompanyInformation; CompInfo.Name)
                {
                }
                column(CompInfo_Name; Loc.Name)
                {
                }
                column(CompInfo_Address; Loc.Address)
                {
                }
                column(CompInfo_Address_2; Loc."Address 2")
                {
                }
                column(CompInfo_Phone_No; CompInfo."Phone No.")
                {
                }
                column(website; CompInfo."Home Page")
                {
                }
                column(CompInfo_Phone_No2; Loc."Phone No. 2")
                {
                }
                column(CompInfo_Picture; CompInfo.Picture)
                {
                }
                column(PinCode; Loc."Post Code")
                {
                }
                column(CompInfo_City; Loc.City)
                {
                }
                column(CompInfo_Country; Loc.County)
                {
                }
                column(CompInfo_fax; Loc."Fax No.")
                {
                }
                column(CompInfo_Email; CompInfo."E-Mail")
                {
                }
                column(CompInfo_GSTReg; Loc."GST Registration No.")
                {
                }
                column(state_Name; statesrec.Description)
                {
                }
                column(State_Code; statesrec."State Code (GST Reg. No.)")
                {
                }
                column(SellToAddr_8_; SellToAddr[8])
                {
                }
                column(SellToAddr_7_; SellToAddr[7])
                {
                }
                column(CustPAN; SellToAddr[9])
                {
                }
                column(ExtDocNo; "Sales Cr.Memo Header"."External Document No.")
                {
                }
                column(CustGST; SellToAddr[10])
                {
                }
                column(ShipToCity; ShipToCity)
                {
                }
                column(TermofPayment; ModeofPayment)
                {
                }
                column(HdrCommentText; HdrCommentText)
                {
                }
                column(ExciseDuty; ExciseDuty)
                {
                }
                column(NetValue; NetValue)
                {
                }
                column(Var_TaxType; Var_TaxType)
                {
                }
                column(ExPer; ExPer)
                {
                }
                column(TaxPer; TaxPer)
                {
                }
                column(TaxAmount; TaxAmount)
                {
                }
                column(AmtInWords; AmountInWords[1] + ' ' + AmountInWords[2])
                {
                }
                column(Text001; Text001)
                {
                }
                column(Text002; Text002)
                {
                }
                column(Text003; Text003)
                {
                }
                column(Text004; Text004)
                {
                }
                column(Text005; Text005)
                {
                }
                column(Text006; Text006)
                {
                }
                column(Text007; Text007)
                {
                }
                column(Text008; Text008)
                {
                }
                column(Text009; Text009)
                {
                }
                column(Text010; TeXT010)
                {
                }
                column(PFAmt; PFAmt)
                {
                }
                column(TCSAmt; TCSAmt)
                {
                }
                column(TotAmt; TotAmt)
                {
                }
                column(CashDiscount; CashDiscount)
                {
                }
                column(InvDiscAmt; TotalDiscount)
                {
                }
                column(Var_serviceTax; Var_serviceTax)
                {
                }
                column(FreAmt; FreAmt)
                {
                }
                column(InsuranceAmt; InsuranceAmt)
                {
                }
                column(GTotAmt; GTotAmt)
                {
                }
                column(PVal; PVal)
                {
                }
                column(NetTotal; NetTotal)
                {
                }
                column(IGSTType; IGSTType)
                {
                }
                column(SGSTCaption; SGSTCaption)
                {
                }
                column(CGSTCaption; CGSTCaption)
                {
                }
                column(IGSTCaption; IGSTCaption)
                {
                }
                column(OrderNo_SalesInvoiceHeader; ordno)
                {
                }
                column(Salesperson_Name; salespersonrec.Name)
                {
                }
                column(StateCode_billto; statesrec1.Description)
                {
                }
                column(GSTStatecode; statesrec1."State Code (GST Reg. No.)")
                {
                }
                column(SelltoGST; selltogst)
                {
                }
                column(subtotal; subtotalamt)
                {
                }
                column(totalAmt; totamt1)
                {
                }
                column(selltoname; selltoname)
                {
                }
                column(selltoaddress; selltoaddress)
                {
                }
                column(selltoaddress2; selltoaddress2)
                {
                }
                column(selltocity; selltocity)
                {
                }
                column(selltopostcode; selltopostcode)
                {
                }
                column(selltostate; selltostate)
                {
                }
                column(selltogst1; selltogst1)
                {
                }
                column(selltophone; selltophone)
                {
                }
                column(sellogstregno; selltogstregno)
                {
                }
                column(TotalQty; totalqty)
                {
                }
                column(statename; statename)
                {
                }
                column(tdscode; statecodetds)
                {
                }
                column(User_ID; "Sales Cr.Memo Header"."User ID")
                {
                }
                column(Customer_PAN; Customer."P.A.N. No.")
                {
                }
                column(Customer_GST; Customer."GST Registration No.")
                {
                }
                column(QRCode_SalesCreditMemo; "Sales Cr.Memo Header"."QR Code")
                {
                }
                column(IRN_SalesCreditmemo; "Sales Cr.Memo Header"."IRN Hash")
                {
                }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No."=field("No.");
                    DataItemLinkReference = "Sales Cr.Memo Header";
                    DataItemTableView = sorting("Document No.", "No.")order(descending)where(Type=filter(<>" "), Description=filter(<>'Invoice Round Off'));

                    column(ReportForNavId_1000000015;1000000015)
                    {
                    }
                    column(SNo; SNo)
                    {
                    }
                    column(Description_PurchCrMemoLine; "Sales Cr.Memo Line".Description)
                    {
                    }
                    column(Description2_PurchCrMemoLine; "Sales Cr.Memo Line"."Description 2")
                    {
                    }
                    column(HSNSACCode_PurchCrMemoLine; "Sales Cr.Memo Line"."HSN/SAC Code")
                    {
                    }
                    column(Quantity_PurchCrMemoLine; "Sales Cr.Memo Line".Quantity)
                    {
                    }
                    column(UnitofMeasureCode_PurchCrMemoLine; "Sales Cr.Memo Line"."Unit of Measure Code")
                    {
                    }
                    column(UnitPriceLCY_PurchCrMemoLine; "Sales Cr.Memo Line"."Unit Price")
                    {
                    }
                    column(LineAmount_PurchCrMemoLine; "Sales Cr.Memo Line"."Line Amount")
                    {
                    }
                    column(No_PurchCrMemoLine; "Sales Cr.Memo Line"."No.")
                    {
                    }
                    column(SGSTPer; SGSTPer)
                    {
                    }
                    column(CGSTPer; CGSTPer)
                    {
                    }
                    column(IGSTPer; IGSTPer)
                    {
                    }
                    column(CGSTAmt; CGSTAmt)
                    {
                    }
                    column(SGSTAmt; SGSTAmt)
                    {
                    }
                    column(IGSTAmt; IGSTAmt)
                    {
                    }
                    column(TotSGSTAmt; TotSGSTAmt)
                    {
                    }
                    column(TotCGSTAmt; TotCGSTAmt)
                    {
                    }
                    column(TotIGSTAmt; TotIGSTAmt)
                    {
                    }
                    column(Cmnt1; Var_Comments[1])
                    {
                    }
                    column(cmnt2; Var_Comments[2])
                    {
                    }
                    column(cmnt3; Var_Comments[3])
                    {
                    }
                    column(cmnt4; Var_Comments[4])
                    {
                    }
                    column(cmnt5; Var_Comments[5])
                    {
                    }
                    column(cmnt6; Var_Comments[6])
                    {
                    }
                    column(TDSTCS_SalesCrMemoLine;'')
                    {
                    }
                    column(TDSTCSAmount_SalesCrMemoLine;'')
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        PostedSalesInvLineComment: Record "Sales Comment Line";
                        Rec_Items: Record Item;
                        temp: Integer;
                    begin
                        SNo+=1;
                        temp:="Sales Cr.Memo Line"."Line No.";
                        Rec_PurchCmntLine.SetRange("No.", "Sales Cr.Memo Line"."Document No.");
                        Rec_PurchCmntLine.SetRange("Document Line No.", "Sales Cr.Memo Line"."Line No.");
                        //Rec_PurchCmntLine.SETRANGE("Line No.","Line No.");
                        if Rec_PurchCmntLine.FindSet then repeat Var_Comments[looper]:=Rec_PurchCmntLine.Comment;
                                looper:=looper + 1;
                            until Rec_PurchCmntLine.Next = 0;
                        Clear(CGSTPer);
                        Clear(SGSTPer);
                        Clear(IGSTPer);
                        Clear(CGSTAmt);
                        Clear(SGSTAmt);
                        Clear(IGSTAmt);
                        DetGSTLegEnt.Reset;
                        DetGSTLegEnt.SetRange("Transaction Type", DetGSTLegEnt."transaction type"::Sales);
                        DetGSTLegEnt.SetRange("Document Type", DetGSTLegEnt."document type"::"Credit Memo");
                        DetGSTLegEnt.SetRange("Document No.", "Document No.");
                        DetGSTLegEnt.SetRange("Document Line No.", "Line No.");
                        if DetGSTLegEnt.FindSet then repeat case DetGSTLegEnt."GST Component Code" of 'CGST': begin
                                    CGSTPer:=DetGSTLegEnt."GST %";
                                    CGSTAmt:=Abs(DetGSTLegEnt."GST Amount");
                                    TotCGSTAmt+=CGSTAmt;
                                end;
                                'SGST': begin
                                    SGSTPer:=DetGSTLegEnt."GST %";
                                    SGSTAmt:=Abs(DetGSTLegEnt."GST Amount");
                                    TotSGSTAmt+=SGSTAmt;
                                end;
                                'IGST': begin
                                    IGSTPer+=DetGSTLegEnt."GST %";
                                    IGSTAmt:=Abs(DetGSTLegEnt."GST Amount");
                                    TotIGSTAmt+=IGSTAmt;
                                end;
                                end;
                            until DetGSTLegEnt.Next = 0;
                    end;
                    trigger OnPreDataItem()
                    begin
                        Clear(SNo);
                        Clear(lineamtvar);
                        looper:=1;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then CopyText:='ORIGINAL-FOR RECIPIENT';
                    if Number = 2 then CopyText:='DUPLICATE-FOR TRANSPORTER';
                    if Number = 3 then CopyText:='TRIPLICATE-SUPPLIER';
                    if Number > 3 then CopyText:='Extra Copy';
                    OutputNo+=1;
                    CurrReport.PageNo:=1;
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies); // +  1;
                    if NoOfLoops <= 0 then NoOfLoops:=1;
                    CopyText:='';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo:=0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesCrMemoLine_rec: Record "Sales Cr.Memo Line";
                SalesHdrComment: Record "Sales Comment Line";
                UserSetup: Record "User Setup";
            begin
                "Sales Cr.Memo Header".CalcFields("QR Code");
                if Customer.Get("Sales Cr.Memo Header"."Sell-to Customer No.")then begin
                    selltogst:=Customer."GST Registration No.";
                    if statesrec1.Get("Sales Cr.Memo Header"."Location State Code")then;
                end;
                
                Clear(FreAmt);
                Clear(PFAmt);
                Clear(GTotAmt);
                Loc.Reset;
                if Loc.Get("Sales Cr.Memo Header"."Location Code")then;
                statesrec.Get(Loc."State Code");
                SalesCrMemoLine_rec.Reset;
                SalesCrMemoLine_rec.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                
                Clear(totalqty);
                SalesCrMemoLine_rec.Reset;
                SalesCrMemoLine_rec.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                SalesCrMemoLine_rec.SetFilter(Description, '<>%1', 'Invoice Round Off');
                if SalesCrMemoLine_rec.FindSet then repeat 
                        totalqty+=SalesCrMemoLine_rec.Quantity;
                    until SalesCrMemoLine_rec.Next = 0;
                Clear(totamt1);
                Clear(TCSAmt);
                SalesCrMemoLine_rec.Reset;
                SalesCrMemoLine_rec.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                if SalesCrMemoLine_rec.FindSet then repeat 
                    until SalesCrMemoLine_rec.Next = 0;
                NumToText.InitTextVariable();
                NumToText.FormatNoText(AmountInWords, totamt1, '' + "Currency Code");
                StateRec.Reset;
                if StateRec.Get("Sales Cr.Memo Header".State)then begin
                    selltostate:=StateRec.Description;
                    selltogst1:=StateRec."State Code (GST Reg. No.)";
                end;
                SalesCrMemoLine.Reset;
                SalesCrMemoLine.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                SalesCrMemoLine.SetRange(Description, 'Invoice Round Off');
                if SalesCrMemoLine.FindFirst then RoundOff:=SalesCrMemoLine."Line Amount";
                if "Sales Cr.Memo Header"."Ship-to Code" = '' then begin
                    selltoname:="Sales Cr.Memo Header"."Sell-to Customer Name";
                    selltoaddress:="Sales Cr.Memo Header"."Sell-to Address";
                    selltoaddress2:="Sales Cr.Memo Header"."Sell-to Address 2";
                    selltocity:="Sales Cr.Memo Header"."Sell-to City";
                    selltopostcode:="Sales Cr.Memo Header"."Sell-to Post Code";
                    selltophone:="Sales Cr.Memo Header"."Sell-to Contact";
                    selltogstregno:=Customer."GST Registration No.";
                end;
                if "Sales Cr.Memo Header"."Ship-to Code" <> '' then begin
                    RecShipAddr.Reset;
                    if RecShipAddr.Get("Sales Cr.Memo Header"."Sell-to Customer No.", "Sales Cr.Memo Header"."Ship-to Code")then begin
                        selltoname:=RecShipAddr.Name;
                        selltoaddress:=RecShipAddr.Address;
                        selltoaddress2:=RecShipAddr."Address 2";
                        selltocity:=RecShipAddr.City;
                        selltopostcode:=RecShipAddr."Post Code";
                        selltophone:=RecShipAddr."Phone No.";
                        selltogstregno:=RecShipAddr."GST Registration No.";
                    end;
                end;
                P_code.Reset;
                P_code.SetRange(City, RecShipAddr.City);
                if P_code.FindSet then begin
                    statecode:=P_code.Code;
                end;
                state1.Reset;
                state1.SetRange(Code, P_code.Code);
                if state1.FindSet then begin
                    statename:=state1.Description;
                    statecodetds:=state1."State Code for eTDS/TCS";
                end;
         
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Copies';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
    var CompInfo: Record "Company Information";
    FormatAddr: Codeunit "Format Address";
    SellToAddr: array[10]of Text[50];
    BillToAddr: array[10]of Text[50];
    ShipToAddr: array[10]of Text[50];
    ShipToCity: Text[50];
    LineComment: Boolean;
    SNo: Integer;
    PaymentTerm: Record "Payment Terms";
    ModeofPayment: Text[50];
    Sh: Integer;
    Cust: Record Customer;
    RecShipAddr: Record "Ship-to Address";
    Loc: Record Location;
    RegOffAddr: array[10]of Text[50];
    Description1: array[100]of Text[250];
    NumToText: Report Check;
    Arr_NoText: array[2]of Text[80];
    TotLineAmt: Decimal;
    LineCommentText: Text;
    NoOfLoops: Integer;
    NoOfCopies: Integer;
    CopyText: Text;
    OutputNo: Integer;
    CashDiscount: Decimal;
    InvDiscAmt: Decimal;
    NetValue: Decimal;
    ExciseDuty: Decimal;
    HdrCommentText: Text;
    TaxDetails: Record "Tax Detail";
    TaxPer: Decimal;
    TaxAmount: Decimal;
    Var_serviceTax: Decimal;
    EcessAmt: Decimal;
    Shecess: Decimal;
    Rec_TaxAreaLine: Record "Tax Area Line";
    Rec_TaxDetail: Record "Tax Detail";
    Tax_Jurisdiction: Record "Tax Jurisdiction";
    TaxGrp: Text[30];
    Var_TaxType: Text;
    GrandTotal: Decimal;
    NetTotal: Decimal;
    RoundOff: Decimal;
    BillAmt: Decimal;
    TotalDiscount: Decimal;
    AmountInWords: array[2]of Text[500];
    PstSalesInvLine: Record "Purch. Cr. Memo Line";
    AllowedUser: Boolean;
    ExPer: Decimal;
    ExtendedText: Boolean;
    PL_desc_var: array[10]of Text[250];
    PLdes_index: Integer;
    Rec_ExtenTXTLine: Record "Extended Text Line";
    TextDescVar: Text;
    Text001: label 'EXCISE INVOICE';
    Text002: label '(ISSUE OF INVOICE UNDER RULE 11 OF CENTRAL EXCISE RULES 2002)';
    Text003: label 'BY COURIER';
    Text004: label 'Authenticated By';
    Text005: label 'Authorised Signatory';
    Text006: label 'for ';
    Text007: label 'This is a Computer Generated Invoice';
    Text008: label 'Serial No. in PLA/RG-23';
    Text009: label 'Remarks : BEING ABOVE ITEMS SOLD TO HQNA AGAINSTORDER NO.HQNA/IND/14/AGS/1239/MH/03 DT:12.2.15.';
    TeXT010: label 'Declaration : We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.';
    CGSTPer: Decimal;
    SGSTPer: Decimal;
    CGSTAmt: Decimal;
    SGSTAmt: Decimal;
    IGSTPer: Decimal;
    IGSTAmt: Decimal;
    IGSTType: Boolean;
    DetGSTLegEnt: Record "Detailed GST Ledger Entry";
    BCGSTin: Code[20];
    TotAmtToCust: Decimal;
    TotSGSTAmt: Decimal;
    TotCGSTAmt: Decimal;
    TotIGSTAmt: Decimal;
    StateRec: Record State;
    FreAmt: Decimal;
    GTotAmt: Decimal;
    PVal: Decimal;
    PFAmt: Decimal;
    TotAmt: Decimal;
    SGSTCaption: label 'SGST %  ';
    CGSTCaption: label 'CGST %  ';
    IGSTCaption: label 'IGST  %  ';
    statesrec: Record State;
    InsuranceAmt: Decimal;
    totamt1: Decimal;
    lineamtvar: Decimal;
    salespersonrec: Record "Salesperson/Purchaser";
    statesrec1: Record State;
    selltogst: Code[20];
    subtotalamt: Decimal;
    PageCaption: label 'Page ';
    saleshipmentrec: Record "Sales Shipment Header";
    ordno: Code[200];
    selltoname: Text[50];
    selltoaddress: Text[50];
    selltoaddress2: Text[50];
    selltocity: Text[20];
    selltopostcode: Code[10];
    selltostate: Text[20];
    selltogst1: Code[20];
    shippingrec: Record "Ship-to Address";
    selltophone: Code[20];
    selltogstregno: Code[20];
    totalqty: Decimal;
    purchcreditmemorec: Record "Purch. Cr. Memo Hdr.";
    Rec_PurchCmntLine: Record "Purch. Comment Line";
    Var_Comments: array[7]of Text[1024];
    looper: Integer;
    dftgyh: Integer;
    Customer: Record Customer;
    SalesCrMemoLine: Record "Sales Cr.Memo Line";
    STC: Code[10];
    SalesCrMemoHdr: Record "Sales Cr.Memo Header";
    P_code: Record "Post Code";
    statecode: Code[10];
    statename: Text[50];
    statecodetds: Code[10];
    state1: Record State;
    TCSAmt: Decimal;
}
