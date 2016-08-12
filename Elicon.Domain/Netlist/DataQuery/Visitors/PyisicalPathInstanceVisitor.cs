using System.Collections.Generic;
using Elicon.Domain.Netlist.DataQuery.Traversal;

namespace Elicon.Domain.Netlist.DataQuery.Visitors
{
    public interface IPhysicalPathInstanceVisitor : IInstanceVisitor
    {
        void SetModulesToTrack(IList<string> moduleNames);
        IDictionary<string, IList<string>> Result();
    }

    public class PhysicalPathInstanceVisitor : IPhysicalPathInstanceVisitor
    {
        private readonly Dictionary<string, IList<string>> _result = new Dictionary<string, IList<string>>();
        
        public void Visit(Instance instance, TraverseState traverseState)
        {
            if (_result.ContainsKey(instance.CellName))
                _result[instance.CellName].Add(traverseState.InstancesPath + ", " + instance.InstanceName);
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
    }
}