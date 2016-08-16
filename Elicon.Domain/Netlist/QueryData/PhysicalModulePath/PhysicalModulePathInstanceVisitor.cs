using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.PhysicalModulePath
{
    public class PhysicalModulePathInstanceVisitor : IInstanceVisitor
    {
        private readonly Dictionary<string, IList<string>> _result;
        private ITraversalTracker _traversalTracker;

        public PhysicalModulePathInstanceVisitor()
        {
            _result = new Dictionary<string, IList<string>>();
        }

        public void Visit(Instance instance)
        {
            if (IsModuleToTrack(instance))
                AddPath(instance);
        }

        public void Use(ITraversalTracker traversalTracker)
        {
            _traversalTracker = traversalTracker;
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

        private void AddPath(Instance instance)
        {
            _result[instance.CellName].Add(
                _traversalTracker.CurrentPath()
                .Push(instance.InstanceName)
                .ToString());
        }

        private bool IsModuleToTrack(Instance instance)
        {
            return _result.ContainsKey(instance.CellName);
        }
    }
}