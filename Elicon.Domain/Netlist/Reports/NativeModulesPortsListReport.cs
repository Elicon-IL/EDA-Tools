using System.Collections.Generic;
using Elicon.Domain.Netlist.BuildData;
using Elicon.Domain.Netlist.QueryData.NativeModulesPortsList;

namespace Elicon.Domain.Netlist.Reports
{
    public interface INativeModulesPortsListReport
    {
        IDictionary<string, string[]> GetNativeModulesPortsList(string source);
    }

    public class NativeModulesPortsListReport : INativeModulesPortsListReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly INativeModulesPortsListQuery _nativeModulesPortsListQuery;

        public NativeModulesPortsListReport(INativeModulesPortsListQuery nativeModulesPortsListQuery, INetlistDataBuilder netlistDataBuilder)
        {
            _nativeModulesPortsListQuery = nativeModulesPortsListQuery;
            _netlistDataBuilder = netlistDataBuilder;
        }

        public IDictionary<string, string[]> GetNativeModulesPortsList(string source)
        {
            _netlistDataBuilder.Build(source);
            return _nativeModulesPortsListQuery.GetNativeModulesPortsList(source);
        }
    }
}

