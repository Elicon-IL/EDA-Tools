using Elicon.Domain.Netlist.Read;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Read
{
    [TestFixture]
    public class StatementTrimmerTests
    {
        private IStatementTrimmer _target;

        [SetUp]
        public void SetUp()
        {
            _target = new StatementTrimmer();
        }

        [TestCase("`define 1 ns/1 ps")]
        [TestCase("   `timescale 1 ns/1 ps")]
        public void Trim_MetaStatement_ReturnsEmpty(string statement)
        {
            var result = _target.Trim(statement);

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void Trim_NoCommentNorTrainlingSpacesInStatement_StatementRemainTheSame()
        {
            var statement = "module x_lut4_0x5050 ( i0, i2, o );";

            var result = _target.Trim(statement);

            Assert.That(result, Is.EqualTo(statement));
        }

        [Test]
        public void Trim_StatementHasTrainlingSpaces_SpacesRemoved()
        {
            var statement = "     module x_lut4_0x5050 ( i0, i2, o );  ";
           
            var result = _target.Trim(statement);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_StatementHasComment_CommentRemoved()
        {
            var statement = "module x_lut4_0x5050 ( i0, i2, o );// this is a comment";

            var result = _target.Trim(statement);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_StatementHasCommentAndTrailingSpaces_CommentAndSpacesRemoved()
        {
            var statement = "   module x_lut4_0x5050 ( i0, i2, o );     // this is a comment    ";

            var result = _target.Trim(statement);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }
    }
}
