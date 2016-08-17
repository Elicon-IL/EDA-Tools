using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class NetlistTraverser : INetlistTraverser
    {
        private readonly INetlistRepositoryProvider _netlistRepositoryProvider;

        public NetlistTraverser(INetlistRepositoryProvider netlistRepositoryProvider)
        {
            _netlistRepositoryProvider = netlistRepositoryProvider;
        }

        public IEnumerable<TraversalState> Traverse(string netlist, string rootModule)
        {
            var netlistRepository = _netlistRepositoryProvider.GetRepositoryFor(netlist);
            var instance = new Instance(rootModule, "");
            var instancesPath = new InstancesPath();

            return TraverseInner(netlistRepository, instance, instancesPath);
        }

        private IEnumerable<TraversalState> TraverseInner(INetlistRepository repository, Instance instance, InstancesPath instancesPath)
        {
            instancesPath.UpdateIn(instance);

            var instances = repository.GetModuleInstances(instance.CellName);
            foreach (var curretnInstance in instances)
            {
                yield return new TraversalState {
                    CurretnInstance = curretnInstance,
                    InstancesPath = new InstancesPath(instancesPath).UpdateIn(curretnInstance)
                };

                if (curretnInstance.IsModule)
                    foreach (var state in TraverseInner(repository, curretnInstance, instancesPath))
                        yield return state;
            }

            instancesPath.UpdateOut();
        }
    }

    public interface INetlistTraverser
    {
        IEnumerable<TraversalState> Traverse(string netlist, string rootModule);
    }
}
