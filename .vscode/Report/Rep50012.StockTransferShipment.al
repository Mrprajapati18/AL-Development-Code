report 50012 "Stock Tranf Shipment Challan"
{
    RDLCLayout = 'Layouts\StockTransferDC_Shipment.rdl';
    DefaultLayout = RDLC;
    Caption = 'Delivery Challan';
    ApplicationArea = all;
    UsageCategory = Documents;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Shipment Header")
        {
            column(PBAmount; PBAmount)
            {
            }
            column(No_; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Buyer_s_Order_No_; '')
            {
            }
            column(Excise_Pass_No_; '')
            {
            }
            column(Issued_By; '')
            {
            }
            column(Import_Permit_No_; '')
            {
            }
            column(IssuedBy; '')
            {
            }
            column(LR_RR_No_; "LR/RR No.")
            {
            }
            column(LR_RR_Date; "LR/RR Date")
            {
            }
            column(Transpoter_Name; '')
            {
            }
            column(Vehicle_No_; "Vehicle No.")
            {
            }
            column(CompInfoNAme;'')
            {
            }
            column(CompInfo; CompInfo.Picture)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(LOCATION_NAME; LOCATION_NAME)
            {
            }
            column(LOcation_GST; LOCTION_REC."GST Registration No.")
            {
            }
            column(Loction_State_Code; LOCTION_REC."State Code")
            {
            }
            column(LOCATION_ADDRESS; LOCATION_ADDRESS)
            {
            }
            column(LOCATION_NAME_2; LOCTION_REC.Name)
            {
            }
            column(LOCATION_ADDRESS_2; LOCTION_REC."Address 2")
            {
            }
            column(LOCATIONADDRES; LOCTION_REC.Address)
            {
            }
            column(LOCATIONName; LOCTION_REC.Name)
            {
            }
            column(loc_recName; loc_rec.Name)
            {
            }
            column(loc_recAddress; loc_rec.Address)
            {
            }
            column(loc_recAddress2; loc_rec."Address 2")
            {
            }
            column(loc_reccity; loc_rec.City)
            {
            }
            column(loc_recpostcode; loc_rec."Post Code")
            {
            }
            column(Location_TIN; Location_TIN)
            {
            }
            column(LOCATION_CITY; LOCATION_CITY)
            {
            }
            column(LOcation_Phone; LOcation_Phone)
            {
            }
            dataitem("Transfer Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemLinkReference = "Transfer Header";

                column(Quantity; Quantity)
                {
                }
                column(HSN_SAC_Code; "HSN/SAC Code")
                {
                }
                column(Liters; Liters)
                {
                }
                column(Item_No_; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Transfer_Price; "Unit Price")
                {
                }
                trigger OnPreDataItem();
                begin
                //  SNo := 0;
                end;
                trigger OnAfterGetRecord();
                begin
                    // CUSTOMER_REC.Reset();
                    // CUSTOMER_REC.SetRange("No.",no);
                    LOCTION_REC.Reset();
                    LOCTION_REC.SetRange(Code, "Transfer-from Code");
                    if LOCTION_REC.FindFirst()then begin
                        LOCATION_NAME:=LOCTION_REC.Name;
                        LOCATION_ADDRESS:=LOCTION_REC.Address + ' ' + LOCTION_REC."Address 2";
                        LOcation_GST:=LOCTION_REC."GST Registration No.";
                        Loction_State_Code:=LOCTION_REC."State Code";
                        Location_TIN:=LOCTION_REC."T.A.N. No.";
                        LOCATION_CITY:=LOCTION_REC.City + ' ' + LOCTION_REC."Post Code";
                        LOcation_Phone:=LOCTION_REC."Phone No.";
                    //Location_State_Name := LOCTION_REC.state
                    end;
                    loc_rec.Reset(); //my
                    loc_rec.SetRange(Code, "Transfer-to Code");
                    if loc_rec.FindFirst()then begin
                        LOCAT_name:=LOCTION_REC.Name;
                        LOCATION_Add:=LOCTION_REC.Address;
                        LOcation_GST:=LOCTION_REC."GST Registration No.";
                        Loction_State_Code:=LOCTION_REC."State Code";
                    //Location_State_Name := LOCTION_REC.state
                    end;
                   
                    Clear(Item_rec);
                    if Item_rec.Get("Transfer Line"."Item No.")then begin
                        SaveCapa:=0;
                        // if Item_rec.capacity <> '' then Evaluate(SaveCapa, Item_rec.Capacity);
                        if SaveCapa = 330 then Liters:=(Quantity * 24 * 330) / 1000
                        else if SaveCapa = 350 then Liters:=(Quantity * 24 * 350) / 1000
                            else if SaveCapa = 500 then Liters:=(Quantity * 24 * 500) / 1000
                                else if SaveCapa = 650 then Liters:=(Quantity * 12 * 650) / 1000 end;
               
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                TLS_rec: Record "Transfer Shipment Line";
            begin
                TLS_rec.Reset();
                TLS_rec.SetRange("Document No.", "Transfer Header"."No.");
                TLS_rec.CalcSums(Amount);
                // PBAmount:=AmountInWordINR.GetAmountInWords(TLS_rec.Amount);
            end;
        }
    }
    requestpage
    {
        SaveValues = false;

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
    trigger OnInitReport()
    begin
    end;
    trigger OnPostReport()
    begin
    end;
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        //statesrec.GET(CompInfo.State);
        generalledgersetuprec.Get;
    end;
    var PBAmount: Text;
    AmtTxt: Text;
    // AmountInWordINR: Codeunit "Amount to Words INR";
    LOcation_Phone: Text;
    LOCATION_CITY: Text;
    Location_TIN: Text;
    LOCAT_name: Text;
    LOCATION_Add: Text;
    loc_rec: Record Location;
    Companies: Record Company;
    Loction_State_Code: Text;
    LOcation_GST: Text;
    SaveCapa: Decimal;
    Liters: Decimal;
    Item_rec: Record item;
    LOCATION_ADDRESS: Text;
    LOCATION_NAME: Text;
    LocationRec_Transfertocode: Record Location;
    LOCTION_REC: Record Location;
    CUSTOMER_REC: Record Customer;
    CompInfo: Record "Company Information";
    // FormatAddr: Codeunit "Format Address";
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
    //NumToText: Report Check;
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
    TaxGrp: Text[2];
    Var_TaxType: Text;
    GrandTotal: Decimal;
    NetTotal: Decimal;
    RoundOff: Decimal;
    BillAmt: Decimal;
    TotalDiscount: Decimal;
    AmountInWords: array[2]of Text[500];
    PstSalesInvLine: Record "Sales Invoice Line";
    AllowedUser: Boolean;
    //  ExcisePostingSetup: Record "Excise Posting Setup";//YS Report table is removed in bc
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
    //PstedStr: Record "Posted Structure Order Details";//YS Report table is removed in bc
    FreAmt: Decimal;
    GTotAmt: Decimal;
    PVal: Decimal;
    PFAmt: Decimal;
    // PstedStrOrdLineDet: Record "Posted Str Order Line Details";//YS Report table is removed in bc
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
    customerrec: Record Customer;
    selltogst: Code[20];
    subtotalamt: Decimal;
    PageCaption: label 'Page ';
    saleshipmentrec: Record "Sales Shipment Header";
    ordno: Code[200];
    selltoname: Text[100];
    selltoaddress: Text[100];
    selltoaddress2: Text[100];
    selltocity: Text[20];
    selltopostcode: Code[10];
    selltostate: Text[20];
    selltogst1: Code[20];
    shippingrec: Record "Ship-to Address";
    selltophone: Code[30];
    selltogstregno: Code[20];
    totalqty: Decimal;
    itemrec: Record Item;
    generalledgersetuprec: Record "General Ledger Setup";
    compstatedesc: Text[20];
    compstatecode: Code[10];
    transferfromstatecode: Code[10];
    transfertostatecode: Code[10];
    transferstatedesc: Text[20];
    transfertostatedesc: Text[20];
    transferfromgst: Code[20];
    transfertogst: Code[20];
    transferfromphone: Code[30];
    transfertophone: Text[30];
    Rec_TransferCmntLine: Record "Inventory Comment Line";
    Var_Comments: array[5]of Text;
    i: Integer;
    Customer: Record Customer;
    Vendor: Record Vendor;
    transfertoname: Text[100];
    transfertoaddress: Text[100];
    transfertoaddress2: Text[100];
    transfertoaddress3: Text[100];
    transfertopostcode: Code[10];
    transfertocity: Text[20];
    lotno: Code[50];
    ItemLedgerEntry: Record "Item Ledger Entry";
    // EInvoiceHeader_Rec: Record "EInvoice Header";
    SalesPrice_rec: Record "Sales Price";
    UnitPrice: Decimal;
    Disp_Name: Text;
    Disp_Pan: Code[20];
    Disp_GstRegNo: Code[20];
    Disp_Address: Text;
    Disp_Address2: Text;
    Disp_City: Text;
    Disp_PostCode: Code[20];
    Disp_State: Code[20];
    Disp_Country: Text;
    //amtinword
    Notext1: array[700]of Text[800];
    Notext2: array[700]of Text[800];
    Text16526: Label 'ZERO';
    Text16527: Label 'HUNDRED';
    Text16528: Label 'AND';
    Text16529: Label '%1 results in a written number that is too long.';
    Text16532: Label 'ONE';
    Text16533: Label 'TWO';
    Text16534: Label 'THREE';
    Text16535: Label 'FOUR';
    Text16536: Label 'FIVE';
    Text16537: Label 'SIX';
    Text16538: Label 'SEVEN';
    Text16539: Label 'EIGHT';
    Text16540: Label 'NINE';
    Text16541: Label 'TEN';
    Text16542: Label 'ELEVEN';
    Text16543: Label 'TWELVE';
    Text16544: Label 'THIRTEEN';
    Text16545: Label 'FOURTEEN';
    Text16546: Label 'FIFTEEN';
    Text16547: Label 'SIXTEEN';
    Text16548: Label 'SEVENTEEN';
    Text16549: Label 'EIGHTEEN';
    Text16550: Label 'NINETEEN';
    Text16551: Label 'TWENTY';
    Text16552: Label 'THIRTY';
    Text16553: Label 'FORTY';
    Text16554: Label 'FIFTY';
    Text16555: Label 'SIXTY';
    Text16556: Label 'SEVENTY';
    Text16557: Label 'EIGHTY';
    Text16558: Label 'NINETY';
    Text16559: Label 'THOUSAND';
    Text16560: Label 'MILLION';
    Text16561: Label 'BILLION';
    Text16562: Label 'LAKH';
    Text16563: Label 'CRORE';
    OnesText: array[200]of Text[300];
    TensText: array[700]of Text[300];
    ExponentText: array[500]of Text[300];
    AmountInWordsCaptionLbl: Label 'Amount (in words):';
    "Expiry Date": Text;
    procedure FormatNoText(var NoText: array[200]of Text[800]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex:=1;
        NoText[1]:='';
        IF No < 1 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE
        BEGIN
            FOR Exponent:=4 DOWNTO 1 DO BEGIN
                PrintExponent:=FALSE;
                IF No > 99999 THEN BEGIN
                    Ones:=No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds:=0;
                END
                ELSE
                BEGIN
                    Ones:=No DIV POWER(1000, Exponent - 1);
                    Hundreds:=Ones DIV 100;
                END;
                Tens:=(Ones MOD 100) DIV 10;
                Ones:=Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END
                ELSE IF(Tens * 10 + Ones) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1)THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN No:=No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No:=No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;
        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        END
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');
        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);
        TensDec:=((No * 100) MOD 100) DIV 10;
        OnesDec:=(No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END
        ELSE IF(TensDec * 10 + OnesDec) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF(CurrencyCode <> '')THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '' + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=TRUE;
        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1])DO BEGIN
            NoTextIndex:=NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText)THEN ERROR(Text16529, AddText);
        END;
        NoText[NoTextIndex]:=DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=Text16532;
        OnesText[2]:=Text16533;
        OnesText[3]:=Text16534;
        OnesText[4]:=Text16535;
        OnesText[5]:=Text16536;
        OnesText[6]:=Text16537;
        OnesText[7]:=Text16538;
        OnesText[8]:=Text16539;
        OnesText[9]:=Text16540;
        OnesText[10]:=Text16541;
        OnesText[11]:=Text16542;
        OnesText[12]:=Text16543;
        OnesText[13]:=Text16544;
        OnesText[14]:=Text16545;
        OnesText[15]:=Text16546;
        OnesText[16]:=Text16547;
        OnesText[17]:=Text16548;
        OnesText[18]:=Text16549;
        OnesText[19]:=Text16550;
        TensText[1]:='';
        TensText[2]:=Text16551;
        TensText[3]:=Text16552;
        TensText[4]:=Text16553;
        TensText[5]:=Text16554;
        TensText[6]:=Text16555;
        TensText[7]:=Text16556;
        TensText[8]:=Text16557;
        TensText[9]:=Text16558;
        ExponentText[1]:='';
        ExponentText[2]:=Text16559;
        ExponentText[3]:=Text16562;
        ExponentText[4]:=Text16563;
    end;
}
