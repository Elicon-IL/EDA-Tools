using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Parse;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Parse
{
    [TestFixture]
    public class PortsParserTests
    {
        private PortsParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PortsParser();
        }

        [Test]
        public void GetPorts_EmptyInput_ReturnsEmpty()
        {
            var ports = "";

            var result = _target.GetPorts(ports).ToList();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void GetPorts_OnePortNoEscape_ReturnsPort()
        {
            var ports = "qqq";

            var result = _target.GetPorts(ports).ToList();

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0].PortName, Is.EqualTo(ports));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
        }

        [Test]
        public void GetPorts_TwoPortsNoEscape_ReturnsPorts()
        {
            var ports = "qqq, www";

            var result = _target.GetPorts(ports).ToList();

            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result[0].PortName, Is.EqualTo("qqq"));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
            Assert.That(result[1].PortName, Is.EqualTo("www"));
            Assert.That(result[1].PortType, Is.EqualTo(PortType.Inout));
        }

        [Test]
        public void GetPorts_TwoPortsWithEscape_ReturnsPorts()
        {
            var ports = "\\qqq, ,  \\w,ww";

            var result = _target.GetPorts(ports).ToList();

            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result[0].PortName, Is.EqualTo("\\qqq,"));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
            Assert.That(result[1].PortName, Is.EqualTo("\\w,ww"));
            Assert.That(result[1].PortType, Is.EqualTo(PortType.Inout));
        }
    }
}
