using System.Text;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Read
{
    public interface INetlistReader
    {
        void SetSource(string source);
        void Close();
        string ReadStatement();
    }

    public class NetlistReader : INetlistReader
    {
        private string _currentStatement;
        private readonly IStreamReader _streamReader;
        private readonly IStatementTrimmer _statementTrimmer;
        private readonly IMultiLineStatementVerifier _multiLineStatementVerifier;
        private readonly INetlistReadProgressUpdater _netlistReadProgressUpdater;

        public NetlistReader(IStreamReader streamReader ,IStatementTrimmer statementTrimmer, IMultiLineStatementVerifier multiLineStatementVerifier,  INetlistReadProgressUpdater netlistReadProgressUpdater)
        {
            _streamReader = streamReader;
            _statementTrimmer = statementTrimmer;
            _multiLineStatementVerifier = multiLineStatementVerifier;
            _netlistReadProgressUpdater = netlistReadProgressUpdater;
        }

        public void SetSource(string source)
        {
            _streamReader.SetSource(source);
        }

        public void Close()
        {
            _streamReader.Close();
            _netlistReadProgressUpdater.Done(_streamReader.Source());
        }

        public string ReadStatement()
        {
            if ((_currentStatement = _streamReader.ReadLine()) == null)
                return _currentStatement;
            
            UpdateProgress();

            _currentStatement = _statementTrimmer.Trim(_currentStatement);
            if (_multiLineStatementVerifier.IsMultiLineStatement(_currentStatement))
                ReadTillStatementEnd();

            return _currentStatement;
        }

        private void ReadTillStatementEnd()
        {
            var multiLineStatement = new StringBuilder(_currentStatement);

            while ((_currentStatement = _streamReader.ReadLine()) != null)
            {
                UpdateProgress();

                _currentStatement = _statementTrimmer.Trim(_currentStatement);
                if (_currentStatement.IsNullOrEmpty())
                    continue;

                multiLineStatement.Append(' ');
                multiLineStatement.Append(_currentStatement);
                if (!_currentStatement.EndsWith(";"))
                    continue;

                _currentStatement = multiLineStatement.ToString();
                break;
            }    
        }

        private void UpdateProgress()
        {
            _netlistReadProgressUpdater.Update(
                _streamReader.Source(), 
                _streamReader.Length(),
                _streamReader.Position());
        }
    }
}