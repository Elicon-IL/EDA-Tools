using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

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

        public InstancesPath UpdateIn(Instance instance)
        {
            if (instance.InstanceName.IsNullOrEmpty())
                return this;

           _path.Push(instance.InstanceName);
            return this;
        }

        public void UpdateOut()
        {
            if (!_path.Any())
                return;

            _path.Pop();
        }

        public override string ToString()
        {
            return _path.Aggregate("", (current, name) => current + (name + ", "));
        }
    }
}