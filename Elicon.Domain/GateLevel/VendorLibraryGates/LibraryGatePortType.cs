namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public enum LibraryGatePortType
    {
        UnDefined = 0,
        Input = 1,
        Clock = 2,
        Set = 3,
        Reset = 4,
        Enable = 5,
        Select = 6,
        Output = 7,
        Supply0 = 8,
        Supply1 = 9,
        Inout = 10,
    }

    public static class LibraryGatePortTypeExtensions
    {
        public static bool IsInputPort(this LibraryGatePortType target)
        {
            return target == LibraryGatePortType.Input
                   || target == LibraryGatePortType.Clock
                   || target == LibraryGatePortType.Set
                   || target == LibraryGatePortType.Reset
                   || target == LibraryGatePortType.Enable
                   || target == LibraryGatePortType.Select;
        }

        public static bool IsOutputPort(this LibraryGatePortType target)
        {
            return target == LibraryGatePortType.Output
                   || target == LibraryGatePortType.Supply0
                   || target == LibraryGatePortType.Supply1;
        }
    }
}