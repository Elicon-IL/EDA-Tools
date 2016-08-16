using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class ModuleTraverser : IModuleTraverser
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly ITraversalTracker _traversalTracker;

        public ModuleTraverser(IInstanceRepository instanceRepository, ITraversalTracker traversalTracker)
        {
            _instanceRepository = instanceRepository;
            _traversalTracker = traversalTracker;
        }

        public void Traverse(string rootModule, IInstanceVisitor visitor)
        {
            DoTraverse(new Instance(rootModule, ""), visitor);
        }

        private void DoTraverse(Instance currentInstance, IInstanceVisitor visitor)
        {
            _traversalTracker.UpdateIn(currentInstance);

            var instances = _instanceRepository.GetByModule(currentInstance.CellName);
            foreach (var instance in instances)
            {
                visitor.UpdatePath(_traversalTracker.CurrentPath());
                visitor.Visit(instance);
                if (instance.IsModule)
                    DoTraverse(instance, visitor);      
            }

            _traversalTracker.UpdateOut();
        }
    }

    public interface IModuleTraverser
    {
        void Traverse(string rootModule, IInstanceVisitor visitor);
    }
}