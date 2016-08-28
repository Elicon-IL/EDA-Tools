using System.Collections.Generic;
using System.IO;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class ModuleRepository : IModuleRepository
    {
        private readonly Dictionary<long, Module> _modules = new Dictionary<long, Module>();
        private readonly IIdGenerator _idGenerator;

        public ModuleRepository(IIdGenerator idGenerator)
        {
            _idGenerator = idGenerator;
        }

        public void Add(Module module)
        {
            module.Id = _idGenerator.GenerateId();
            _modules.Add(module.Id, new Module(module));
        }

        public void Update(Module module)
        {
            _modules[module.Id] = new Module(module);
        }

        public bool Exists(string netlist, string moduleName)
        {
            return _modules.Values
                .Any(m => m.Netlist == netlist && m.Name == moduleName);
        }

        public Module Get(string netlist, string moduleName)
        {
            var result = _modules.Values
             .Single(m => m.Netlist == netlist && m.Name == moduleName);

            return new Module(result);
        }

        public IEnumerable<Module> GetAll(string netlist)
        {
            return _modules.Values
                .Where(m => m.Netlist == netlist)
                .Select(m => new Module(m))
                .ToList();
        }

        public void RemoveAll(string netlist)
        {
            foreach (var module in GetAll(netlist))
                _modules.Remove(module.Id);
        }
    }
}