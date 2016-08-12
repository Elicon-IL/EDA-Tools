using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;
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
        private readonly IPhysicalPathInstanceVisitor _physicalPathInstanceVisitor;
        private readonly IModuleTraverser _moduleTraverser;
        private readonly IModuleRepository _moduleRepository;

        public PhysicalModulePathReport(INetlistDataBuilder netlistDataBuilder, IPhysicalPathInstanceVisitor physicalPathInstanceVisitor, IModuleTraverser moduleTraverser, IModuleRepository moduleRepository)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _physicalPathInstanceVisitor = physicalPathInstanceVisitor;
            _moduleTraverser = moduleTraverser;
            _moduleRepository = moduleRepository;
        }
        
        public IDictionary<string, IList<string>> GetPhysicalPaths(string source, IList<string> moduleNames)
        {
            _netlistDataBuilder.Build(source);
            var top = _moduleRepository.GetTop();
            _physicalPathInstanceVisitor.SetModulesToTrack(moduleNames);
            _moduleTraverser.Traverse(top.Name, _physicalPathInstanceVisitor);

            return _physicalPathInstanceVisitor.Result();
        }
    }
}

