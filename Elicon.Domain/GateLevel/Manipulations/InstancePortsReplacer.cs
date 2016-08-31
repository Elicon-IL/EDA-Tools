using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IInstancePortsReplacer
    {
        void ReplacePorts(IList<Instance> instances, IDictionary<string, string> portsMap);
    }

    public class InstancePortsReplacer : IInstancePortsReplacer
    {
        public void ReplacePorts(IList<Instance> instances, IDictionary<string, string> portsMap)
        {
            foreach (var instance in instances)
                foreach (var pwp in instance.Net)
                    if (portsMap.ContainsKey(pwp.Port))
                        pwp.Port = portsMap[pwp.Port];
        }
    }
}