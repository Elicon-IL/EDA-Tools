namespace Elicon.Domain.Netlist.QueryData.Visitors
{
    public interface IInstanceVisitor
    {
        void Visit(Instance instance);
    }
}