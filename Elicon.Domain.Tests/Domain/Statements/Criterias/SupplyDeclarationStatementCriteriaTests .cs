using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class SupplyDeclarationStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new SupplyDeclarationStatementCriteria();
        }

        [TestCase("supply0 some bla bla")]
        [TestCase("supply1 some bla bla")]
        public void IsSatisfied_FirstTokenIsSupply_ReturnsTrue(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("supply0some bla bla")]
        [TestCase("supply1some bla bla")]
        [TestCase("supply2 bla bla")]
        public void IsSatisfied_FirstTokenIsNotSupply_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
