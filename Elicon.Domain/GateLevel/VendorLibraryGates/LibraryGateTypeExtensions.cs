namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
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