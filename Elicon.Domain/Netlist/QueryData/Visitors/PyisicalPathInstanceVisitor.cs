using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.Visitors
{
    public interface IPhysicalPathInstanceVisitor : IInstanceVisitor
    {
        void SetModulesToTrack(IList<string> moduleNames);
        IDictionary<string, IList<string>> Result();
    }

    public class PhysicalPathInstanceVisitor : IPhysicalPathInstanceVisitor
    {
        private readonly Dictionary<string, IList<string>> _result = new Dictionary<string, IList<string>>();
        private readonly ITraversalTracker _traversalTracker;

        public PhysicalPathInstanceVisitor(ITraversalTracker traversalTracker)
        {
            _traversalTracker = traversalTracker;
        }

        public void Visit(Instance instance)
        {
            if (IsModuleToTrack(instance))
                AddPath(instance);
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
            var currentPath = _traversalTracker.CurrentPath();

            _result[instance.CellName].Add(currentPath
                .Push(instance.InstanceName)
                .ToString());
        }

        private bool IsModuleToTrack(Instance instance)
        {
            return _result.ContainsKey(instance.CellName);
        }
    }
}