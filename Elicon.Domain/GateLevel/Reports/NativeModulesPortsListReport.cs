using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;
using Elicon.Domain.GateLevel.QueryData.NativeModulesPortsList;

namespace Elicon.Domain.GateLevel.Reports
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

