using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public interface IPhysicalModulePathFileContentDirector
    {
        string Construct(IList<string> modulesToList, IList<ModulePhysiclaPaths> data);
    }

    public interface IPhysicalModulePathReport
    {
        IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;
        private readonly IPhysicalModulePathFileContentDirector _physicalModulePathFileContentDirector;
        private readonly IFileWriter _fileWriter;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalModulePathQuery physicalModulePathQuery, IFileWriter fileWriter, IPhysicalModulePathFileContentDirector physicalModulePathFileContentDirector)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalModulePathQuery = physicalModulePathQuery;
            _fileWriter = fileWriter;
            _physicalModulePathFileContentDirector = physicalModulePathFileContentDirector;
        }

        public IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination)
        {
            _netlistDataBuilder.Build(source);
          
            var result = _physicalModulePathQuery.GetPhysicalPaths(source, rootModule, moduleNames);

            var content = _physicalModulePathFileContentDirector.Construct(moduleNames, result);
            _fileWriter.Write(destination, "List Phyisical Paths", content);

            return result;
        }
    }
}

