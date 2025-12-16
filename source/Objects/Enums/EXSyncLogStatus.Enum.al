namespace EX;

enum 70300 "EX Sync Log Status"
{
    Extensible = true;

    value(0; Success)
    {
        Caption = 'Success';
    }
    value(1; Error)
    {
        Caption = 'Error';
    }
}
