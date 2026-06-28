// page 50012 "ICICI CIB Key Import"
// {
//     Caption = 'Import Client Private Key - ICICI CIB';
//     PageType = NavigatePage;
//     UsageCategory = Administration;
//     ApplicationArea = All;

//     layout
//     {
//         area(Content)
//         {
//             group(Info)
//             {
//                 Caption = 'Security Notice';
//                 InstructionalText =
//                     'Paste your Client Private Key (Base64 encoded .p12 file) below. ' +
//                     'It will be stored in BC Isolated Storage (encrypted at rest, NOT in any table). ' +
//                     'This key is sent to your Azure Function only during decryption.';
//             }
//             group(KeyGroup)
//             {
//                 Caption = 'Private Key';
//                 field(PrivKeyField; PrivKeyInput)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Client Private Key (Base64)';
//                     MultiLine = true;
//                     ExtendedDatatype = Masked;
//                     ToolTip = 'Base64 encoded content of your .p12 client private key file.';
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(SaveKey)
//             {
//                 Caption = 'Save Key Securely';
//                 ApplicationArea = All;
//                 Image = Save;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     Mgt: Codeunit "ICICI CIB Reg. Mgt.";
//                 begin
//                     if PrivKeyInput = '' then
//                         Error('Please paste the private key before saving.');
//                     Mgt.SetClientPrivateKey(PrivKeyInput);
//                     Clear(PrivKeyInput);
//                     Message('Client Private Key saved securely in Isolated Storage.');
//                 end;
//             }
//             action(ClearKey)
//             {
//                 Caption = 'Clear Stored Key';
//                 ApplicationArea = All;
//                 Image = Delete;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     Mgt: Codeunit "ICICI CIB Reg. Mgt.";
//                 begin
//                     if Confirm('Are you sure you want to delete the stored private key?') then
//                         Mgt.ClearClientPrivateKey();
//                 end;
//             }
//         }
//     }

//     var
//         PrivKeyInput: Text;
// }