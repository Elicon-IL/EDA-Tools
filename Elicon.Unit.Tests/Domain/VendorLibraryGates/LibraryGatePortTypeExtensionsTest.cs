using Elicon.Domain.GateLevel.VendorLibraryGates;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.VendorLibraryGates
{
    [TestFixture]
    public class LibraryGatePortTypeExtensionsTest
    {
        [TestCase(LibraryGatePortType.Input)]
        [TestCase(LibraryGatePortType.Clock)]
        [TestCase(LibraryGatePortType.Set)]
        [TestCase(LibraryGatePortType.Reset)]
        [TestCase(LibraryGatePortType.Enable)]
        [TestCase(LibraryGatePortType.Select)]
        public void IsInputPort_LibraryGatePortTypeIsInput_ReturnTrue(LibraryGatePortType type)
        {
            var result = type.IsInputPort();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGatePortType.Output)]
        [TestCase(LibraryGatePortType.Supply0)]
        public void IsInputPort_LibraryGatePortTypeIsNotInput_ReturnFalse(LibraryGatePortType type)
        {
            var result = type.IsInputPort();

            Assert.That(result, Is.False);
        }

        [TestCase(LibraryGatePortType.Output)]
        [TestCase(LibraryGatePortType.Supply0)]
        [TestCase(LibraryGatePortType.Supply1)]
        public void IsOutputPort_LibraryGatePortTypeIsOutput_ReturnTrue(LibraryGatePortType type)
        {
            var result = type.IsOutputPort();

            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGatePortType.Enable)]
        [TestCase(LibraryGatePortType.Select)]
        public void IsOutputPort_LibraryGatePortTypeIsNotOutput_ReturnFalse(LibraryGatePortType type)
        {
            var result = type.IsOutputPort();

            Assert.That(result, Is.False);
        }
    }
}
