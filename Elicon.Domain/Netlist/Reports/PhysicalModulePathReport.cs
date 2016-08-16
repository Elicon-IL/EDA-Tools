using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.QueryData.PhysicalModulePath;

namespace Elicon.Domain.Netlist.Reports
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
          
            return _physicalModulePathQuery.GetPhysicalPaths(rootModule, moduleNames);
        }
    }
}

