using Elicon.Domain.Netlist.Parse;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Parse
{
    [TestFixture]
    public class InstanceStatementParserTests
    {
        private InstanceStatementParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new InstanceStatementParser();
        }

        [Test]
        public void GetModuleName_InstanceStatement_ReturnsModuleName()
        {
            var statement = "no2 inst100408  ( .b(n36), .a(i0), .zn(o) );";

            var result = _target.GetModuleName(statement);

            Assert.That(result, Is.EqualTo("no2"));
        }

        [Test]
        [TestCase("no2 inst100408( .b(n36), .a(i0), .zn(o) );")]
        [TestCase("no2 inst100408  ( .b(n36), .a(i0), .zn(o) );")]
        public void GetInstanceName_InstanceStatement_ReturnsInstanceName(string statement)
        {
            var result = _target.GeInstanceName(statement);

            Assert.That(result, Is.EqualTo("inst100408"));
        }

        [Test]
        public void GetInstanceName_InstanceStatementWithEscapedName_ReturnsInstanceName()
        {
            var statement = "no2 \\inst1004(08  ( .b(n36), .a(i0), .zn(o) );";

            var result = _target.GeInstanceName(statement);

            Assert.That(result, Is.EqualTo("\\inst1004(08"));
        }

        [Test]
        public void GetNet_StatementWithNoConnections_ReturnsEmpty()
        {
            var statement = "cell1 inst1 ();";

            var result = _target.GetNet(statement);

            Assert.That(result, Is.Empty);
        }

        [Test]
        [TestCase("cell1 inst1 (.p1(w1));")]
        [TestCase("cell1 inst1 (. p1 ( w1 ) );")]
        public void GetNet_StatementWithOnePortWireNoEscapesNoBus_ReturnsOnePortWire(string statement)
        {
            var result = _target.GetNet(statement);

            Assert.That(result.Count, Is.EqualTo(1));
            Assert.That(result[0].Port, Is.EqualTo("p1"));
            Assert.That(result[0].Wire, Is.EqualTo("w1"));
        }

        [Test]
        [TestCase("cell1 inst1 (.p1(w1),.p2(w2));")]
        [TestCase("cell1 inst1 (. p1(w1)   ,   .  p2     (  w2 )   );")]
        public void GetNet_StatementWithTwoPortWireNoEscapesNoBus_ReturnsTwoPortWire(string statement)
        {
           var result = _target.GetNet(statement);

            Assert.That(result.Count, Is.EqualTo(2));
            Assert.That(result[0].Port, Is.EqualTo("p1"));
            Assert.That(result[0].Wire, Is.EqualTo("w1"));
            Assert.That(result[1].Port, Is.EqualTo("p2"));
            Assert.That(result[1].Wire, Is.EqualTo("w2"));
        }


        [Test]
        public void GetNet_StatementWithTwoPortWireAndEscapedNotation_ReturnsTwoPortWire()
        {
            var statement = @"cell2 inst2 ( . \p1(2) (\wire[8] ), .\port[2] (wire2));";

            var result = _target.GetNet(statement);

            Assert.That(result.Count, Is.EqualTo(2));
            Assert.That(result[0].Port, Is.EqualTo(@"\p1(2)"));
            Assert.That(result[0].Wire, Is.EqualTo(@"\wire[8]"));
            Assert.That(result[1].Port, Is.EqualTo(@"\port[2]"));
            Assert.That(result[1].Wire, Is.EqualTo(@"wire2"));
        }

        [Test]
        public void GetNet_StatementWithTwoPortWireAndBusNotation_ReturnsTwoPortWire()
        {
            var statement = @"cell3 inst3 ( . p1 (\wire [8] ), .\port[2] ( wire[2]));";

            var result = _target.GetNet(statement);

            Assert.That(result.Count, Is.EqualTo(2));
            Assert.That(result[0].Port, Is.EqualTo("p1"));
            Assert.That(result[0].Wire, Is.EqualTo(@"\wire [8]"));
            Assert.That(result[1].Port, Is.EqualTo(@"\port[2]"));
            Assert.That(result[1].Wire, Is.EqualTo("wire[2]"));
        }

        [Test]
        public void GetNet_StatementWithTwoPortWireAndOpenedWireBusNotation_ReturnsTwoPortWire()
        {
            var statement = @"cell4 inst4 ( . p1 ({\wire[8], , w2} ), .\port[2] ( wire2));";

            var result = _target.GetNet(statement);

            Assert.That(result.Count, Is.EqualTo(2));
            Assert.That(result[0].Port, Is.EqualTo("p1"));
            Assert.That(result[0].Wire, Is.EqualTo(@"{\wire[8], , w2}"));
            Assert.That(result[1].Port, Is.EqualTo(@"\port[2]"));
            Assert.That(result[1].Wire, Is.EqualTo("wire2"));
        }
    }
}
