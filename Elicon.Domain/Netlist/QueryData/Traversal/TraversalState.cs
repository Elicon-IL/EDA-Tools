namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class TraversalState
    {
        public Instance CurrentInstance { get; set; }
        public InstancesPathTracker InstancesPathTracker { get; set; }
    }
}