using Elicon.DataAccess.Files.GateLevel.Read;
using NUnit.Framework;

namespace Elicon.Unit.Tests.DataAccess.Read
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
            const string statement = "module x_lut4_0x5050 ( i0, i2, o );";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_MetaStatement_ReturnsFalse()
        {
            const string statement = "`define top x_lut4";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_EmptyStatement_ReturnsFalse()
        {
            const string statement = "";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }


        [Test]
        public void IsMultiLineStatement_EndModuleStatement_ReturnsFalse()
        {
            const string statement = "endmodule";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsMultiLineStatement_MultiLineStatement_ReturnsTrue()
        {
            const string statement = "module x_lut4_0x5050 (";

            var result = _target.IsMultiLineStatement(statement);

            Assert.That(result, Is.True);
        }
    }
}
