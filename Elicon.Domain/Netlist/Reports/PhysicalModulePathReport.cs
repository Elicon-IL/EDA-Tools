using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;

namespace Elicon.Domain.Netlist.Reports
{
    public interface IPhysicalModulePathReport
    {
        IDictionary<string, IList<string>> Query(string source, IList<string> moduleNames);
    }
        
    public class PhysicalModulePathReport : IPhysicalModulePathReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IPhysicalModulePathQuery _physicalModulePathQuery;
        private readonly IModuleRepository _moduleRepository;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IModuleRepository moduleRepository, IPhysicalModulePathQuery physicalModulePathQuery)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _moduleRepository = moduleRepository;
            _physicalModulePathQuery = physicalModulePathQuery;
        }

        public IDictionary<string, IList<string>> Query(string source, IList<string> moduleNames)
        {
            _netlistDataBuilder.Build(source);
            var top = _moduleRepository.GetTop();
            return _physicalModulePathQuery.Query(top.Name, moduleNames);
        }
    }
}

