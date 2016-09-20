using Elicon.Domain.GateLevel.Statements.Criterias;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Statements.Criterias
{
    [TestFixture]
    public class ModuleDeclarationStatementCriteriaTests
    {
        private IStatementCriteria _target;

        [SetUp]
        public void SetUp()
        {
            _target = new ModuleDeclarationStatementCriteria();
        }

        [Test]
        public void IsSatisfied_FirstTokenIsModule_ReturnsTrue()
        {
            var statement = "module x_lut4_0x5500 ( i0, i3, o );";

            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.True);
        }

        [TestCase("modul x_lut4_0x5500 ( i0, i3, o );")]
        [TestCase("modulex_lut4_0x5500 ( i0, i3, o );")]
        public void IsSatisfied_FirstTokenIsNotModule_ReturnsFalse(string statement)
        {
            var result = _target.IsSatisfied(statement);

            Assert.That(result, Is.False);
        }
    }
}
