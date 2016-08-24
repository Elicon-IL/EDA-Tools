using System.Collections.Generic;
using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.QueryData.Traversal
{
    public class InstancesPathTracker
    {
        private readonly List<string> _path;

        public InstancesPathTracker()
        {
            _path = new List<string>();
        }

        public InstancesPathTracker(InstancesPathTracker pathTracker)
        {
            this._path = new List<string>(pathTracker._path);
        }

        public InstancesPathTracker UpdateIn(Instance instance)
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