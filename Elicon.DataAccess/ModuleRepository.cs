using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;

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

        public void AddModule(Module module)
        {
            module.Id = _idGenerator.GenerateId();
            _modules.Add(module.Id, module);
        }

        public bool Exists(string netlist, string moduleName)
        {
            return _modules.Values
                .Any(m => m.Netlist == netlist && m.Name == moduleName);
        }
    }
}