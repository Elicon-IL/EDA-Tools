using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public class NativeModulesCountAggregator
    { 
        private readonly Dictionary<string, long> _result = new Dictionary<string, long>();

        public void Collect(TraversalState traversalState)
        {
            if (traversalState.CurrentInstance.IsModule())
                return;

            _result.UpdateValue(traversalState.CurrentInstance.ModuleName, count => ++count, 0);
        }

        public IList<NativeModuleCount> Result()
        {
            return _result
                .Select(kvp => new NativeModuleCount(kvp.Key, kvp.Value))
                .ToList();
        }
    }
}