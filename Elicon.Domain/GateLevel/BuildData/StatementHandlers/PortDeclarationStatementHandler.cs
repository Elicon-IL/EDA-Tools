using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Parse;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class PortDeclarationStatementHandler : IStatementHandler
    {
        private readonly PortDeclarationStatementCriteria _criteria = new PortDeclarationStatementCriteria();
        private readonly PortsDeclarationStatementParser _parser = new PortsDeclarationStatementParser();

        private readonly IModuleRepository _moduleRepository;

        public PortDeclarationStatementHandler(IModuleRepository moduleRepository)
        {
            _moduleRepository = moduleRepository;
        }

        public void Handle(BuildState state)
        {
            var portType = _parser.GetPortType(state.CurrentStatement);
            var portNames = _parser.GetPorts(state.CurrentStatement).Select(p => p.PortName).ToList();

            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);
            SetModulePortsType(module, portNames, portType);

            _moduleRepository.Update(module);
        }

        private void SetModulePortsType(Module module, IList<string> portNamesToUpdate, PortType portType)
        {
            foreach (var modulePort in module.Ports)
                if (portNamesToUpdate.Contains(modulePort.PortName))
                    modulePort.PortType = portType;
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}