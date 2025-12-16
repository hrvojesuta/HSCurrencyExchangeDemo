namespace EX;

codeunit 70301 "EX Sync Job"
{
    trigger OnRun()
    var
        SyncMgt: Codeunit "EX Sync Management";
    begin
        SyncMgt.RunFxSync(true);
    end;
}
