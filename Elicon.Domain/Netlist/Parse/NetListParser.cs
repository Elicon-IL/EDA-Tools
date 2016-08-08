using Elicon.Domain.Netlist.Commands;
using Elicon.Domain.Netlist.Parse.Helpers;
using Elicon.Domain.Netlist.Read;

namespace Elicon.Domain.Netlist.Parse
{
    public interface INetlistParser
    {
        void SetSource(string source);
        void Advance();
        bool HasMoreCommands { get; set; }
        CommandType CurrentCommandType { get; set; }
        string GetModuleName();
        string GetTopModuleName();
        string GetCellName();
        string GeInstanceName();
    }

    public class NetlistParser : INetlistParser
    {
        private string _currentCommand;

        private readonly INetlistReader _netlistReader;

        private readonly DefineTopCommandParser _defineTopCommandParser = new DefineTopCommandParser();
        private readonly ModuleInstantiationCommandParser _moduleInstantiationCommandParser = new ModuleInstantiationCommandParser();
        private readonly InstanceCommnadParser _instanceCommnadParser = new InstanceCommnadParser();
        private readonly ICommandTypeSelector _commandTypeSelector;

        public NetlistParser(INetlistReader netlistReader, ICommandTypeSelector commandTypeSelector)
        {
            _netlistReader = netlistReader;
            _commandTypeSelector = commandTypeSelector;
            HasMoreCommands = true;
        }

        public void SetSource(string source)
        {
            _netlistReader.SetSource(source);
        }

        public bool HasMoreCommands { get; set; }
        public CommandType CurrentCommandType { get;  set; }

        public void Advance()
        {
            if ((_currentCommand = _netlistReader.ReadCommand()) != null)
                CurrentCommandType = _commandTypeSelector.Select(_currentCommand);
            else
            {
                HasMoreCommands = false;
                _netlistReader.Close();
            }     
        }

        public string GetModuleName()
        {
            return _moduleInstantiationCommandParser.GetModuleName(_currentCommand);
        }

        public string GetTopModuleName()
        {
            return _defineTopCommandParser.GetTopModuleName(_currentCommand);
        }

        public string GetCellName()
        {
            return _instanceCommnadParser.GetCellName(_currentCommand);
        }

        public string GeInstanceName()
        {
            return _instanceCommnadParser.GeInstanceName(_currentCommand);
        }
    }
}
