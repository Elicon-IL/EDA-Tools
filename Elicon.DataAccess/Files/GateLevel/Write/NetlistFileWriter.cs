using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IStatementDirector _statementDirector;

        public NetlistFileWriter(IStatementDirector statementDirector, IStreamWriterProvider streamWriterProvider)
        {
            _statementDirector = statementDirector;
            _streamWriterProvider = streamWriterProvider;
        }

        public void Write(string source)
        {
            var writer = _streamWriterProvider.Get(source);
            var statementsBuilder = new StatementsBuilder();

            _statementDirector.Construct(source, statementsBuilder);
            writer.WriteLine(statementsBuilder.GetResult());
            writer.Close();
        }
    }
}
