using System.Linq;

namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public interface IStatementHandlingInvoker
    {
        void Handle(BuildState state);
    }

    public class StatementHandlingInvoker : IStatementHandlingInvoker
    {
        private readonly IStatementHandler[] _statementHandlers;

        public StatementHandlingInvoker(IStatementHandler[] statementHandlers, IStatementHandlersOrderer statementHandlersOrderer)
        {
            _statementHandlers = statementHandlers;
            _statementHandlers = statementHandlersOrderer.Order(statementHandlers).ToArray();
        }

        public void Handle(BuildState state)
        {
            _statementHandlers.FirstOrDefault(h => h.CanHandle(state))?
                   .Handle(state);
        }
    }
}