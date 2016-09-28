using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.DataAccess
{
    public class ModuleRepository : IModuleRepository
    {
        private readonly Dictionary<long, Module> _modules = new Dictionary<long, Module>();
        private readonly Dictionary<string, List<string>> _moduleNameToNetlistMap = new Dictionary<string, List<string>>();
        private readonly IIdGenerator _idGenerator;

        public ModuleRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Module module)
        {
            module.Id = _idGenerator.GenerateId();
            _modules.Add(module.Id, new Module(module));
            _moduleNameToNetlistMap.ValueOrNew(module.Name).Add(module.Netlist);
        }

        public void Update(Module module)
        {
            if (module.Name != _modules[module.Id].Name)
                throw new InvalidOperationException("Module object name field is not updateble.");

            _modules[module.Id] = new Module(module);
        }

        public bool Exists(string netlist, string moduleName)
        {
            return _moduleNameToNetlistMap.ValueOrNew(moduleName).Contains(netlist);
        }

        public Module Get(string netlist, string moduleName)
        {
            var result = _modules.Values
             .Single(m => m.Netlist == netlist && m.Name == moduleName);

            return new Module(result);
        }

        public IList<Module> GetMany(string netlist, IList<string> moduleNames)
        {
            return _modules.Values
                  .Where(m => m.Netlist == netlist  && moduleNames.Contains(m.Name))
                  .Select(m => new Module(m))
                  .ToList();
        }

        public IList<Module> GetAll(string netlist)
        {
            return _modules.Values
                .Where(m => m.Netlist == netlist)
                .Select(m => new Module(m))
                .ToList();
        }

        public void RemoveAll(string netlist)
        {
            foreach (var module in GetAll(netlist))
            {
                _modules.Remove(module.Id);
                _moduleNameToNetlistMap.ValueOrNew(module.Name).Remove(module.Netlist);
            }
        }
    }
}