using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class MetaStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new MetaStatementCriteria();
        }

        [TestCase("`define some bla bla")]
        [TestCase("`timescale some bla bla")]
        public void IsSatisfied_MetaStatemnt_ReturnsTrue(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }
        [TestCase("define some bla bla")]
        [TestCase("timescale some bla bla")]
        public void IsSatisfied_NotMetaStatement_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
