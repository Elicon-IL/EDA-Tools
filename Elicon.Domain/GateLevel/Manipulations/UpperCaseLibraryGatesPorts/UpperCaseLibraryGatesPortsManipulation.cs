using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseLibraryGatesPorts
{
    public interface IUpperCaseLibraryGatesPortsManipulation
    {
        void PortsToUpper(string sourceNetlist, string newNetlist);
    }

    public class UpperCaseLibraryGatesPortsManipulation : IUpperCaseLibraryGatesPortsManipulation
    {
        private readonly INetlistCloner _netlistCloner;
        private readonly IFileWriter _fileWriter;
        private readonly ILibraryGatesPortsReplacer _libraryGatesPortsReplacer;
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INetlistFileContentDirector _netlistFileContentDirector;
        
        public UpperCaseLibraryGatesPortsManipulation(INetlistCloner netlistCloner, IFileWriter fileWriter, ILibraryGatesPortsReplacer libraryGatesPortsReplacer, INetlistDataBuilder netlistDataBuilder, INetlistFileContentDirector netlistFileContentDirector)
        {
            _netlistCloner = netlistCloner;
            _fileWriter = fileWriter;
            _libraryGatesPortsReplacer = libraryGatesPortsReplacer;
            _netlistDataBuilder = netlistDataBuilder;
            _netlistFileContentDirector = netlistFileContentDirector;
        }

        public void PortsToUpper(string sourceNetlist, string newNetlist)
        {
            _netlistDataBuilder.Build(sourceNetlist);
            _netlistCloner.Clone(sourceNetlist, newNetlist);

            _libraryGatesPortsReplacer.PortsToUpper(newNetlist);

            var content = _netlistFileContentDirector.Construct(newNetlist);
            _fileWriter.Write(newNetlist, "Uppercase LibraryGate Module Ports", content);
        }
    }
}
