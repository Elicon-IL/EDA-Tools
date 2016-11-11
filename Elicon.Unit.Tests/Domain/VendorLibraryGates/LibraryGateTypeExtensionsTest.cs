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
        public void IsOutputOnlyGate_LibraryGateTypeIsOutputOnlyGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsOutputOnlyGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.SyncScanPos)]
        [TestCase(LibraryGateType.Xor)]
        public void IsOutputOnlyGate_LibraryGateTypeIsNotOutputOnlyGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsOutputOnlyGate();

            Assert.That(result, Is.False);
        }

        [TestCase(LibraryGateType.ClockBuffer)]
        [TestCase(LibraryGateType.BufferDelay)]
        public void IsSpecialBufferGate_LibraryGateTypeIsSpecialBufferGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsSpecialBufferGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.SyncScanPos)]
        [TestCase(LibraryGateType.Inverter)]
        public void IsSpecialBufferGate_LibraryGateTypeIsNotSpecialBufferGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsSpecialBufferGate();

            Assert.That(result, Is.False);
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
        public void IsCombinatorialGate_LibraryGateTypeIsCombinatorialGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsCombinatorialGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.TsBufLow)]
        [TestCase(LibraryGateType.SyncScanPos)]
        public void IsCombinatorialGate_LibraryGateTypeIsNotCombinatorialGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsCombinatorialGate();

            Assert.That(result, Is.False);
        }
        
        [TestCase(LibraryGateType.SyncNeg)]
        [TestCase(LibraryGateType.SyncPos)]
        [TestCase(LibraryGateType.SyncScanNeg)]
        [TestCase(LibraryGateType.SyncScanPos)]
        [TestCase(LibraryGateType.SyncLatchHi)]
        [TestCase(LibraryGateType.SyncLatchLow)]
        [TestCase(LibraryGateType.SyncScanGatedPos)]
        public void IsStateStorageGate_LibraryGateTypeIsStateStorageGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsStateStorageGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.IoBidir)]
        [TestCase(LibraryGateType.IoOutput)]
        public void IsStateStorageGate_LibraryGateTypeIsNotStateStorageGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsStateStorageGate();

            Assert.That(result, Is.False);
        }

        [TestCase(LibraryGateType.TsBufLow)]
        [TestCase(LibraryGateType.TsBufHigh)]
        public void Is3StateBufferGate_LibraryGateTypeIs3StateBufferGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.Is3StateBufferGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.IoOutTsOd)]
        [TestCase(LibraryGateType.IoPad)]
        public void Is3StateBufferGate_LibraryGateTypeIsNot3StateBufferGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.Is3StateBufferGate();

            Assert.That(result, Is.False);
        }

        [TestCase(LibraryGateType.IoInput)]
        [TestCase(LibraryGateType.IoBidir)]
        [TestCase(LibraryGateType.IoOutput)]
        [TestCase(LibraryGateType.IoOutTs)]
        public void IsIoGate_LibraryGateTypeIsIoGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsIoGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.IoOutTsHl)]
        [TestCase(LibraryGateType.IoBidirHlNand)]
        public void IsIoGate_LibraryGateTypeIsNotIoGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsIoGate();

            Assert.That(result, Is.False);
        }

        [TestCase(LibraryGateType.IoDiffInput)]
        [TestCase(LibraryGateType.IoDiffOutput)]
        [TestCase(LibraryGateType.IoOutTsOd)]
        [TestCase(LibraryGateType.IoPad)]
        [TestCase(LibraryGateType.IoInputNand)]
        [TestCase(LibraryGateType.IoOutTsHl)]
        [TestCase(LibraryGateType.IoBidirHlNand)]
        [TestCase(LibraryGateType.IoOutTsDiff)]
        public void IsSpecialIoGateGate_LibraryGateTypeIsSpecialIoGateGate_ReturnTrue(LibraryGateType type)
        {
            var result = type.IsSpecialIoGateGate();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGateType.Nand)]
        [TestCase(LibraryGateType.Nor)]
        public void IsSpecialIoGateGate_LibraryGateTypeIsNotSpecialIoGateGate_ReturnFalse(LibraryGateType type)
        {
            var result = type.IsSpecialIoGateGate();

            Assert.That(result, Is.False);
        }
    }
}
