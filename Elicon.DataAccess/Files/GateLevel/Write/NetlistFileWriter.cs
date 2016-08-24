using Elicon.DataAccess.Files.Common.Write;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly IStatementsDirector _statementsDirector;

        public NetlistFileWriter(IStatementsDirector statementsDirector, IStreamWriterProvider streamWriterProvider)
        {
            _statementsDirector = statementsDirector;
            _streamWriterProvider = streamWriterProvider;
        }

        public void Write(string source)
        {
            var writer = _streamWriterProvider.Get(source);
            var statementsBuilder = new StatementsBuilder();

            _statementsDirector.Construct(source, statementsBuilder);
            writer.WriteLine(statementsBuilder.GetResult());
            writer.Close();
        }
    }

    public interface INetlistFileWriter
    {
        void Write(string source);
    }
}
