using Elicon.Framework;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Framework
{
    [TestFixture]
    public class PrecentageCalculatorTests
    {
        private IPrecentageCalculator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PrecentageCalculator();
        }

        [Test]
        public void CalculateProgression_ZeroProgression_ReturnsZero()
        {
            var result = _target.CalculatePrecentage(0, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void CalculateProgression_LessThanOnePrecent_ReturnsZero()
        {
            var result = _target.CalculatePrecentage(9, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void CalculateProgression_ProgressionIsOnePrecent_ReturnsOne()
        {
            var result = _target.CalculatePrecentage(10, 1000);

            Assert.That(result, Is.EqualTo(1));
        }

        [Test]
        public void CalculateProgression_ProgressionIsNintyNinePrecent_ReturnsNintyNine()
        {
            var result = _target.CalculatePrecentage(990, 1000);

            Assert.That(result, Is.EqualTo(99));
        }


        [Test]
        public void CalculateProgression_ProgressionAlmostOneHundredPrecent_ReturnsNintyNine()
        {
            var result = _target.CalculatePrecentage(999, 1000);

            Assert.That(result, Is.EqualTo(99));
        }

        [Test]
        public void CalculateProgression_ProgressionIsOneHundredPrecent_ReturnsOneHundred()
        {
            var result = _target.CalculatePrecentage(1000, 1000);

            Assert.That(result, Is.EqualTo(100));
        }

        [Test]
        public void CalculateProgression_PartIsNegative_ReturnsZero()
        {
            var result = _target.CalculatePrecentage(-10, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void CalculateProgression_PartIsTwiceThanTotal_ReturnsTwoHundreds()
        {
            var result = _target.CalculatePrecentage(2000, 1000);

            Assert.That(result, Is.EqualTo(200));
        }
    }
}
