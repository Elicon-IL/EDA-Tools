using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess
{
    public class ModuleRepository : IModuleRepository
    {
        private readonly Dictionary<string, Module> _map = new Dictionary<string, Module>();
        
        public void Add(Module module)
        {
            _map.Add(module.Name, module);
        }

        public Module Get(string moduleName)
        {
            Module result;

            _map.TryGetValue(moduleName, out result);

            return result;
        }

        public IEnumerable<Module> GetAll()
        {
            return _map.Values.ToArray();
        }

        public void Dispose()
        {
            _map.Clear();
        }
    }
}