using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;
using Elicon.Domain.Netlist.DataQuery.Visitors;

namespace Elicon.Domain.Netlist.Reports
{
    public interface ICountNativeCellsReport
    {
        IDictionary<string, long> CountNativeCells(string source);
    }

    public class CountNativeCellsReport : ICountNativeCellsReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly IModuleTraverser _moduleTraverser;
        private readonly ICountNativeCellsInstanceVisitor _countNativeCellsInstanceVisitor;
        private readonly IModuleRepository _moduleRepository;

        public CountNativeCellsReport(INetlistDataBuilder netlistDataBuilder, IModuleTraverser moduleTraverser, ICountNativeCellsInstanceVisitor countNativeCellsInstanceVisitor, IModuleRepository moduleRepository)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _moduleTraverser = moduleTraverser;
            _countNativeCellsInstanceVisitor = countNativeCellsInstanceVisitor;
            _moduleRepository = moduleRepository;
        }

        public IDictionary<string, long> CountNativeCells(string source)
        {
            _netlistDataBuilder.Build(source);
            var top = _moduleRepository.GetTop();
            _moduleTraverser.Traverse(top.Name, _countNativeCellsInstanceVisitor);

            return _countNativeCellsInstanceVisitor.Result();
        }
    }
}

