using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class ModuleTraverser : IModuleTraverser
    {
        private readonly IInstanceRepository _instanceRepository;
       
        public ModuleTraverser(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IEnumerable<TraversalState> Traverse(string rootModule)
        {
            return TraverseInner(new Instance(rootModule, ""), new InstancesPath());
        }

        private IEnumerable<TraversalState> TraverseInner(Instance instance, InstancesPath instancesPath)
        {
            instancesPath.UpdateIn(instance);

            var instances = _instanceRepository.GetByModule(instance.CellName);
            foreach (var curretnInstance in instances)
            {
                yield return new TraversalState {
                    CurretnInstance = curretnInstance,
                    InstancesPath = new InstancesPath(instancesPath).UpdateIn(curretnInstance)
                };

                if (curretnInstance.IsModule)
                    foreach (var state in TraverseInner(curretnInstance, instancesPath))
                        yield return state;
            }

            instancesPath.UpdateOut();
        }
    }

    public interface IModuleTraverser
    {
        IEnumerable<TraversalState> Traverse(string rootModule);
    }
}
