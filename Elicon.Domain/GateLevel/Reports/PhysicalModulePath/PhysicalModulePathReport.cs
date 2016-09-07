using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public interface IPhysicalModulePathReport
    {
        IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;
        private readonly IFileWriter _fileWriter;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalModulePathQuery physicalModulePathQuery, IFileWriter fileWriter)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalModulePathQuery = physicalModulePathQuery;
            _fileWriter = fileWriter;
        }

        public IList<ModulePhysiclaPaths> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination)
        {
            _netlistDataBuilder.Build(source);
          
            var result = _physicalModulePathQuery.GetPhysicalPaths(source, rootModule, moduleNames);

            _fileWriter.Write(new PhysicalModulePathFileWriteRequest {
                Destination = destination,
                ModulesToList = moduleNames,
                Data = result
            });

            return result;
        }
    }
}

