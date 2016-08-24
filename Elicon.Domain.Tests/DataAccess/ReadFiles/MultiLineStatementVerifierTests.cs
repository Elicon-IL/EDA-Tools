using Elicon.DataAccess.Files.GateLevel.Read;
using NUnit.Framework;

namespace Elicon.Domain.Tests.DataAccess.ReadFiles
{
    [TestFixture]
    public class MultiLineStatementVerifierTests
    {
        private IMultiLineStatementVerifier _target;

        [SetUp]
        public void SetUp()
        {
            _target = new MultiLineStatementVerifier();
        }

        [Test]
        public void IsMultiLineStatement_StatementEndsWithSemicolon_ReturnsFalse()
        {
            var statement = "module x_lut4_0x5050 ( i0, i2, o );";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_MetaStatement_ReturnsFalse()
        {
            var statement = "`define top x_lut4";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_EmptyStatement_ReturnsFalse()
        {
            var statement = "";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }


        [Test]
        public void IsMultiLineStatement_EndModuleStatement_ReturnsFalse()
        {
            var statement = "endmodule";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_MultiLineStatement_ReturnsTrue()
        {
            var statement = "module x_lut4_0x5050 (";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.True);
        }
    }
}
