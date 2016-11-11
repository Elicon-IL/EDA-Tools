using Elicon.Domain.GateLevel.VendorLibraryGates;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.VendorLibraryGates
{
    [TestFixture]
    public class LibraryGateTypeExtensionsTest
    {

        [TestCase(LibraryGateType.Cvdd)]
        [TestCase(LibraryGateType.Cvss)]
        [TestCase(LibraryGateType.PullDown)]
        [TestCase(LibraryGateType.PullUp)]
        [TestCase(LibraryGateType.BusRepeater)]
        [TestCase(LibraryGateType.PowerOnReset)]
        public void LibraryGateType_IsOutputOnlyGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsOutputOnlyGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.ClockBuffer)]
        [TestCase(LibraryGateType.BufferDelay)]
        public void LibraryGateType_IsSpecialBufferGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsSpecialBufferGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.Buffer)]
        [TestCase(LibraryGateType.Inverter)]
        [TestCase(LibraryGateType.And)]
        [TestCase(LibraryGateType.AndOrInv)]
        [TestCase(LibraryGateType.Nand)]
        [TestCase(LibraryGateType.Nor)]
        [TestCase(LibraryGateType.OrAndInv)]
        [TestCase(LibraryGateType.Or)]
        [TestCase(LibraryGateType.Xnor)]
        [TestCase(LibraryGateType.Xor)]
        [TestCase(LibraryGateType.Multiplexer)]
        public void LibraryGateType_IsCombinatorialGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsCombinatorialGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.SyncNeg)]
        [TestCase(LibraryGateType.SyncPos)]
        [TestCase(LibraryGateType.SyncScanNeg)]
        [TestCase(LibraryGateType.SyncScanPos)]
        [TestCase(LibraryGateType.SyncLatchHi)]
        [TestCase(LibraryGateType.SyncLatchLow)]
        [TestCase(LibraryGateType.SyncScanGatedPos)]
        public void LibraryGateType_IsStateStorageGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsStateStorageGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.TsBufLow)]
        [TestCase(LibraryGateType.TsBufHigh)]
        public void LibraryGateType_Is3StateBufferGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.Is3StateBufferGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.IoInput)]
        [TestCase(LibraryGateType.IoBidir)]
        [TestCase(LibraryGateType.IoOutput)]
        [TestCase(LibraryGateType.IoOutTs)]
        public void LibraryGateType_IsIoGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsIoGate();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.IoDiffInput)]
        [TestCase(LibraryGateType.IoDiffOutput)]
        [TestCase(LibraryGateType.IoOutTsOd)]
        [TestCase(LibraryGateType.IoPad)]
        [TestCase(LibraryGateType.IoInputNand)]
        [TestCase(LibraryGateType.IoOutTsHl)]
        [TestCase(LibraryGateType.IoBidirHlNand)]
        [TestCase(LibraryGateType.IoOutTsDiff)]
        public void LibraryGateType_IsSpecialIoGateGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsSpecialIoGateGate();
            Assert.That(result, Is.True);
        }

    }
}
