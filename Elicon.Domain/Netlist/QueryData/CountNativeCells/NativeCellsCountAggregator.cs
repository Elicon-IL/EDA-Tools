using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.CountNativeCells
{
    public class NativeCellsCountAggregator
    { 
        private readonly Dictionary<string, long> _result;

        public NativeCellsCountAggregator()
        {
            _result = new Dictionary<string, long>();
        }

        public void Collect(TraversalState traversalState)
        {
            if (traversalState.CurretnInstance.IsModule)
                return;

            if (!_result.ContainsKey(traversalState.CurretnInstance.CellName))
                _result.Add(traversalState.CurretnInstance.CellName, 0);

            _result[traversalState.CurretnInstance.CellName]++;
        }

        public IDictionary<string, long> Result()
        {
            return _result;
        }
    }
}