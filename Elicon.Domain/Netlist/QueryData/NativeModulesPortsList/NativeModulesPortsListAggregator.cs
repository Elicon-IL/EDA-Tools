using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.QueryData.NativeModulesPortsList
{
    public class NativeModulesPortsListAggregator
    {
        private readonly Dictionary<string, Instance> _result = new Dictionary<string, Instance>();
       
        public void Collect(Instance instance)
        {
            if (instance.IsModule)
                return;
            
            _result.UpdateValue(instance.ModuleName, 
                i => instance.Net.Count <= i.Net.Count ? i : instance, 
                instance);           
        }
        
        public IDictionary<string, string[]> Result()
        {
            return _result.ToDictionary(
                kvp => kvp.Key, 
                kvp => kvp.Value.Net
                    .Select(pwp => pwp.Port)
                    .ToArray()
                );
        }
    }
}