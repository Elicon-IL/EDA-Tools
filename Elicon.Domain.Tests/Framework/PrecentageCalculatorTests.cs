using Elicon.Framework;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Framework
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
        public void ClaculateProgression_ZeroProgression_ReturnsZero()
        {
            var result = _target.CalculatePrecentage(0, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void ClaculateProgression_LessThanOnePrecent_ReturnsZero()
        {
            var result = _target.CalculatePrecentage(9, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void ClaculateProgression_ProgressionIsOnePrecent_ReturnsOne()
        {
            var result = _target.CalculatePrecentage(10, 1000);

            Assert.That(result, Is.EqualTo(1));
        }

        [Test]
        public void ClaculateProgression_ProgressionIsNintyNinePrecent_ReturnsNintyNine()
        {
            var result = _target.CalculatePrecentage(990, 1000);

            Assert.That(result, Is.EqualTo(99));
        }


        [Test]
        public void ClaculateProgression_ProgressionAlmostOneHundredPrecent_ReturnsNintyNine()
        {
            var result = _target.CalculatePrecentage(999, 1000);

            Assert.That(result, Is.EqualTo(99));
        }

        [Test]
        public void ClaculateProgression_ProgressionIsOneHundredPrecent_ReturnsOneHundred()
        {
            var result = _target.CalculatePrecentage(1000, 1000);

            Assert.That(result, Is.EqualTo(100));
        }
    }
}
