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
    }
}
