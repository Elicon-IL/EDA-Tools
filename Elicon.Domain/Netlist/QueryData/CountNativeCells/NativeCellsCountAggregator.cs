using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;
using Elicon.Framework;

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

            _result.UpdateValue(traversalState.CurretnInstance.ModuleName, count => count + 1, 0);
        }

        public IDictionary<string, long> Result()
        {
            return _result;
        }
    }
}