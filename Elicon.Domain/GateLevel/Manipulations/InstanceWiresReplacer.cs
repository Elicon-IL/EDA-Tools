using System.Collections.Generic;
using System.Linq;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IInstanceWiresReplacer
    {
        void ReplaceWires(Instance instance, IDictionary<string, string> wiresMap);
    }

    public class InstanceWiresReplacer : IInstanceWiresReplacer
    {
        public void ReplaceWires(Instance instance, IDictionary<string, string> wiresMap)
        {
            if (!wiresMap.Any())
                return;
            
            foreach (var pwp in instance.Net)
                if (wiresMap.ContainsKey(pwp.Wire))
                    pwp.Wire = wiresMap[pwp.Wire];
        }
    }
}