using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class ModuleTraverser : IModuleTraverser
    {
        private readonly INetlistRepositoryProvider _netlistRepositoryProvider;

        public ModuleTraverser(INetlistRepositoryProvider netlistRepositoryProvider)
        {
            _netlistRepositoryProvider = netlistRepositoryProvider;
        }

        public IEnumerable<TraversalState> Traverse(string netlist, string rootModule)
        {
            return TraverseInner(_netlistRepositoryProvider.GetRepositoryFor(netlist), new Instance(rootModule, ""), new InstancesPath());
        }

        private IEnumerable<TraversalState> TraverseInner(INetlistRepository repository, Instance instance, InstancesPath instancesPath)
        {
            instancesPath.UpdateIn(instance);

            var instances = repository.GetByModule(instance.CellName);
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

    public interface IModuleTraverser
    {
        IEnumerable<TraversalState> Traverse(string netlist, string rootModule);
    }
}
