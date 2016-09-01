using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations;
using Elicon.Domain.GateLevel.Parse;
using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class PortDeclarationStatementHandler : IStatementHandler
    {
        private readonly PortDeclarationStatementCriteria _criteria = new PortDeclarationStatementCriteria();
        private readonly PortsDeclarationStatementParser _parser = new PortsDeclarationStatementParser();

        private readonly IModuleRepository _moduleRepository;
        private readonly IModulePortsTypeUpdater _modulePortsTypeUpdater;

        public PortDeclarationStatementHandler(IModuleRepository moduleRepository, IModulePortsTypeUpdater modulePortsTypeUpdater)
        {
            _moduleRepository = moduleRepository;
            _modulePortsTypeUpdater = modulePortsTypeUpdater;
        }

        public void Handle(BuildState state)
        {
            var portType = _parser.GetPortType(state.CurrentStatementTrimmed);
            var portNames = _parser.GetPorts(state.CurrentStatementTrimmed).Select(p => p.PortName).ToList();

            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);
            _modulePortsTypeUpdater.UpdatePortsType(module, portNames, portType);

            _moduleRepository.Update(module);
        }
        
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatementTrimmed);
        }
    }
}