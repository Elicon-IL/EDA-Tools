using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class InstancesPath
    {
        private readonly Stack<string> _path;

        public InstancesPath()
        {
            _path = new Stack<string>();
        }

        public InstancesPath(InstancesPath path)
        {
            this._path = new Stack<string>(path._path);
        }

        public InstancesPath Push(string instanceName)
        {
           _path.Push(instanceName);
            return this;
        }

        public InstancesPath Pop()
        {
            _path.Pop();
            return this;
        }

        public bool IsEmpty()
        {
            return !_path.Any();
        }

        public override string ToString()
        {
            return _path.Aggregate("", (current, name) => current + (name + ", "));
        }
    }
}