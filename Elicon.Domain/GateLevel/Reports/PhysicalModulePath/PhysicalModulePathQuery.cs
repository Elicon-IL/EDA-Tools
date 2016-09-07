using System.Collections.Generic;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public interface IPhysicalModulePathQuery
    {
        IList<ModulePhysiclaPaths> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly INetlistTraverser _netlistTraverser;

        public PhysicalModulePathQuery(INetlistTraverser netlistTraverser)
        {
            _netlistTraverser = netlistTraverser;
        }

        public IList<ModulePhysiclaPaths> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames)
        {
            var aggregator = new PhysicalModulePathAggregator(moduleNames);
            
            foreach (var traversalState in _netlistTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);

            return aggregator.Result();
        }
    }
}

