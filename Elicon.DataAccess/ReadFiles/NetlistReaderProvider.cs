using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess.ReadFiles
{
    public class NetlistReaderProvider : INetlistReaderProvider
    {
        private readonly IStreamReaderProvider _streamReaderProvider;
        private readonly IStatementTrimmer _statementTrimmer;
        private readonly IMultiLineStatementVerifier _multiLineStatementVerifier;

        public NetlistReaderProvider(IStreamReaderProvider streamReaderProvider, IStatementTrimmer statementTrimmer, IMultiLineStatementVerifier multiLineStatementVerifier)
        {
            _streamReaderProvider = streamReaderProvider;
            _statementTrimmer = statementTrimmer;
            _multiLineStatementVerifier = multiLineStatementVerifier;
        }

        public INetlistReader GetReaderFor(string source)
        {
            var streamReader = _streamReaderProvider.Get(source);
            return new NetlistReader(streamReader, _statementTrimmer, _multiLineStatementVerifier);
        }
    }
}