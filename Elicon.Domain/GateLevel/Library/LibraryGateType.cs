namespace Elicon.Domain.GateLevel.Library
{
    public enum LibraryGateType
    {
        Uknown = 0,

        // Output only gates
        Cvdd = 50,      // Supply1
        Cvss = 51,      // Supply0
        PullUp = 52,
        PullDown = 53,
        BusRepeater = 54,
        PowerOnReset = 55,

        // Special buffers.
        ClockBuffer = 56,
        BufferDelay = 57,

        // Combinatorial gates.
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

        // State storage gates.
        SyncNeg = 200,
        SyncPos = 201,
        SyncScanNeg = 202,
        SyncScanPos = 203,
        SyncLatchHi = 204,
        SyncLatchLow = 205,
        SyncScanGatedPos = 206,

        // Oscilator, Clock generator.
        Osc = 250,
        ClockGen = 251,

        // 3-state buffers.
        TsBufLow = 300,
        TsBufHigh = 301,

        // IO Gates.
        IoInput = 350,
        IoBidir = 351,
        IoOutput = 352,
        IoOutTs = 353,

        // Special IO Types.
        IoDiffInput = 300,
        IoDiffOutput = 301,
        IoOutTsOd = 302,
        IoPad = 303,
        IoInputNand = 304,
        IoOutTsHl = 305,
        IoBidirHlNand = 306,
        IoOutTsDiff = 307

    };

}