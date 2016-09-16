using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseLibraryGatesPorts
{
    public interface ILibraryGatesPortsReplacer
    {
        void PortsToUpper(string netlist);
    }

    public class LibraryGatesPortsReplacer : ILibraryGatesPortsReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IInstanceMutator _instanceMutator;

        public LibraryGatesPortsReplacer(IInstanceRepository instanceRepository, IInstanceMutator instanceMutator)
        {
            _instanceRepository = instanceRepository;
            _instanceMutator = instanceMutator;
        }

        public void PortsToUpper(string netlist)
        {
            var instances = _instanceRepository.GetLibraryGateInstances(netlist).ToList();

            _instanceMutator.Take(instances).PortsToUpper();

            _instanceRepository.Update(instances);
        }
    }
}