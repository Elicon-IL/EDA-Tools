using Elicon.Domain.Netlist.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Statements.Criterias
{
    [TestFixture]
    public class WireDeclarationStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new WireDeclarationStatementCriteria();
        }

        [Test]
        public void IsSatisfied_FirstTokenIsWire_ReturnsTrue()
        {
            var statement = "wire some bla bla";

            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("wiresome bla bla")]
        [TestCase("wiree some bla bla")]
        public void IsSatisfied_FirstTokenIsNotWire_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
