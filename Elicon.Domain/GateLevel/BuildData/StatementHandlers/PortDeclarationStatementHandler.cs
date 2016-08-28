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
            var ports = _parser.GetPorts(state.CurrentStatement);
            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);

            SetModulePortsType(module, ports, portType);

            _moduleRepository.Update(module);
        }

        private static void SetModulePortsType(Module module, IList<Port> ports, PortType portType)
        {
            module.Ports = module.Ports.Join(ports,
                p => p.PortName,
                p => p.PortName,
                (p1, p2) => {
                    p1.PortType = portType;
                    return p1;
                })
                .ToList();
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}