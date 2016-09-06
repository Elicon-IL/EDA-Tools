using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly IStreamWriterProvider _streamWriterProvider;
        private readonly INetlistFileBuilder _netlistFileBuilder;

        public NetlistFileWriter(IStreamWriterProvider streamWriterProvider, INetlistFileBuilder netlistFileBuilder)
        {
            _streamWriterProvider = streamWriterProvider;
            _netlistFileBuilder = netlistFileBuilder;
        }

        public void Write(string source, string action)
        {
            var writer = _streamWriterProvider.Get(source);

            var content = _netlistFileBuilder.Build(source, action);
            writer.WriteLine(content);

            writer.Close();
        }
    }
}
