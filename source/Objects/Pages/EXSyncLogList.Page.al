namespace EX;

page 70301 "EX Sync Log List"
{
    ApplicationArea = All;
    Caption = 'Sync Log List';
    PageType = List;
    SourceTable = "EX Sync Log";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Date Time"; Rec."Date Time")
                {
                    ToolTip = 'Specifies the value of the Date Time field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Message"; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.', Comment = '%';
                }
                field("Rates Updated"; Rec."Rates Updated")
                {
                    ToolTip = 'Specifies the value of the Rates Updated field.', Comment = '%';
                }
            }
        }
    }
}
