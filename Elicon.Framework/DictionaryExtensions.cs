using System;
using System.Collections.Generic;

namespace Elicon.Framework
{
    public static class DictionaryExtensions
    {
        public static TValue ValueOrNew<TKey, TValue>(this IDictionary<TKey, TValue> target, TKey key) where TValue : new()
        {
            TValue value;
            if (target.TryGetValue(key, out value))
                return value;
            
            target.Add(key, new TValue());
            return target[key];
        }

        public static TValue ValueOrDefault<TKey, TValue>(this Dictionary<TKey, TValue> dic, TKey key)
        {
            TValue value;
            return dic.TryGetValue(key, out value) ? value : default(TValue);
        }

        public static void UpdateValue<TKey, TValue>(this IDictionary<TKey, TValue> target, TKey key, Func<TValue,TValue> updater, TValue intialValue)
        {
            TValue value;
            if (!target.TryGetValue(key, out value))
                target[key] = intialValue;

            target[key] = updater(target[key]);
        }
    }
}
