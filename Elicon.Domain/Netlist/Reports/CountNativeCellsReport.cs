using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.QueryData;

namespace Elicon.Domain.Netlist.Reports
{
    public interface ICountNativeCellsReport
    {
        IDictionary<string, long> CountNativeCells(string source, string rootModule);
    }

    public class CountNativeCellsReport : ICountNativeCellsReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountNativeCellsQuery _countNativeCellsQuery;
        
        public CountNativeCellsReport(INetlistDataBuilder netlistDataBuilder, ICountNativeCellsQuery countNativeCellsQuery)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countNativeCellsQuery = countNativeCellsQuery;
        }

        public IDictionary<string, long> CountNativeCells(string source, string rootModule)
        {
            _netlistDataBuilder.Build(source);
            return _countNativeCellsQuery.CountNativeCells(rootModule);
        }
    }
}

