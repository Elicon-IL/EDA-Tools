using Elicon.Domain.Netlist.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class EndModuleStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new EndModuleStatementCriteria();
        }

        [Test]
        public void IsSatisfied_EndModule_ReturnsTrue()
        {
            var statement = "endmodule";

            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase(" endmodule ")]
        [TestCase("endmodul")]
        public void IsSatisfied_NotEndModule_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
