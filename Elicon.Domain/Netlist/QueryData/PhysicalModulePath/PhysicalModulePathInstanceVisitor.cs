using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.PhysicalModulePath
{
    public class PhysicalModulePathInstanceVisitor : IInstanceVisitor
    {
        private readonly Dictionary<string, IList<string>> _result;
        private InstancesPath _path;

        public PhysicalModulePathInstanceVisitor()
        {
            _result = new Dictionary<string, IList<string>>();
            _path = new InstancesPath();
        }

        public void Visit(Instance instance)
        {
            if (IsModuleToTrack(instance))
                AddPath(instance);
        }

        public void UpdatePath(InstancesPath instancesPath)
        {
            _path = instancesPath;
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
            _result[instance.CellName].Add(_path
                .Push(instance.InstanceName)
                .ToString());
        }

        private bool IsModuleToTrack(Instance instance)
        {
            return _result.ContainsKey(instance.CellName);
        }
    }
}