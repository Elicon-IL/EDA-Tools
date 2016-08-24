using Elicon.DataAccess.Files.Common.Read;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

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
    }
}