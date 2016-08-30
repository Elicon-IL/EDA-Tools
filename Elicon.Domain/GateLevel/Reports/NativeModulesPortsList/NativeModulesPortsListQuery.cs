using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public interface INativeModulesPortsListQuery
    {
        IDictionary<string, string[]> GetNativeModulesPortsList(string netlist);
    }

    public class NativeModulesPortsListQuery : INativeModulesPortsListQuery
    {
        private readonly IInstanceRepository _instanceRepository;

        public NativeModulesPortsListQuery(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IDictionary<string, string[]> GetNativeModulesPortsList(string netlist)
        {
            var aggregator = new NativeModulesPortsListAggregator();

            var instances = _instanceRepository.GetBy(netlist);
            foreach (var instance in instances)
                aggregator.Collect(instance);
       
            return aggregator.Result();
        }
    }
}

