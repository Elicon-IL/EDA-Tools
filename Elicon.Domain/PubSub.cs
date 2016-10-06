using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using Elicon.Framework;

namespace Elicon.Domain
{
    public interface IEvent {}

    public interface IEventSubscriber
    {
        void Init(IPubSub pubSub);
    }

    public interface IPubSub
    {
        void Publish<T>(T eventToPublish) where T : IEvent;
        void Subscribe<T>(Action<T> action) where T : IEvent;
    }

    public class PubSub : IPubSub
    {
        private readonly Dictionary<Type, List<Delegate>> _subscriptions = new Dictionary<Type, List<Delegate>>();
        private readonly ReaderWriterLockSlim _lock =  new ReaderWriterLockSlim();

        public void Publish<T>(T eventToPublish) where T : IEvent
        {
            List<Delegate> actions;
            _lock.EnterReadLock();
            try
            {
                actions = _subscriptions.ValueOrNew(typeof(T)).ToList();
            }
            finally
            {
                _lock.ExitReadLock();
            }

            foreach (var action in actions.Cast<Action<T>>())
                action(eventToPublish);
        }

        public void Subscribe<T>(Action<T> action) where T : IEvent
        {
            _lock.EnterWriteLock();
            try
            {
                _subscriptions.ValueOrNew(typeof(T)).Add(action);
            }
            finally
            {
                _lock.ExitWriteLock();
            }
        }
    }
}

