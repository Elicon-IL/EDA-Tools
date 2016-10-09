using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceLibraryGate
{
    public interface ILibraryGateReplaceManipulation
    {
        void Replace(LibraryGateReplaceRequest replaceRequest);
    }

    public class LibraryGateReplaceManipulation : ILibraryGateReplaceManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly ILibraryGateReplacer _libraryGateReplacer;
        private readonly IFileWriter _fileWriter;
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INetlistFileContentDirector _netlistFileContentDirector;

        public LibraryGateReplaceManipulation(INetlistCloner netlistCloner, ILibraryGateReplacer libraryGateReplacer, IFileWriter fileWriter, INetlistDataBuilder netlistDataBuilder, INetlistFileContentDirector netlistFileContentDirector)
        {
            _netlistCloner = netlistCloner;
            _libraryGateReplacer = libraryGateReplacer;
            _fileWriter = fileWriter;
            _netlistDataBuilder = netlistDataBuilder;
            _netlistFileContentDirector = netlistFileContentDirector;
        }

        public void Replace(LibraryGateReplaceRequest replaceRequest)
        {
            _netlistDataBuilder.Build(replaceRequest.Netlist);
            _netlistCloner.Clone(replaceRequest.Netlist, replaceRequest.NewNetlist);

            _libraryGateReplacer.Replace(replaceRequest.NewNetlist, replaceRequest.GateToReplace, replaceRequest.NewGate, replaceRequest.PortsMapping);

            var content = _netlistFileContentDirector.Construct(replaceRequest.NewNetlist);
            _fileWriter.Write(replaceRequest.NewNetlist, "Replace Library Gates Modules", content);
        }
    }
}
