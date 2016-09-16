using System.Collections.Generic;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;

namespace Elicon.Domain.GateLevel.Reports.ListPhysicalPaths
{
    public interface IPhysicalPathQuery
    {
        IList<ModulePhysiclaPaths> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalPathQuery : IPhysicalPathQuery
    {
        private readonly INetlistTraverser _netlistTraverser;

        public PhysicalPathQuery(INetlistTraverser netlistTraverser)
        {
            _netlistTraverser = netlistTraverser;
        }

        public IList<ModulePhysiclaPaths> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames)
        {
            var aggregator = new PhysicalPathAggregator(moduleNames);
            
            foreach (var traversalState in _netlistTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);

            return aggregator.Result();
        }
    }
}

