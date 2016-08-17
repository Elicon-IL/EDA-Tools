using System.Collections.Generic;
using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.PhysicalModulePath
{
    public interface IPhysicalModulePathQuery
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly IModuleTraverser _moduleTraverser;

        public PhysicalModulePathQuery(IModuleTraverser moduleTraverser)
        {
            _moduleTraverser = moduleTraverser;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string netlist, string rootModule, IList<string> moduleNames)
        {
            var aggregator = new PhysicalModulePathAggregator();
            aggregator.SetModulesToTrack(moduleNames);
            
            foreach (var traversalState in _moduleTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);

            return aggregator.Result();
        }
    }
}

