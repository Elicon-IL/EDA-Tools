using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Reports.ListLibraryGates
{
    public class ListLibraryGatesAggregator
    {
        private readonly Dictionary<string, Instance> _result = new Dictionary<string, Instance>();
       
        public void Collect(Instance instance)
        {
            if (instance.IsModule())
                return;

            _result.UpdateValue(instance.ModuleName, 
                i => instance.Net.Count <= i.Net.Count ? i : instance, 
                instance);           
        }
        
        public IList<LibraryGate> Result()
        {
            return _result
                .Select(kvp => new LibraryGate(kvp.Key, kvp.Value.Net.Select(pwp => pwp.Port).ToList()))
                .ToList();
        }
    }
}