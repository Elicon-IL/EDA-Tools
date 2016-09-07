using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.NativeModulesPortsList
{
    public interface INativeModulesPortListQuery
    {
        IList<NativeModulePorts> GetNativeModulesPortsList(string netlist);
    }

    public class NativeModulesPortListQuery : INativeModulesPortListQuery
    {
        private readonly IInstanceRepository _instanceRepository;

        public NativeModulesPortListQuery(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IList<NativeModulePorts> GetNativeModulesPortsList(string netlist)
        {
            var aggregator = new NativeModulesPortListAggregator();

            var instances = _instanceRepository.GetBy(netlist);
            foreach (var instance in instances)
                aggregator.Collect(instance);
       
            return aggregator.Result();
        }
    }
}

