using System;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Statements.Criterias;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class ErrorStatementHandler : IStatementHandler
    {
        private readonly ErrorStatementCriteria _criteria = new ErrorStatementCriteria();
        private readonly INetlistRemover _netlistRemover;

        public ErrorStatementHandler(INetlistRemover netlistRemover)
        {
            _netlistRemover = netlistRemover;
        }

        public void Handle(BuildState state)
        {
            _netlistRemover.Remove(state.NetlistSource);
            throw new InvalidOperationException("cannot process this line {0} ".FormatWith(state.CurrentStatementTrimmed));    
        }

        public bool CanHandle(BuildState state)
        {
            return _criteria.IsSatisfied(state.CurrentStatementTrimmed);
        }
    }
}