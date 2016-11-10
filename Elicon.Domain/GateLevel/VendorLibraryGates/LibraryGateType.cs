namespace Elicon.Domain.GateLevel.VendorLibraryGates
{

    public enum LibraryGateType
    {
        Uknown = 0,
        Cvdd = 50,
        Cvss = 51,
        PullUp = 52,
        PullDown = 53,
        BusRepeater = 54,
        PowerOnReset = 55,
        ClockBuffer = 56,
        BufferDelay = 57,
        Buffer = 100,
        Inverter = 101,
        And = 102,
        AndOrInv = 103,
        Nand = 104,
        Nor = 105,
        OrAndInv = 106,
        Or = 107,
        Xnor = 108,
        Xor = 109,
        Multiplexer = 110,
        SyncNeg = 200,
        SyncPos = 201,
        SyncScanNeg = 202,
        SyncScanPos = 203,
        SyncLatchHi = 204,
        SyncLatchLow = 205,
        SyncScanGatedPos = 206,
        Osc = 250,
        ClockGen = 251,
        TsBufLow = 300,
        TsBufHigh = 301,
        IoInput = 350,
        IoBidir = 351,
        IoOutput = 352,
        IoOutTs = 353,
        IoDiffInput = 300,
        IoDiffOutput = 301,
        IoOutTsOd = 302,
        IoPad = 303,
        IoInputNand = 304,
        IoOutTsHl = 305,
        IoBidirHlNand = 306,
        IoOutTsDiff = 307
    }

    public static class LibraryGateTypeExtensions
    {
        public static bool IsOutputOnlyGate(this LibraryGateType target)
        {
            return target == LibraryGateType.Cvdd
                   || target == LibraryGateType.Cvss
                   || target == LibraryGateType.PullDown
                   || target == LibraryGateType.PullUp
                   || target == LibraryGateType.BusRepeater
                   || target == LibraryGateType.PowerOnReset;
        }

        public static bool IsSpecialBufferGate(this LibraryGateType target)
        {
            return target == LibraryGateType.ClockBuffer
                   || target == LibraryGateType.BufferDelay;
        }

        public static bool IsCombinatorialGate(this LibraryGateType target)
        {
            return target == LibraryGateType.Buffer
                   || target == LibraryGateType.Inverter
                   || target == LibraryGateType.And
                   || target == LibraryGateType.AndOrInv
                   || target == LibraryGateType.Nand
                   || target == LibraryGateType.Nor
                   || target == LibraryGateType.OrAndInv
                   || target == LibraryGateType.Or
                   || target == LibraryGateType.Xnor
                   || target == LibraryGateType.Xor
                   || target == LibraryGateType.Multiplexer;
        }

        public static bool IsStateStorageGate(this LibraryGateType target)
        {
            return target == LibraryGateType.SyncNeg
                   || target == LibraryGateType.SyncPos
                   || target == LibraryGateType.SyncScanNeg
                   || target == LibraryGateType.SyncScanPos
                   || target == LibraryGateType.SyncLatchHi
                   || target == LibraryGateType.SyncLatchLow
                   || target == LibraryGateType.SyncScanGatedPos;
        }

        public static bool Is3StateBufferGate(this LibraryGateType target)
        {
            return target == LibraryGateType.TsBufLow
                   || target == LibraryGateType.TsBufHigh;
        }

        public static bool IsIoGate(this LibraryGateType target)
        {
            return target == LibraryGateType.IoInput
                   || target == LibraryGateType.IoBidir
                   || target == LibraryGateType.IoOutput
                   || target == LibraryGateType.IoOutTs;
        }

        public static bool IsSpecialIoGateGate(this LibraryGateType target)
        {
            return target == LibraryGateType.IoDiffInput
                   || target == LibraryGateType.IoDiffOutput
                   || target == LibraryGateType.IoOutTsOd
                   || target == LibraryGateType.IoPad
                   || target == LibraryGateType.IoInputNand
                   || target == LibraryGateType.IoOutTsHl
                   || target == LibraryGateType.IoBidirHlNand
                   || target == LibraryGateType.IoOutTsDiff;
        }

    }

}