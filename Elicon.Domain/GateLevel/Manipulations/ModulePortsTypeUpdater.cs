using System.Collections.Generic;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface IModulePortsTypeUpdater
    {
        void UpdatePortsType(Module module, IList<string> portNamesToUpdate, PortType portType);
    }

    public class ModulePortsTypeUpdater : IModulePortsTypeUpdater
    {
        public void UpdatePortsType(Module module, IList<string> portNamesToUpdate, PortType portType)
        {
            foreach (var modulePort in module.Ports)
                if (portNamesToUpdate.Contains(modulePort.PortName))
                    modulePort.PortType = portType;
        }
    }
}