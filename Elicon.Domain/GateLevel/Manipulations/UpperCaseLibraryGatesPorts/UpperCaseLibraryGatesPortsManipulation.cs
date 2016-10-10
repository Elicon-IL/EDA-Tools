using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseLibraryGatesPorts
{
    public interface IUpperCaseLibraryGatesPortsManipulation
    {
        void PortsToUpper(UpperCasePortsRequest request);
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

        public void PortsToUpper(UpperCasePortsRequest request)
        {
            _netlistDataBuilder.Build(request.SourceNetlist);
            _netlistCloner.Clone(request.SourceNetlist, request.TargetNetlist);
         
            _libraryGatesPortsReplacer.PortsToUpper(request.TargetNetlist);

            var content = _netlistFileContentDirector.Construct(request.TargetNetlist);
            _fileWriter.Write(request.TargetNetlist, "Uppercase Library Gates Ports", content);
        }
    }
}
