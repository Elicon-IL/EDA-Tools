using Elicon.DataAccess.Files.GateLevel.Read;
using NUnit.Framework;

namespace Elicon.Unit.Tests.DataAccess.Read
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

        [Test]
        public void Trim_NoCommentNorTrainlingSpacesInStatement_StatementRemainTheSame()
        {
            const string statement = "module x_lut4_0x5050 ( i0, i2, o );";

            var result = _target.Trim(statement);

            Assert.That(result, Is.EqualTo(statement));
        }

        [Test]
        public void Trim_StatementHasTrainlingSpaces_SpacesRemoved()
        {
            const string statement = "     module x_lut4_0x5050 ( i0, i2, o );  ";
           
            var result = _target.Trim(statement);

            const string expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_StatementHasComment_CommentRemoved()
        {
            const string statement = "module x_lut4_0x5050 ( i0, i2, o );// this is a comment";

            var result = _target.Trim(statement);

            const string expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_StatementHasCommentAndTrailingSpaces_CommentAndSpacesRemoved()
        {
            const string statement = "   module x_lut4_0x5050 ( i0, i2, o );     // this is a comment    ";

            var result = _target.Trim(statement);

            const string expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }
    }
}
