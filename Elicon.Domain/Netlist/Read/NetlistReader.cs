using System.IO;
using System.Text;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Read
{
    public interface INetlistReader
    {
        void SetSource(string source);
        void Colse();
        string ReadCommand();
    }

    public class NetlistReader : INetlistReader
    {
        private string _currentCommand;
        private StreamReader _reader;
        private readonly ICommandTrimmer _commandTrimmer;
        private readonly IMultiLineCommandSelector _multiLineCommandSelector;

        public NetlistReader(ICommandTrimmer commandTrimmer, IMultiLineCommandSelector multiLineCommandSelector)
        {
            _commandTrimmer = commandTrimmer;
            _multiLineCommandSelector = multiLineCommandSelector;
        }

        public void SetSource(string source)
        {
            _reader = new StreamReader(source);    
        }

        public void Colse()
        {
            _reader.Close();
        }

        public string ReadCommand()
        {
            if ((_currentCommand = _reader.ReadLine()) == null)
                return _currentCommand;

            _currentCommand = _commandTrimmer.Trim(_currentCommand);
           if (_multiLineCommandSelector.IsMultiLineCommand(_currentCommand))
                ReadTillCommandEnd();

            return _currentCommand;
        }

        private void ReadTillCommandEnd()
        {
            var multiLineCommand = new StringBuilder(_currentCommand);

            while ((_currentCommand = _reader.ReadLine()) != null)
            {
                _currentCommand = _commandTrimmer.Trim(_currentCommand);
                if (_currentCommand.IsNullOrEmpty())
                    continue;

                multiLineCommand.Append(' ');
                multiLineCommand.Append(_currentCommand);
                if (!_currentCommand.EndsWith(";"))
                    continue;

                _currentCommand = multiLineCommand.ToString();
                break;
            }    
        }
    }
}