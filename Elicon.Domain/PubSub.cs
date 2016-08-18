using System;
using System.Collections.Generic;
using Elicon.Framework;

namespace Elicon.Domain
{
    public interface IEvent {}

    public interface IEventSubscriber
    {
        void Init();
    }

    public interface IPubSub
    {
        void Publish<T>(T evenToPublish) where T : IEvent;
        void Subscribe<T>(Action<T> action) where T : IEvent;
    }

    public class PubSub : IPubSub
    {
        private readonly Dictionary<Type, List<Delegate>> _subscriptions = new Dictionary<Type, List<Delegate>>();

        public void Publish<T>(T evenToPublish) where T : IEvent
        {
            List<Delegate> actions;

            if (!_subscriptions.TryGetValue(typeof(T), out actions))
                return;

            foreach (var action in actions)
                ((Action<T>)action)(evenToPublish);
        }

        public void Subscribe<T>(Action<T> action) where T : IEvent
        {
            _subscriptions.ItemOrNew(typeof(T)).Add(action);
        }
    }
}

