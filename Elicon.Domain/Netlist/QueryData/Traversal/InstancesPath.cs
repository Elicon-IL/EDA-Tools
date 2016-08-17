using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.QueryData.Traversal
{
    public class InstancesPath
    {
        private readonly List<string> _path;

        public InstancesPath()
        {
            _path = new List<string>();
        }

        public InstancesPath(InstancesPath path)
        {
            this._path = new List<string>(path._path);
        }

        public InstancesPath UpdateIn(Instance instance)
        {
            if (instance.InstanceName.IsNullOrEmpty())
                return this;

           _path.Add(instance.InstanceName);
            return this;
        }

        public void UpdateOut()
        {
            if (!_path.Any())
                return;

            _path.RemoveAt(_path.Count - 1);
        }

        public override string ToString()
        {
            return string.Join("/", _path);
        }
    }
}