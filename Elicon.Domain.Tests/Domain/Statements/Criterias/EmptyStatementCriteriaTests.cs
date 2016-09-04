using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class EmptyStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new EmptyStatementCriteria();
        }

        [Test]
        public void IsSatisfied_Empty_ReturnsTrue()
        {
            var statement = "";

            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("  ")]
        [TestCase("dfgs")]
        public void IsSatisfied_NotEmpty_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
