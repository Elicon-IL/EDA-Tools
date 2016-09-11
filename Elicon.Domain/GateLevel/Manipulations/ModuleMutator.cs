using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IModuleMutator
    {
        void UpdatePortsType(Module module, IList<string> ports, PortType portType);
    }

    public class ModuleMutator : IModuleMutator
    {
        public void UpdatePortsType(Module module, IList<string> ports, PortType portType)
        {
            foreach (var modulePort in module.Ports)
                if (ports.Contains(modulePort.PortName))
                    modulePort.PortType = portType;
        }
    }
}