using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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
        public void LibraryGatePortType_IsInputPort_ReturnTrue(LibraryGatePortType type)
        {
            var result = type.IsInputPort();
            Assert.That(result, Is.True);
        }

        [TestCase(LibraryGatePortType.Output)]
        [TestCase(LibraryGatePortType.Supply0)]
        [TestCase(LibraryGatePortType.Supply1)]
        public void LibraryGatePortType_IsOutputPort_ReturnTrue(LibraryGatePortType type)
        {
            var result = type.IsOutputPort();
            Assert.That(result, Is.True);
        }

    }
}
