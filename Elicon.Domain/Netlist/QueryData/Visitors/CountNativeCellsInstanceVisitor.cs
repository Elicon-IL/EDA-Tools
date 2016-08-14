using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.Visitors
{
    public interface ICountNativeCellsInstanceVisitor : IInstanceVisitor
    {
        IDictionary<string, long> Result();
    }

    public class CountNativeCellsInstanceVisitor : ICountNativeCellsInstanceVisitor
    {
        private readonly Dictionary<string, long> _result = new Dictionary<string, long>();

        public void Visit(Instance instance, TraverseState traverseState)
        {
            if (instance.IsModule)
                return;

            if (!_result.ContainsKey(instance.CellName))
                _result.Add(instance.CellName, 0);

            _result[instance.CellName]++;
        }

       public IDictionary<string, long> Result()
        {
            return _result;
        }
    }
}