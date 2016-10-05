using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Reports.ListLibraryGates
{
    public interface IListLibraryGatesQuery
    {
        IList<LibraryGate> GetLibraryGates(string netlist);
    }

    public class ListLibraryGatesQuery : IListLibraryGatesQuery
    {
        private readonly IInstanceRepository _instanceRepository;

        public ListLibraryGatesQuery(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IList<LibraryGate> GetLibraryGates(string netlist)
        {
            var aggregator = new ListLibraryGatesAggregator();

            var instances = _instanceRepository.GetLibraryGateInstances(netlist);
            foreach (var instance in instances)
                aggregator.Collect(instance);
       
            return aggregator.Result();
        }
    }
}

