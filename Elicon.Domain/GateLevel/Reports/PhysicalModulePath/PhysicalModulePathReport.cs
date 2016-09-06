using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.PhysicalModulePath
{
    public interface IPhysicalModulePathReport
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;
        private readonly IReportWriter _reportWriter;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalModulePathQuery physicalModulePathQuery, IReportWriter reportWriter)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalModulePathQuery = physicalModulePathQuery;
            _reportWriter = reportWriter;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames, string destination)
        {
            _netlistDataBuilder.Build(source);
          
            var result = _physicalModulePathQuery.GetPhysicalPaths(source, rootModule, moduleNames);

            _reportWriter.Write(new PhysicalModulePathReportWriteRequest
            {
                Destination = destination,
                ModulesToList = moduleNames,
                Data = result
            });

            return result;
        }
    }
}

