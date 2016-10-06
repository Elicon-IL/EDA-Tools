using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Parse;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Parse
{
    [TestFixture]
    public class PortsDeclarationStatementParserTests
    {
        private PortsDeclarationStatementParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PortsDeclarationStatementParser();
        }

        [Test]
        public void GetPortType_InputType_ReturnsInput()
        {
            const string statement = "input w1, w2, w3, w4, w5, w6, w7, w8, w9 , w10 , w11 , clk ;";

            var result = _target.GetPortType(statement);

            Assert.That(result, Is.EqualTo(PortType.Input));
        }

        [Test]
        public void GetPortType_OutputType_ReturnsOutput()
        {
            const string statement = "output w1, w2, w3, w4, w5, w6, w7, w8, w9 , w10 , w11 , clk ;";

            var result = _target.GetPortType(statement);

            Assert.That(result, Is.EqualTo(PortType.Output));
        }

        [Test]
        public void GetPortType_InoutType_ReturnsInout()
        {
            const string statement = "inout w1, w2, w3, w4, w5, w6, w7, w8, w9 , w10 , w11 , clk ;";

            var result = _target.GetPortType(statement);

            Assert.That(result, Is.EqualTo(PortType.Inout));
        }

        [Test]
        public void GetPorts_OnePort_ReturnsPort()
        {
            const string statement = "input w1;";

            var result = _target.GetPorts(statement);

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0].PortName, Is.EqualTo("w1"));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
        }

        [Test]
        public void GetPorts_TwoPortsNoEscape_ReturnsTwoPort()
        {
            const string statement = "inout w1, w2 ;";

            var result = _target.GetPorts(statement);

            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result[0].PortName, Is.EqualTo("w1"));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
            Assert.That(result[1].PortName, Is.EqualTo("w2"));
            Assert.That(result[1].PortType, Is.EqualTo(PortType.Inout));
        }

        [Test]
        public void GetPorts_TwoPortsWithEscape_ReturnsTwoPort()
        {
            const string statement = "inout \\w1,(; , w2 ;";

            var result = _target.GetPorts(statement);

            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result[0].PortName, Is.EqualTo("\\w1,(;"));
            Assert.That(result[0].PortType, Is.EqualTo(PortType.Inout));
            Assert.That(result[1].PortName, Is.EqualTo("w2"));
            Assert.That(result[1].PortType, Is.EqualTo(PortType.Inout));
        }
    }
}
