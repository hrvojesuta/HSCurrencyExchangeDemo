namespace EX;

page 70300 "EX Sync Setup Card"
{
    ApplicationArea = All;
    Caption = 'Sync Setup Card';
    PageType = Card;
    SourceTable = "EX Sync Setup";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("API URL"; Rec."API URL")
                {
                    ToolTip = 'Specifies the value of the API URL field.', Comment = '%';
                }
                field("API Key"; Rec."API Key")
                {
                    ToolTip = 'Specifies the value of the API Key field.', Comment = '%';
                }
                field("Base Currency"; Rec."Base Currency")
                {
                    ToolTip = 'Specifies the value of the Base Currency field.', Comment = '%';
                }
                field("Currencies To Sync"; Rec."Currencies To Sync")
                {
                    ToolTip = 'Specifies the value of the Currencies To Sync field.', Comment = '%';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies the value of the Enabled field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("EX Init Setup")
            {
                ApplicationArea = All;
                Caption = 'Init Setup', Locked = true;
                ToolTip = 'Init Setup', Locked = true;
                Image = Insert;

                trigger OnAction()
                begin
                    Rec.InitSetup();
                end;
            }



            action("EX Sync Now")
            {
                Caption = 'Sync Now';
                Image = Refresh;
                ToolTip = 'Executes the Sync Now action.';

                trigger OnAction()
                var
                    EXSyncManagement: Codeunit "EX Sync Management";
                begin
                    EXSyncManagement.RunFxSync(false);
                end;
            }
        }
    }
    // trigger OnOpenPage()
    // var
    //     EXSyncSetup: Record "EX Sync Setup";
    // begin
    //     EXSyncSetup.Reset();
    //     if not EXSyncSetup.FindFirst() then begin
    //         EXSyncSetup.Init();
    //         EXSyncSetup."Primary Key" := 'SETUP';
    //         EXSyncSetup."API URL" := 'https://api.frankfurter.app/latest?from=%1&to=%2';
    //         EXSyncSetup."Base Currency" := 'EUR';
    //         EXSyncSetup."Currencies To Sync" := 'USD,GBP,JPY,DKK';
    //         EXSyncSetup.Enabled := true;
    //         EXSyncSetup.Insert();
    //     end;
    //     // if not Rec.Get('SETUP') then
    //     //     if not Rec.Insert() then
    //     //         Rec.Modify();


    // end;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
