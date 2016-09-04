using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class AssignDeclarationStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new AssignDeclarationStatementCriteria();
        }

        [Test]
        public void IsSatisfied_FirstTokenIsAssign_ReturnsTrue()
        {
            var statement = "assign some bla bla";

            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("assignsome bla bla")]
        [TestCase("assig some bla bla")]
        public void IsSatisfied_FirstTokenIsNotAssign_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
