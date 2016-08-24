using System.Collections.Generic;
using Elicon.Domain.GateLevel.QueryData.Traversal;

namespace Elicon.Domain.GateLevel.QueryData.PhysicalModulePath
{
    public interface IPhysicalModulePathQuery
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly INetlistTraverser _netlistTraverser;

        public PhysicalModulePathQuery(INetlistTraverser netlistTraverser)
        {
            _netlistTraverser = netlistTraverser;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames)
        {
            var aggregator = new PhysicalModulePathAggregator(moduleNames);
            
            foreach (var traversalState in _netlistTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);

            return aggregator.Result();
        }
    }
}

