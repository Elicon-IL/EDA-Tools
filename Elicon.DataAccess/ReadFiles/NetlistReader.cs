using System.Text;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess.ReadFiles
{
    public class NetlistReader : INetlistReader
    {
        private readonly IStreamReader _streamReader;
        private readonly IStatementTrimmer _statementTrimmer;
        private readonly IMultiLineStatementVerifier _multiLineStatementVerifier;
        private string _currentStatement;

        public NetlistReader(IStreamReader streamReader, IStatementTrimmer statementTrimmer, IMultiLineStatementVerifier multiLineStatementVerifier)
        {
            _streamReader = streamReader;
            _statementTrimmer = statementTrimmer;
            _multiLineStatementVerifier = multiLineStatementVerifier;
        }

        public string ReadStatement()
        {
            if ((_currentStatement = _streamReader.ReadLine()) == null)
                return _currentStatement;

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
    }
}