namespace Elicon.Domain.GateLevel.Library
{
    public enum LibraryGatePortType
    {
        UnDefined = 0,
        Input = 1, Clock = 4, Set = 5, Reset = 6, Enable = 7, Select = 10,
        Output = 2, Supply0 = 8, Supply1 = 9,
        Inout = 3,
    }
}