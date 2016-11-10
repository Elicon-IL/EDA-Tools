using System.Collections.Generic;
using Elicon.Framework;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Framework
{
    [TestFixture]
    public class DictionaryExtensionsTests
    {
        private Dictionary<int, List<string>> _target;

        [SetUp]
        public void SetUp()
        {
            _target = new Dictionary<int, List<string>>();
        }

        [Test]
        public void ValueOrNew_KeyNotInDictionary_ReturnsNewValue()
        {
            var result = _target.ValueOrNew(1);

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void ValueOrNew_KeyInDictionary_ReturnsExistingValue()
        {
            var value = new List<string> {"value1"};
            const int key = 1;
            _target.Add(key, value);

            var result = _target.ValueOrNew(key);

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0], Is.EqualTo("value1"));
        }

        [Test]
        public void ValueOrDefault_KeyNotInDictionary_ReturnsDefaultValue()
        {
            var result = _target.ValueOrDefault(1);

            Assert.That(result, Is.Null);
        }

        [Test]
        public void ValueOrDefault_KeyInDictionary_ReturnsExistingValue()
        {
            var value = new List<string> { "value1" };
            const int key = 1;
            _target.Add(key, value);

            var result = _target.ValueOrDefault(key);

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0], Is.EqualTo("value1"));
        }

        [Test]
        public void UpdateValue_KeyNotInDictionary_UpdateIntialValue()
        {
            const int key = 1;

            _target.UpdateValue(key, l => {
                l.Add("wow");
                return l;
            },
            new List<string>());

            Assert.That(_target[key], Has.Count.EqualTo(1));
            Assert.That(_target[key][0], Is.EqualTo("wow"));
        }

        [Test]
        public void UpdateValue_KeyInDictionary_UpdateExistingValue()
        {
            var value = new List<string> { "wow" };
            const int key = 1;
            _target.Add(key, value);

            _target.UpdateValue(key, l => {
                l.Add("man");
                return l;
            },
            new List<string>());

            Assert.That(_target[key], Has.Count.EqualTo(2));
            Assert.That(_target[key][0], Is.EqualTo("wow"));
            Assert.That(_target[key][1], Is.EqualTo("man"));
        }
    }
}
