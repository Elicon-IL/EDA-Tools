using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly INetlistFileDirector _netlistFileDirector;
        private readonly IFileTitleBuilder _fileTitleBuilder;

        public NetlistFileWriter(INetlistFileDirector netlistFileDirector, IStreamWriterProvider streamWriterProvider, IFileTitleBuilder fileTitleBuilder)
        {
            _netlistFileDirector = netlistFileDirector;
            _streamWriterProvider = streamWriterProvider;
            _fileTitleBuilder = fileTitleBuilder;
        }

        public void Write(string source, string action)
        {
            var writer = _streamWriterProvider.Get(source);

            var title = _fileTitleBuilder.BuildTitle(action);
            var content = _netlistFileDirector.Construct(source);

            writer.WriteLine(title);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}
