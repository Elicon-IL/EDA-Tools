using Elicon.Domain.Netlist.QueryData.Traversal;

namespace Elicon.Domain.Netlist.QueryData.Visitors
{
    public interface IInstanceVisitor
    {
        void Visit(Instance instance, TraverseState traverseState);
    }
}