using Elicon.Framework;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class TraversalTracker : ITraversalTracker
    {
        private readonly InstancesPath _path = new InstancesPath();

        public void UpdateIn(Instance instance)
        {
            if (instance.InstanceName.IsNullOrEmpty())
                return;

            _path.Push(instance.InstanceName);
        }

        public InstancesPath CurrentPath()
        {
            return new InstancesPath(_path);
        }

        public void UpdateOut()
        {
            if (_path.IsEmpty())
                return;

            _path.Pop();
        }
    }

    public interface ITraversalTracker
    {
        void UpdateIn(Instance instance);
        InstancesPath CurrentPath();
        void UpdateOut();
    }
}