using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.UpperCaseNativeModulePorts
{
    public interface INativeModulePortsReplacer
    {
        void PortsToUpper(string netlist);
    }

    public class NativeModulePortsReplacer : INativeModulePortsReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IInstanceMutator _instanceMutator;

        public NativeModulePortsReplacer(IInstanceRepository instanceRepository, IInstanceMutator instanceMutator)
        {
            _instanceRepository = instanceRepository;
            _instanceMutator = instanceMutator;
        }

        public void PortsToUpper(string netlist)
        {
            var instances = _instanceRepository.GetNativeInstances(netlist).ToList();

            _instanceMutator.Take(instances).PortsToUpper();

            _instanceRepository.Update(instances);
        }
    }
}