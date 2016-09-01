using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IInstanceWiresReplacer
    {
        void ReplaceWires(IList<Instance> instances, string oldWire, string newWire);
    }

    public class InstanceWiresReplacer : IInstanceWiresReplacer
    {
        public void ReplaceWires(IList<Instance> instances, string oldWire, string newWire)
        {
            foreach (var instance in instances)
                foreach (var pwp in instance.Net)
                    if (pwp.Wire == oldWire)
                        pwp.Wire = newWire;
        }
    }
}