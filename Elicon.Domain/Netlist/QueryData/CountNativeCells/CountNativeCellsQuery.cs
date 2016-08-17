using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.CountNativeCells
{
    public interface ICountNativeCellsQuery
    {
        IDictionary<string, long> CountNativeCells(string netlist, string rootModule);
    }

    public class CountNativeCellsQuery : ICountNativeCellsQuery
    {
        private readonly IModuleTraverser _moduleTraverser;

        public CountNativeCellsQuery(IModuleTraverser moduleTraverser)
        {
            _moduleTraverser = moduleTraverser;
        }

        public IDictionary<string, long> CountNativeCells(string netlist, string rootModule)
        {
            var aggregator = new NativeCellsCountAggregator();
            foreach (var traversalState in _moduleTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);
            
            return aggregator.Result();
        }
    }
}

