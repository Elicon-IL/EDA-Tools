using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;
using Elicon.Domain.Netlist.DataQuery.Traversal;
using Elicon.Domain.Netlist.DataQuery.Visitors;

namespace Elicon.Domain.Netlist.Reports
{
    public interface IPhysicalModulePathReport
    {
        IDictionary<string, IList<string>> GetPhysicalPaths(string source, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;
        private readonly IModuleRepository _moduleRepository;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalModulePathQuery physicalModulePathQuery, IModuleRepository moduleRepository)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalModulePathQuery = physicalModulePathQuery;
            _moduleRepository = moduleRepository;
        }

        public IDictionary<string, IList<string>> GetPhysicalPaths(string source, IList<string> moduleNames)
        {
            _netlistDataBuilder.Build(source);
            var top = _moduleRepository.GetTopModule();

            return _physicalModulePathQuery.GetPhysicalPaths(top.Name, moduleNames);
        }
    }
}

