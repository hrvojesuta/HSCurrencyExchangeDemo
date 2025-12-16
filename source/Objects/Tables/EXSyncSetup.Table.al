namespace EX;

table 70300 "EX Sync Setup"
{
    Caption = 'Sync Setup';
    DataClassification = CustomerContent;
    AllowInCustomizations = AsReadWrite;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "API URL"; Text[250])
        {
            Caption = 'API URL';
        }
        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
        }
        field(4; "Base Currency"; Code[10])
        {
            Caption = 'Base Currency';
        }
        field(5; "Currencies To Sync"; Text[250])
        {
            Caption = 'Currencies To Sync';
        }
        field(6; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    internal procedure InitSetup()
    begin
        Rec."Primary Key" := 'SETUP';
        Rec."API URL" := 'https://api.frankfurter.app/latest?from=%1&to=%2';
        Rec."Base Currency" := 'EUR';
        Rec."Currencies To Sync" := 'USD,GBP,JPY,DKK';
        Rec.Enabled := true;
        if not Rec.Insert() then
            Rec.Modify();
    end;
}
