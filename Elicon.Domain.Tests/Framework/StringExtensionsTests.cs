using Elicon.Framework;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Framework
{
    [TestFixture]
    public class StringExtensionsTests
    {
        private string _target;

        [Test]
        public void FirstTokenIs_ExactMatch_ReturnsTrue()
        {
            _target = "token";

            var result = _target.FirstTokenIs("token");

            Assert.That(result, Is.True);
        }

        [Test]
        public void FirstTokenIs_MatchWithSpaceAfterToken_ReturnsTrue()
        {
            _target = "token dfsdfg";

            var result = _target.FirstTokenIs("token");

            Assert.That(result, Is.True);
        }

        [Test]
        public void FirstTokenIs_MatchWithTabAfterToken_ReturnsTrue()
        {
            _target = "token\tdfsdfg";

            var result = _target.FirstTokenIs("token");

            Assert.That(result, Is.True);
        }

        [TestCase("moken")]
        [TestCase("tokenwill")]
        public void FirstTokenIs_NoMatch_ReturnsFalse(string token)
        {
            _target = "token will match ?";

            var result = _target.FirstTokenIs(token);

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsEscaped_TargetIsEscasped_ReturnsTrue()
        {
            _target = "\\somestring";

            var result = _target.IsEscaped();

            Assert.That(result, Is.True);
        }

        [Test]
        public void RemoveLastCharAndTrim_TargetEmpty_ReturnsEmpty()
        {
            _target = "";

            var result = _target.RemoveLastCharAndTrim();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void RemoveLastCharAndTrim_TargetHasOneCharacter_ReturnsEmpty()
        {
            _target = "l";

            var result = _target.RemoveLastCharAndTrim();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void RemoveLastCharAndTrim_TargetHasManyCharacters_RemoveLastChar()
        {
            _target = "many many many";

            var result = _target.RemoveLastCharAndTrim();

            Assert.That(result, Is.EqualTo("many many man"));
        }

        [Test]
        public void RemoveLastCharAndTrim_TargetHasSpacesBeforeLastChar_RemoveLastCharAndTrim()
        {
            _target = "many many man      y";

            var result = _target.RemoveLastCharAndTrim();

            Assert.That(result, Is.EqualTo("many many man"));
        }

        [Test]
        public void RemoveFirstCharAndTrim_TargetEmpty_ReturnsEmpty()
        {
            _target = "";

            var result = _target.RemoveFirstCharAndTrim();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void RemoveFirstCharAndTrim_TargetHasOneCharacter_ReturnsEmpty()
        {
            _target = "l";

            var result = _target.RemoveFirstCharAndTrim();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void RemoveFirstCharAndTrim_TargetHasManyCharacters_RemoveFirstChar()
        {
            _target = "many many many";

            var result = _target.RemoveFirstCharAndTrim();

            Assert.That(result, Is.EqualTo("any many many"));
        }

        [Test]
        public void RemoveFirstCharAndTrim_TargetHasSpacesaAfterFirstChar_RemoveFirstCharAndTrim()
        {
            _target = "m      any many many";

            var result = _target.RemoveFirstCharAndTrim();

            Assert.That(result, Is.EqualTo("any many many"));
        }

        [Test]
        public void KeepUntilFirstExclusiveAndTrim_TargetEmpty_ReturnsEmpty()
        {
            _target = "";

            var result = _target.KeepUntilFirstExclusiveAndTrim("(");
            Assert.That(result, Is.Empty);

            result = _target.KeepUntilFirstExclusiveAndTrim('(');
            Assert.That(result, Is.Empty);
        }

        [Test]
        public void KeepUntilFirstExclusiveAndTrim_TargetDoesNotContainDelimiter_ReturnsTheSame()
        {
            _target = "some cool quote";

            var result = _target.KeepUntilFirstExclusiveAndTrim("(");
            Assert.That(result, Is.EqualTo(_target));

            result = _target.KeepUntilFirstExclusiveAndTrim('(');
            Assert.That(result, Is.EqualTo(_target));
        }

        [Test]
        public void KeepUntilFirstExclusiveAndTrim_TargetContainsDelimiter_ReturnsUntilTheFirstDelimiter()
        {
            _target = "some cool( quot(e";

            var result = _target.KeepUntilFirstExclusiveAndTrim("(");
            Assert.That(result, Is.EqualTo("some cool"));

            result = _target.KeepUntilFirstExclusiveAndTrim('(');
            Assert.That(result, Is.EqualTo("some cool"));
        }

        [Test]
        public void KeepUntilFirstExclusiveAndTrim_TargetContainsDelimiterWithSpacesBefore_ReturnsUntilTheFirstDelimiterAndTrim()
        {
            _target = "some cool    ( quot(e";

            var result = _target.KeepUntilFirstExclusiveAndTrim("(");
            Assert.That(result, Is.EqualTo("some cool"));

            result = _target.KeepUntilFirstExclusiveAndTrim('(');
            Assert.That(result, Is.EqualTo("some cool"));
        }


        [Test]
        public void KeepUntilLastExclusiveAndTrim_TargetEmpty_ReturnsEmpty()
        {
            _target = "";

            var result = _target.KeepUntilLastExclusiveAndTrim(")");
            Assert.That(result, Is.Empty);

            result = _target.KeepUntilLastExclusiveAndTrim(')');
            Assert.That(result, Is.Empty);
        }

        [Test]
        public void KeepUntilLastExclusiveAndTrim_TargetDoesNotContainDelimiter_ReturnsTheSame()
        {
            _target = "some cool quote";

            var result = _target.KeepUntilLastExclusiveAndTrim(")");
            Assert.That(result, Is.EqualTo(_target));

            result = _target.KeepUntilLastExclusiveAndTrim(')');
            Assert.That(result, Is.EqualTo(_target));
        }

        [Test]
        public void KeepUntilLastExclusiveAndTrim_TargetContainsDelimiter_ReturnsUntilLastDelimiter()
        {
            _target = "some cool) quot)e";

            var result = _target.KeepUntilLastExclusiveAndTrim(")");
            Assert.That(result, Is.EqualTo("some cool) quot"));

            result = _target.KeepUntilLastExclusiveAndTrim(')');
            Assert.That(result, Is.EqualTo("some cool) quot"));
        }

        [Test]
        public void KeepUntilLastExclusiveAndTrim_TargetContainsDelimiterWithSpacesBefore_ReturnsUntilTheLastDelimiterAndTrim()
        {
            _target = "some cool) quot     )e";

            var result = _target.KeepUntilLastExclusiveAndTrim(")");
            Assert.That(result, Is.EqualTo("some cool) quot"));

            result = _target.KeepUntilLastExclusiveAndTrim(')');
            Assert.That(result, Is.EqualTo("some cool) quot"));
        }

        [Test]
        public void KeepFromFirstInclusiveAndTrim_TargetEmpty_ReturnsEmpty()
        {
            _target = "";

            var result = _target.KeepFromFirstInclusiveAndTrim(")");
            Assert.That(result, Is.Empty);

            result = _target.KeepFromFirstInclusiveAndTrim(')');
            Assert.That(result, Is.Empty);
        }

        [Test]
        public void KeepFromFirstInclusiveAndTrim_TargetDoesNotContainDelimiter_ReturnsTheSame()
        {
            _target = "some cool quote";

            var result = _target.KeepFromFirstInclusiveAndTrim(")");
            Assert.That(result, Is.EqualTo(_target));

            result = _target.KeepFromFirstInclusiveAndTrim(')');
            Assert.That(result, Is.EqualTo(_target));
        }

        [Test]
        public void KeepFromFirstInclusiveAndTrim_TargetContainsDelimiter_ReturnsFromFirstDelimiterInclusive()
        {
            _target = "some -cool -quote";

            var result = _target.KeepFromFirstInclusiveAndTrim("-");
            Assert.That(result, Is.EqualTo("-cool -quote"));

            result = _target.KeepFromFirstInclusiveAndTrim('-');
            Assert.That(result, Is.EqualTo("-cool -quote"));
        }

        [Test]
        public void KeepFromFirstInclusiveAndTrim_TargetContainsDelimiterWithSpacesBefore_ReturnsFromFirstDelimiterInclusiveAndTrim()
        {
            _target = "some      cool quote";

            var result = _target.KeepFromFirstInclusiveAndTrim(" ");
            Assert.That(result, Is.EqualTo("cool quote"));

            result = _target.KeepFromFirstInclusiveAndTrim(' ');
            Assert.That(result, Is.EqualTo("cool quote"));
        }
    }
}
