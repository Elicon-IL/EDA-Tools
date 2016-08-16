using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.CountNativeCells
{
    public class CountNativeCellsInstanceVisitor : IInstanceVisitor
    {
        private readonly Dictionary<string, long> _result;

        public CountNativeCellsInstanceVisitor()
        {
            _result = new Dictionary<string, long>();
        }

        public void Visit(Instance instance)
        {
            if (instance.IsModule)
                return;

            if (!_result.ContainsKey(instance.CellName))
                _result.Add(instance.CellName, 0);

            _result[instance.CellName]++;
        }

        public void UpdatePath(InstancesPath instancesPath) { }

        public IDictionary<string, long> Result()
        {
            return _result;
        }
    }
}