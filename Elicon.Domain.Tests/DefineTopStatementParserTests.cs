using Elicon.Domain.Netlist.Parse;
using Elicon.Domain.Netlist.Read;
using NUnit.Framework;

namespace Elicon.Domain.Tests
{
    [TestFixture]
    public class DefineTopStatementParserTests
    {
        private DefineTopStatementParser _target;

        [SetUp]
        public void SetUp()
        {
            _target = new DefineTopStatementParser();
        }

        [Test]
        public void GetTopModuleName_DefineTopStatement_ReturnsTopModuleName()
        {
            var statement = "`define top newpro";

            var result = _target.GetTopModuleName(statement);

            Assert.That(result, Is.EqualTo("newpro"));
        }
    }
}
