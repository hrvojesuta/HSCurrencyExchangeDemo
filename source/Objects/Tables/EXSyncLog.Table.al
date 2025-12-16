namespace EX;

table 70301 "EX Sync Log"
{
    Caption = 'Sync Log';
    DataClassification = CustomerContent;
    AllowInCustomizations = AsReadWrite;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Date Time"; DateTime)
        {
            Caption = 'Date Time';
        }
        field(3; Status; Enum "EX Sync Log Status")
        {
            Caption = 'Status';
        }
        field(4; "Message"; Text[500])
        {
            Caption = 'Message';
        }
        field(5; "Rates Updated"; Integer)
        {
            Caption = 'Rates Updated';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
