using System.Linq;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public interface IStatementHandler
    {
        void Handle(BuildState state);
    }

    public class StatementHandler : IStatementHandler
    {
        private readonly ICommandHandler[] _commandHandlers;

        public StatementHandler(ICommandHandler[] commandHandlers, ICommandHandlersOrderer commandHandlersOrderer)
        {
            _commandHandlers = commandHandlers;
            _commandHandlers = commandHandlersOrderer.Order(commandHandlers).ToArray();
        }

        public void Handle(BuildState state)
        {
            _commandHandlers.FirstOrDefault(h => h.CanHandle(state))?
                   .Handle(state);
        }
    }
}