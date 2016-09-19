using System.Text;
using Elicon.DataAccess.Files.Common.Read;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Read
{
    public class NetlistFileReaderProvider : INetlistFileReaderProvider
    {
        private readonly IStreamReaderProvider _streamReaderProvider;
        private readonly IStatementTrimmer _statementTrimmer;
        private readonly IMultiLineStatementVerifier _multiLineStatementVerifier;

        public NetlistFileReaderProvider(IStreamReaderProvider streamReaderProvider, IStatementTrimmer statementTrimmer, IMultiLineStatementVerifier multiLineStatementVerifier)
        {
            _streamReaderProvider = streamReaderProvider;
            _statementTrimmer = statementTrimmer;
            _multiLineStatementVerifier = multiLineStatementVerifier;
        }

        public INetlistFileReader GetReaderFor(string source)
        {
            var streamReader = _streamReaderProvider.Get(source);
            return new NetlistFileReader(streamReader, _statementTrimmer, _multiLineStatementVerifier);
        }

        private class NetlistFileReader : INetlistFileReader
        {
            private readonly IStreamReader _streamReader;
            private readonly IStatementTrimmer _statementTrimmer;
            private readonly IMultiLineStatementVerifier _multiLineStatementVerifier;
            private string _currentStatement;

            public NetlistFileReader(IStreamReader streamReader, IStatementTrimmer statementTrimmer, IMultiLineStatementVerifier multiLineStatementVerifier)
            {
                _streamReader = streamReader;
                _statementTrimmer = statementTrimmer;
                _multiLineStatementVerifier = multiLineStatementVerifier;
            }

            public string ReadTrimmedStatement()
            {
                if ((_currentStatement = _streamReader.ReadLine()) == null)
                    return _currentStatement;

                _currentStatement = _statementTrimmer.Trim(_currentStatement);
                if (_multiLineStatementVerifier.IsMultiLineStatement(_currentStatement))
                    ReadTillStatementEnd();

                return _currentStatement;
            }

            public void Close()
            {
                _streamReader.Close();
            }

            private void ReadTillStatementEnd()
            {
                var multiLineStatement = new StringBuilder(_currentStatement);

                while ((_currentStatement = _streamReader.ReadLine()) != null)
                {
                    _currentStatement = _statementTrimmer.Trim(_currentStatement);
                    if (_currentStatement.IsNullOrEmpty())
                        continue;

                    multiLineStatement.Append(' ').Append(_currentStatement);
                    if (!_currentStatement.EndsWith(";"))
                        continue;

                    _currentStatement = multiLineStatement.ToString();
                    break;
                }
            }
        }
    }
}