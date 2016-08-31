using System.Collections.Generic;
using Elicon.Framework;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Framework
{
    [TestFixture]
    public class DictionaryExtensionsTests
    {
        private IPrecentageCalculator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PrecentageCalculator();
        }

        [Test]
        public void ValueOrNew_KeyNotInDictionary_ReturnsNewValue()
        {
            var target = new Dictionary<int, List<string>>();

            var result = target.ValueOrNew(1);

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void ValueOrNew_KeyInDictionary_ReturnsExistingValue()
        {
            var target = new Dictionary<int, List<string>>();
            var value = new List<string> {"value1"};
            const int key = 1;
            target.Add(key, value);

            var result = target.ValueOrNew(key);

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0], Is.EqualTo("value1"));
        }

        [Test]
        public void UpdateValue_KeyNotInDictionary_UpdateIntialValue()
        {
            var target = new Dictionary<int, List<string>>();
            const int key = 1;

            target.UpdateValue(key, l => {
                l.Add("wow");
                return l;
            },
            new List<string>());

            Assert.That(target[key], Has.Count.EqualTo(1));
            Assert.That(target[key][0], Is.EqualTo("wow"));
        }

        [Test]
        public void UpdateValue_KeyInDictionary_UpdateExistingValue()
        {
            var target = new Dictionary<int, List<string>>();
            var value = new List<string> { "wow" };
            const int key = 1;
            target.Add(key, value);

            target.UpdateValue(key, l => {
                l.Add("man");
                return l;
            },
            new List<string>());

            Assert.That(target[key], Has.Count.EqualTo(2));
            Assert.That(target[key][0], Is.EqualTo("wow"));
            Assert.That(target[key][1], Is.EqualTo("man"));
        }
    }
}
