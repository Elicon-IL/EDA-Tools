using System.Collections.Generic;

namespace Elicon.Framework
{
    public static class DictionaryExtension
    {
        public static TValue ItemOrNew<TKey, TValue>(this IDictionary<TKey, TValue> target, TKey key) where TValue : new()
        {
            TValue value;
            if (target.TryGetValue(key, out value))
                return value;
            
            target.Add(key, new TValue());
            return target[key];
        }
    }
}
