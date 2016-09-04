using System;
using System.Collections.Generic;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IInstanceMutator
    {
        IInstanceMutations Take(IList<Instance> instances);
    }

    public interface IInstanceMutations
    {
        IInstanceMutations ReplacePorts(PortsMapping portsMap);
        IInstanceMutations ReplaceWires(string oldWire, string newWire);
        IInstanceMutations PortsToUpper();
        IInstanceMutations MutateModuleName(string newModuleName);
    }

    public class InstanceMutator : IInstanceMutator
    {
        private class InstanceMutations : IInstanceMutations
        {
            private readonly IList<Instance> _instances;

            public InstanceMutations(IList<Instance> instances)
            {
                _instances = instances;
            }

            public IInstanceMutations ReplacePorts(PortsMapping portsMap)
            {
                MutatePorts(pwp => {
                    if (portsMap.HasMappingFor(pwp.Port))
                        pwp.Port = portsMap.Map(pwp.Port);
                });

                return this;
            }

            public IInstanceMutations ReplaceWires(string oldWire, string newWire)
            {
                MutatePorts(pwp => {
                    if (pwp.Wire == oldWire)
                        pwp.Wire = newWire;
                });

                return this;
            }

            public IInstanceMutations PortsToUpper()
            {
                MutatePorts(pwp => {
                    pwp.Port = pwp.Port.ToUpper();
                });

                return this;
            }

            public IInstanceMutations MutateModuleName(string newModuleName)
            {
                foreach (var instance in _instances)
                    instance.ModuleName = newModuleName;

                return this;
            }

            private void MutatePorts(Action<PortWirePair> mutation)
            {
                foreach (var instance in _instances)
                    foreach (var pwp in instance.Net)
                        mutation(pwp);
            }
        }

        public IInstanceMutations Take(IList<Instance> instances)
        {
            return new InstanceMutations(instances);
        }
    }
}
