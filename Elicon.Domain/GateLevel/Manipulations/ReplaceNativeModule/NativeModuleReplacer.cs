using System;
using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule
{
    public interface INativeModuleReplacer
    {
        void Replace(string netlist, string moduleToReplace, string newModule, IDictionary<string, string> portsMap);
    }

    public class NativeModuleReplacer : INativeModuleReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstancePortsReplacer _instancePortsReplacer;

        public NativeModuleReplacer(IInstanceRepository instanceRepository, IModuleRepository moduleRepository, IInstancePortsReplacer instancePortsReplacer)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
            _instancePortsReplacer = instancePortsReplacer;
        }

        public void Replace(string netlist, string moduleToReplace, string newModule, IDictionary<string, string> portsMap)
        {
            if (_moduleRepository.Exists(netlist, moduleToReplace))
                throw new InvalidOperationException("cannot replace non native modules");

            foreach (var instance in _instanceRepository.GetByModuleName(netlist, moduleToReplace))
            {
                instance.ModuleName = newModule;
                _instancePortsReplacer.ReplacePorts(instance, portsMap);
                
                _instanceRepository.Update(instance);
            }
        }
    }
}