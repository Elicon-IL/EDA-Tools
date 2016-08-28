using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IInstancePortsReplacer
    {
        void ReplacePorts(Instance instance, IDictionary<string, string> portsMap);
    }

    public class InstancePortsReplacer : IInstancePortsReplacer
    {
        public void ReplacePorts(Instance instance, IDictionary<string, string> portsMap)
        {
            foreach (var pwp in instance.Net)
                if (portsMap.ContainsKey(pwp.Port))
                    pwp.Port = portsMap[pwp.Port];
        }
    }
}