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

        public void Traverse(string rootModule, IInstanceVisitor visitor)
        {
            var tracker = new TraversalTracker();
            visitor.Use(tracker);
            var instance = new Instance(rootModule, "");

            DoTraverse(instance, visitor, tracker);
        }

        private void DoTraverse(Instance currentInstance, IInstanceVisitor visitor, ITraversalTracker tracker)
        {
            tracker.UpdateIn(currentInstance);

            var instances = _instanceRepository.GetByModule(currentInstance.CellName);
            foreach (var instance in instances)
            {
                visitor.Visit(instance);
                if (instance.IsModule)
                    DoTraverse(instance, visitor, tracker);      
            }

            tracker.UpdateOut();
        }
    }

    public interface IModuleTraverser
    {
        void Traverse(string rootModule, IInstanceVisitor visitor);
    }
}