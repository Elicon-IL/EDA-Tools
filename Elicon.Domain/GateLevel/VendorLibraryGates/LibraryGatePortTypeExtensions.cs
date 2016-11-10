namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
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