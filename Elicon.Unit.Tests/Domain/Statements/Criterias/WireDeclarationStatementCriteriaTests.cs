using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Statements.Criterias
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
            const string statement = "wire some bla bla";

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
