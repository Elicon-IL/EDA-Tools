using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.QueryData.PhysicalModulePath;

namespace Elicon.Domain.GateLevel.Reports
{
    public interface IPhysicalModulePathReport
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalModulePathQuery physicalModulePathQuery)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalModulePathQuery = physicalModulePathQuery;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string source, string rootModule, IList<string> moduleNames)
        {
            _netlistDataBuilder.Build(source);
          
            return _physicalModulePathQuery.GetPhysicalPaths(source, rootModule, moduleNames);
        }
    }
}

