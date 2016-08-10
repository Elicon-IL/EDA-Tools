using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public class ErrorStatementHandler : IStatementHandler
    {
        private readonly ErrorStatementCriteria _criteria = new ErrorStatementCriteria();

        public void Handle(BuildState state) { }
        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatement);
        }
    }
}