using System;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule
{
    public interface INativeModuleReplacer
    {
        void Replace(string netlist, string moduleToReplace, string newModule, PortsMapping portsMapping);
    }

    public class NativeModuleReplacer : INativeModuleReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceMutator _instanceMutator;

        public NativeModuleReplacer(IInstanceRepository instanceRepository, IModuleRepository moduleRepository, IInstanceMutator instanceMutator)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _instanceMutator = instanceMutator;
        }

        public void Replace(string netlist, string moduleToReplace, string newModule, PortsMapping portsMapping)
        {
            if (_moduleRepository.Exists(netlist, moduleToReplace))
                throw new InvalidOperationException("cannot replace non native modules");

            var instances = _instanceRepository.GetByModuleName(netlist, moduleToReplace).ToList();

            _instanceMutator.Take(instances)
                .MutateModuleName(newModule)
                .ReplacePorts(portsMapping);

            _instanceRepository.Update(instances);    
        }
    }
}