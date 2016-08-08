using Elicon.Domain.Netlist.Read;
using NUnit.Framework;

namespace Elicon.Domain.Tests
{
    [TestFixture]
    public class CommandTrimmerTests
    {
        private ICommandTrimmer _target;

        [SetUp]
        public void SetUp()
        {
            _target = new CommandTrimmer();
        }

        [Test]
        public void Trim_NoCommentNorTrainlingSpacesInCommand_CommandRemainTheSame()
        {
            var command = "module x_lut4_0x5050 ( i0, i2, o );";

            var result = _target.Trim(command);

            Assert.That(result, Is.EqualTo(command));
        }

        [Test]
        public void Trim_CommandHasTrainlingSpaces_SpacesRemoved()
        {
            var command = "     module x_lut4_0x5050 ( i0, i2, o );  ";
           
            var result = _target.Trim(command);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_CommandHasComment_CommentRemoved()
        {
            var command = "module x_lut4_0x5050 ( i0, i2, o );// this is a comment";

            var result = _target.Trim(command);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }

        [Test]
        public void Trim_CommandHasCommentAndTrailingSpaces_CommentAndSpacesRemoved()
        {
            var command = "   module x_lut4_0x5050 ( i0, i2, o );     // this is a comment    ";

            var result = _target.Trim(command);

            var expectedResult = "module x_lut4_0x5050 ( i0, i2, o );";
            Assert.That(result, Is.EqualTo(expectedResult));
        }
    }
}
