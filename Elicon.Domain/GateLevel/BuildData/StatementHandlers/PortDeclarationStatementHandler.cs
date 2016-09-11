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
        private readonly IModuleMutator _moduleMutator;

        public PortDeclarationStatementHandler(IModuleRepository moduleRepository, IModuleMutator moduleMutator)
        {
            _moduleRepository = moduleRepository;
            _moduleMutator = moduleMutator;
        }

        public void Handle(BuildState state)
        {
            var portType = _parser.GetPortType(state.CurrentStatementTrimmed);
            var portNames = _parser.GetPorts(state.CurrentStatementTrimmed).Select(p => p.PortName).ToList();

            var module = _moduleRepository.Get(state.NetlistSource, state.CurrentModuleName);
            _moduleMutator.UpdatePortsType(module, portNames, portType);

            _moduleRepository.Update(module);
        }
        
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatementTrimmed);
        }
    }
}