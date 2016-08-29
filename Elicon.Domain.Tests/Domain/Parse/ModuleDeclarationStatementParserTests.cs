using Elicon.Domain.GateLevel.Parse;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Parse
{
    [TestFixture]
    public class ModuleDeclarationStatementParserTests
    {
        private ModuleDeclarationStatementParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new ModuleDeclarationStatementParser();
        }

        [Test]
        [TestCase("module x_lut4_0x5500( i0, i3, o );")]
        [TestCase("module x_lut4_0x5500 ( i0, i3, o );")]
        public void GetModuleName_ModuleDeclarationStatement_ReturnsModuleName(string statement)
        {
            var result = _target.GetModuleName(statement);

            Assert.That(result, Is.EqualTo("x_lut4_0x5500"));
        }

        [Test]
        public void GetModuleName_ModuleDeclarationWithEscapedName_ReturnsModuleeName()
        {
            var statement = "module \\x_lut4_0x5500(08  ( .b(n36), .a(i0), .zn(o) );";

            var result = _target.GetModuleName(statement);

            Assert.That(result, Is.EqualTo("\\x_lut4_0x5500(08"));
        }

        [Test]
        public void GetPorts_NoPorts_ReturnsEmpty()
        {
            var statement = "module \\x_lut4_0x5500(08  ();";

            var result = _target.GetPorts(statement);

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void GetPorts_NoneEscapedPorts_ReturnsPorts()
        {
            var statement = "module \\x_lut4_0x5500(08  ( b, a, zn ) ;";

            var result = _target.GetPorts(statement);

            Assert.That(result, Has.Count.EqualTo(3));
            Assert.That(result[0].PortName, Is.EqualTo("b"));
            Assert.That(result[1].PortName, Is.EqualTo("a"));
            Assert.That(result[2].PortName, Is.EqualTo("zn"));
       }

        [Test]
        public void GetPorts_EscapedPorts_ReturnsPorts()
        {
            var statement = "module \\x_lut4_0x5500(08  ( \\(b, , a, \\zn) ) ;";

            var result = _target.GetPorts(statement);

            Assert.That(result, Has.Count.EqualTo(3));
            Assert.That(result[0].PortName, Is.EqualTo("\\(b,"));
            Assert.That(result[1].PortName, Is.EqualTo("a"));
            Assert.That(result[2].PortName, Is.EqualTo("\\zn)"));
        }
    }
}
