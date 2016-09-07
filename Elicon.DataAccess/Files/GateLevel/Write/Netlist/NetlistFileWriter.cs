using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly INetlistFileDirector _netlistFileDirector;
        private readonly IFileHeaderBuilder _fileHeaderBuilder;

        public NetlistFileWriter(INetlistFileDirector netlistFileDirector, IStreamWriterProvider streamWriterProvider, IFileHeaderBuilder fileHeaderBuilder)
        {
            _netlistFileDirector = netlistFileDirector;
            _streamWriterProvider = streamWriterProvider;
            _fileHeaderBuilder = fileHeaderBuilder;
        }

        public void Write(string source, string action)
        {
            var writer = _streamWriterProvider.Get(source);

            var header = _fileHeaderBuilder.BuildHeader(action);
            var content = _netlistFileDirector.Construct(source);

            writer.WriteLine(header);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}
