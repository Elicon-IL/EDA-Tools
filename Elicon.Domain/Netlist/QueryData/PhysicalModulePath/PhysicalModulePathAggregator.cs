using System;
using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.PhysicalModulePath
{
    public class PhysicalModulePathAggregator
    {
        private readonly Dictionary<string, IList<string>> _result;

        public PhysicalModulePathAggregator()
        {
            _result = new Dictionary<string, IList<string>>();
        }
        public void Collect(TraversalState traversalState)
        {
            if (IsModuleToTrack(traversalState.CurretnInstance))
                AddPath(traversalState);
        }

        public void SetModulesToTrack(IList<string> moduleNames)
        {
            foreach (var moduleName in moduleNames)
                _result.Add(moduleName, new List<string>());
        }

        public IDictionary<string, IList<string>> Result()
        {
            return _result;
        }

        private void AddPath(TraversalState traversalState)
        {
            _result[traversalState.CurretnInstance.CellName].Add(traversalState.InstancesPath.ToString());
        }
        
        private bool IsModuleToTrack(Instance instance)
        {
            return _result.ContainsKey(instance.CellName);
        }
    }
}