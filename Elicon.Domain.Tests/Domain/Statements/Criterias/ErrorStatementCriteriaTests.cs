using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class ErrorStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new ErrorStatementCriteria();
        }

        [TestCase("defparam some bla bla")]
        [TestCase("initial some bla bla")]
        [TestCase("tri some bla bla")]
        [TestCase("tri0 some bla bla")]
        [TestCase("tri1 some bla bla")]
        [TestCase("tran some bla bla")]
        public void IsSatisfied_FirstTokenIsError_ReturnsTrue(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("defaram some bla bla")]
        [TestCase("iniial some bla bla")]
        [TestCase("trisome bla bla")]
        [TestCase("ti0 some bla bla")]
        [TestCase("tri1some bla bla")]
        [TestCase("tra some bla bla")]
        public void IsSatisfied_FirstTokenIsNotError_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
