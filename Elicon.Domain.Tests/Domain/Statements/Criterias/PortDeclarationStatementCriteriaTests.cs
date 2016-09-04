using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class PortDeclarationStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PortDeclarationStatementCriteria();
        }

        [TestCase("input some bla bla")]
        [TestCase("output some bla bla")]
        [TestCase("inout some bla bla")]
        public void IsSatisfied_FirstTokenIsPort_ReturnsTrue(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("inputsome bla bla")]
        [TestCase("outputsome bla bla")]
        [TestCase("inoutsome bla bla")]
        [TestCase("inpu bla bla")]
        [TestCase("outpu bla bla")]
        [TestCase("inut bla bla")]
        public void IsSatisfied_FirstTokenIsNotPort_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
