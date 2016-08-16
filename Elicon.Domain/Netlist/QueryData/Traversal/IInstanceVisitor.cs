namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public interface IInstanceVisitor
    {
        void Visit(Instance instance);
        void Use(ITraversalTracker traversalTracker);
    }
}