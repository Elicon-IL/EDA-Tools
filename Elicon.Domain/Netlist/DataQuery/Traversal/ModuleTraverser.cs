using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery.Visitors;

namespace Elicon.Domain.Netlist.DataQuery.Traversal
{
    public class ModuleTraverser : IModuleTraverser
    {
        private readonly IInstanceRepository _instanceRepository;

        public ModuleTraverser(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public void Traverse(string moduleName, IInstanceVisitor visitor)
        {
            TraverseInner(new TraverseState(moduleName), visitor);
        }

        private void TraverseInner(TraverseState traverseState, IInstanceVisitor visitor)
        {
            var instances = _instanceRepository.GetByModule(traverseState.CurrentModuleName);
            foreach (var instance in instances)
            {
                visitor.Visit(instance, traverseState);
                if (instance.IsModule)
                    TraverseInner(new TraverseState(traverseState, instance), visitor);
            }
        }
    }

    public interface IModuleTraverser
    {
        void Traverse(string moduleName, IInstanceVisitor visitor);
    }
}