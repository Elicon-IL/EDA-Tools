using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.QueryData.Traversal
{
    public class NetlistTraverser : INetlistTraverser
    {
        private readonly IInstanceRepository _instanceRepository;

        public NetlistTraverser(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IEnumerable<TraversalState> Traverse(string netlist, string rootModule)
        {
            return TraverseInner(new Instance(netlist, "", rootModule, ""), new InstancesPathTracker());
        }

        private IEnumerable<TraversalState> TraverseInner(Instance instance, InstancesPathTracker pathTracker)
        {
            pathTracker.UpdateIn(instance);

            var instances = _instanceRepository.GetByHostModule(instance.Netlist, instance.ModuleName);
            foreach (var curretnInstance in instances)
            {
                yield return new TraversalState {
                    CurrentInstance = curretnInstance,
                    InstancesPathTracker = new InstancesPathTracker(pathTracker).UpdateIn(curretnInstance)
                };

                if (curretnInstance.IsModule)
                    foreach (var state in TraverseInner(curretnInstance, pathTracker))
                        yield return state;
            }

            pathTracker.UpdateOut();
        }
    }

    public interface INetlistTraverser
    {
        IEnumerable<TraversalState> Traverse(string netlist, string rootModule);
    }
}
