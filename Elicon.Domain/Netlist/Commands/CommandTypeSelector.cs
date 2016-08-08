using System.Linq;
using Elicon.Domain.Netlist.Commands.Criterias;

namespace Elicon.Domain.Netlist.Commands
{
    public interface ICommandTypeSelector
    {
        CommandType Select(string command);
    }

    public class CommandTypeSelector : ICommandTypeSelector
    {
        private readonly ICommandCriteria[] _commandCriterias;

        public CommandTypeSelector(ICommandCriteria[] commandCommandCriterias)
        {
            _commandCriterias = commandCommandCriterias;

        }
        public CommandType Select(string command)
        {
            var commandCriteria = _commandCriterias.FirstOrDefault(c => c.IsSatisfied(command));

            if (commandCriteria == null)
                return CommandType.Instance;

            return commandCriteria.CommandType;
        }
    }
}