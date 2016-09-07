using System.Collections.Generic;
using Elicon.Domain.GateLevel.Traversal.PhysicalTraversal;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public interface ICountNativeModulesQuery
    {
        IList<ModuleCount> CountNativeModules(string netlist, string rootModule);
    }

    public class CountNativeModulesQuery : ICountNativeModulesQuery
    {
        private readonly INetlistTraverser _netlistTraverser;

        public CountNativeModulesQuery(INetlistTraverser netlistTraverser)
        {
            _netlistTraverser = netlistTraverser;
        }

        public IList<ModuleCount> CountNativeModules(string netlist, string rootModule)
        {
            var aggregator = new NativeModulesCountAggregator();
            foreach (var traversalState in _netlistTraverser.Traverse(netlist, rootModule))
                aggregator.Collect(traversalState);
            
            return aggregator.Result();
        }
    }
}

