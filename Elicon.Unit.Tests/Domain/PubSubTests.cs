﻿using Elicon.Domain;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain
{
    [TestFixture]
    public class PubSubTests
    {
        private IPubSub _target;

        [SetUp]
        public void SetUp()
        {
            _target = new PubSub();
        }

        [Test]
        public void Publish_OneEvent_SubscriberExecutes()
        {
            var result = "";
            const string excpectedText = "Bla Bla";
            _target.Subscribe<DummyEvent>(ev => result = excpectedText);
         
            _target.Publish(new DummyEvent());

            Assert.That(result, Is.EqualTo(excpectedText));
        }

        [Test]
        public void Publish_OneEvent_OnlyCorrectSubscriberExecutes()
        {
            var result = "";
            var anotherResult = "";
            const string excpectedText = "Bla Bla";
            const string anotherText = "Yada Yada";
            _target.Subscribe<DummyEvent>(ev => result = excpectedText);
            _target.Subscribe<AnotherDummyEvent>(ev => anotherResult = anotherText);

            _target.Publish(new DummyEvent());

            Assert.That(result, Is.EqualTo(excpectedText));
            Assert.That(anotherResult, Is.Empty);
        }

        [Test]
        public void Publish_OneEvent_BothSubscribersExecutes()
        {
            var result = "";
            var anotherResult = "";
            const string excpectedText = "Bla Bla";
            const string anotherExpectedText = "Yada Yada";
            _target.Subscribe<DummyEvent>(ev => result = excpectedText);
            _target.Subscribe<DummyEvent>(ev => anotherResult = anotherExpectedText);

            _target.Publish(new DummyEvent());

            Assert.That(result, Is.EqualTo(excpectedText));
            Assert.That(anotherResult, Is.EqualTo(anotherExpectedText));
        }

        [Test]
        public void Publish_TwoDifferentEvent_BothSubscribersExecutes()
        {
            var result = "";
            var anotherResult = "";
            const string excpectedText = "Bla Bla";
            const string anotherExpectedText = "Yada Yada";
            _target.Subscribe<DummyEvent>(ev => result = excpectedText);
            _target.Subscribe<AnotherDummyEvent>(ev => anotherResult = anotherExpectedText);

            _target.Publish(new DummyEvent());
            _target.Publish(new AnotherDummyEvent());

            Assert.That(result, Is.EqualTo(excpectedText));
            Assert.That(anotherResult, Is.EqualTo(anotherExpectedText));
        }

        public class DummyEvent : IEvent
        {
            public string Text { get; } = "Dummy Event";
        }

        public class AnotherDummyEvent : IEvent
        {
            public string Text { get; } = "Another Dummy Event";
        }
    }
}
