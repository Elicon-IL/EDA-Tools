using Elicon.Domain.GateLevel.Statements.Criterias;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class EndModuleStatementHandler : IStatementHandler
    {
        private readonly EndModuleStatementCriteria _criteria = new EndModuleStatementCriteria();

        public void Handle(BuildState state)
        {
            state.CurrentModuleName = "";
        }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}