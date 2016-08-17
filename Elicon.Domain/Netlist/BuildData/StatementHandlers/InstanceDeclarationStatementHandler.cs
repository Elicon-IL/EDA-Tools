using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Parse;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class InstanceDeclarationStatementHandler : IStatementHandler
    {
        private readonly InstanceStatementParser _parser = new InstanceStatementParser();
        private readonly INetlistRepositoryProvider _netlistRepositoryProvider;

        public InstanceDeclarationStatementHandler(INetlistRepositoryProvider netlistRepositoryProvider)
        {
            _netlistRepositoryProvider = netlistRepositoryProvider;
        }

        public void Handle(BuildState state)
        {
            var instance = new Instance(_parser.GetCellName(state.CurrentStatement), _parser.GeInstanceName(state.CurrentStatement));
            _netlistRepositoryProvider
                .GetRepositoryFor(state.Netlist)
                .AddInstance(instance, state.CurrentModuleName);
        }

        public bool CanHandle(BuildState state)
        {
            return true;
        }
    }
}