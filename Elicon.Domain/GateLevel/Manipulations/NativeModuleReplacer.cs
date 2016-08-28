using System;
using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface INativeModuleReplacer
    {
        void Replace(string netlist, string moduleToReplace, string newModule, IDictionary<string, string> portsMap);
    }

    public class NativeModuleReplacer : INativeModuleReplacer
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;

        public NativeModuleReplacer(IInstanceRepository instanceRepository, IModuleRepository moduleRepository)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
        }

        public void Replace(string netlist, string moduleToReplace, string newModule, IDictionary<string, string> portsMap)
        {
            if (_moduleRepository.Exists(netlist, moduleToReplace))
                throw new InvalidOperationException("cannot replace non native modules");

            foreach (var instance in _instanceRepository.GetByModuleName(netlist, moduleToReplace))
            {
                instance.ModuleName = newModule;
                foreach (var pwp in instance.Net)
                    if (portsMap.ContainsKey(pwp.Port))
                        pwp.Port = portsMap[pwp.Port];
                
                _instanceRepository.Update(instance);
            }
        }
    }
}