using System.Collections.Generic;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;

namespace Elicon.Domain.GateLevel.Reports.CountLibraryGates
{
    public interface ICountLibraryGatesQuery
    {
        IList<LibraryGateCount> CountLibraryGates(string netlist, string rootModule);
    }

    public class CountLibraryGatesQuery : ICountLibraryGatesQuery
    {
        private readonly INetlistTraverser _netlistTraverser;

        public CountLibraryGatesQuery(INetlistTraverser netlistTraverser)
        {
            _netlistTraverser = netlistTraverser;
        }

        public IList<LibraryGateCount> CountLibraryGates(string netlist, string rootModule)
        {
            var aggregator = new LibraryGatesCountAggregator();
            foreach (var traversalState in _netlistTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);
            
            return aggregator.Result();
        }
    }
}

