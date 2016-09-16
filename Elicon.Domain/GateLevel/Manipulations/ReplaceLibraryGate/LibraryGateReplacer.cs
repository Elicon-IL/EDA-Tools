using System;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceLibraryGate
{
    public interface ILibraryGateReplacer
    {
        void Replace(string netlist, string gateToReplace, string newGate, PortsMapping portsMapping);
    }

    public class LibraryGateReplacer : ILibraryGateReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceMutator _instanceMutator;

        public LibraryGateReplacer(IInstanceRepository instanceRepository, IModuleRepository moduleRepository, IInstanceMutator instanceMutator)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _instanceMutator = instanceMutator;
        }

        public void Replace(string netlist, string gateToReplace, string newGate, PortsMapping portsMapping)
        {
            if (_moduleRepository.Exists(netlist, gateToReplace))
                throw new InvalidOperationException("can replace only library gates");

            var instances = _instanceRepository.GetByModuleName(netlist, gateToReplace).ToList();

            _instanceMutator.Take(instances)
                .MutateModuleName(newGate)
                .ReplacePorts(portsMapping);

            _instanceRepository.Update(instances);    
        }
    }
}