using System;
using System.Collections.Generic;

namespace Elicon.Domain
{
    public interface IEvent {} 

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

            _subscriptions.TryGetValue(typeof(T), out actions);
            if (actions == null)
                return;

            foreach (var action in actions)
                ((Action<T>)action)(evenToPublish);
        }

        public void Subscribe<T>(Action<T> action) where T : IEvent
        {
            if (!_subscriptions.ContainsKey(typeof(T)))
                _subscriptions.Add(typeof(T), new List<Delegate>());

            _subscriptions[typeof(T)].Add(action);
        }
    }
}

