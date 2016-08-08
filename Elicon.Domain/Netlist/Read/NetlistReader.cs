using System.Text;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Read
{
    public interface INetlistReader
    {
        void SetSource(string source);
        void Close();
        string ReadCommand();
    }

    public class NetlistReader : INetlistReader
    {
        private string _currentCommand;
        private readonly IStreamReader _streamReader;
        private readonly ICommandTrimmer _commandTrimmer;
        private readonly IMultiLineCommandSelector _multiLineCommandSelector;

        public NetlistReader(IStreamReader streamReader ,ICommandTrimmer commandTrimmer, IMultiLineCommandSelector multiLineCommandSelector)
        {
            _streamReader = streamReader;
            _commandTrimmer = commandTrimmer;
            _multiLineCommandSelector = multiLineCommandSelector;
        }

        public void SetSource(string source)
        {
            _streamReader.SetSource(source);   
        }

        public void Close()
        {
            _streamReader.Close();
        }

        public string ReadCommand()
        {
            if ((_currentCommand = _streamReader.ReadLine()) == null)
                return _currentCommand;

            _currentCommand = _commandTrimmer.Trim(_currentCommand);
           if (_multiLineCommandSelector.IsMultiLineCommand(_currentCommand))
                ReadTillCommandEnd();

            return _currentCommand;
        }

        private void ReadTillCommandEnd()
        {
            var multiLineCommand = new StringBuilder(_currentCommand);

            while ((_currentCommand = _streamReader.ReadLine()) != null)
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