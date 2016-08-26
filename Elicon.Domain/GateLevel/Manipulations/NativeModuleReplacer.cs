using System;
using System.Collections.Generic;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.Manipulations
{
    public interface INativeModuleReplacer
    {
        void Replace(string netlist, string currentModule, string newModule, IDictionary<string, string> portsMap);
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

        public void Replace(string netlist, string currentModule, string newModule, IDictionary<string, string> portsMap)
        {
            if (_moduleRepository.Exists(netlist, currentModule))
                throw new InvalidOperationException("cannot replace non native modules");

            foreach (var instance in _instanceRepository.GetByModuleName(netlist, currentModule))
            {
                instance.ModuleName = newModule;
                foreach (var pwp in instance.Net)
                    pwp.Port = portsMap[pwp.Port];

                _instanceRepository.Update(instance);
            }
        }
    }
}