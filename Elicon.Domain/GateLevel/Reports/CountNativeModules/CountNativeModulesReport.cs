using System.Collections.Generic;
using Elicon.Domain.GateLevel.BuildData;

namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public interface ICountNativeModulesReport
    {
        IDictionary<string, long> CountNativeModules(string source, string rootModule);
    }

    public class CountNativeModulesReport : ICountNativeModulesReport
    {
        private readonly INetlistDataBuilder _netlistDataBuilder;
        private readonly ICountNativeModulesQuery _countNativeModulesQuery;
        
        public CountNativeModulesReport(INetlistDataBuilder netlistDataBuilder, ICountNativeModulesQuery countNativeModulesQuery)
        {
            _netlistDataBuilder = netlistDataBuilder;
            _countNativeModulesQuery = countNativeModulesQuery;
        }

        public IDictionary<string, long> CountNativeModules(string source, string rootModule)
        {
            _netlistDataBuilder.Build(source);
            return _countNativeModulesQuery.CountNativeModules(source, rootModule);
        }
    }
}

