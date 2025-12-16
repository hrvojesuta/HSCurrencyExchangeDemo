namespace PermissionSet;

using EX;

permissionset 70300 EXPermission
{
    Assignable = true;
    Permissions = tabledata "EX Sync Setup" = RIMD,
        table "EX Sync Setup" = X,
        tabledata "EX Sync Log" = RIMD,
        table "EX Sync Log" = X,
        codeunit "EX Sync Job" = X,
        codeunit "EX Sync Management" = X,
        page "EX Sync Log List" = X,
        page "EX Sync Setup Card" = X;
}