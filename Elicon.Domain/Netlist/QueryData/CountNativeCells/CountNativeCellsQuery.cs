using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.CountNativeCells
{
    public interface ICountNativeCellsQuery
    {
        IDictionary<string, long> CountNativeCells(string rootModule);
    }

    public class CountNativeCellsQuery : ICountNativeCellsQuery
    {
        private readonly IModuleTraverser _moduleTraverser;

        public CountNativeCellsQuery(IModuleTraverser moduleTraverser)
        {
            _moduleTraverser = moduleTraverser;
        }

        public IDictionary<string, long> CountNativeCells(string rootModule)
        {
            var aggregator = new NativeCellsCountAggregator();
            foreach (var traversalState in _moduleTraverser.Traverse(rootModule))
                aggregator.Collect(traversalState);
            
            return aggregator.Result();
        }
    }
}

