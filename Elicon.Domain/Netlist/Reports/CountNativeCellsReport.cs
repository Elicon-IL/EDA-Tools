using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.DataQuery;

namespace Elicon.Domain.Netlist.Reports
{
    public interface ICountNativeCellsReport
    {
        IDictionary<string, long> CountNativeCells(string source);
    }

    public class CountNativeCellsReport : ICountNativeCellsReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountNativeCellsQuery _countNativeCellsQuery;
        private readonly IModuleRepository _moduleRepository;

        public CountNativeCellsReport(INetlistDataBuilder netlistDataBuilder, ICountNativeCellsQuery countNativeCellsQuery, IModuleRepository moduleRepository)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countNativeCellsQuery = countNativeCellsQuery;
            _moduleRepository = moduleRepository;
        }


        public IDictionary<string, long> CountNativeCells(string source)
        {
            _netlistDataBuilder.Build(source);
            var topModule = _moduleRepository.GetTopModule();

            return _countNativeCellsQuery.CountNativeCells(topModule.Name);
        }
    }
}

