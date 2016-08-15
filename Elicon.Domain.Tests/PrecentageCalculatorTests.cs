using Elicon.Domain.Netlist;
using NUnit.Framework;

namespace Elicon.Domain.Tests
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
            var result = _target.ClaculatePrecentage(0, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void ClaculateProgression_LessThanOnePrecent_ReturnsZero()
        {
            var result = _target.ClaculatePrecentage(9, 1000);

            Assert.That(result, Is.Zero);
        }

        [Test]
        public void ClaculateProgression_ProgressionIsOnePrecent_ReturnsOne()
        {
            var result = _target.ClaculatePrecentage(10, 1000);

            Assert.That(result, Is.EqualTo(1));
        }

        [Test]
        public void ClaculateProgression_ProgressionIsNintyNinePrecent_ReturnsNintyNine()
        {
            var result = _target.ClaculatePrecentage(990, 1000);

            Assert.That(result, Is.EqualTo(99));
        }


        [Test]
        public void ClaculateProgression_ProgressionAlmostOneHundredPrecent_ReturnsNintyNine()
        {
            var result = _target.ClaculatePrecentage(999, 1000);

            Assert.That(result, Is.EqualTo(99));
        }

        [Test]
        public void ClaculateProgression_ProgressionIsOneHundredPrecent_ReturnsOneHundred()
        {
            var result = _target.ClaculatePrecentage(1000, 1000);

            Assert.That(result, Is.EqualTo(100));
        }
    }
}
