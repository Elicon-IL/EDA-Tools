using System.Collections.Generic;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.Domain.Netlist.DataQuery
{
    public interface IPhysicalModulePathQuery
    {
        IDictionary<string, IList<string>> Query(string hostModule, IList<string> moduleNames);
    }

    public class PhysicalModulePathQuery : IPhysicalModulePathQuery
    {
        private readonly IInstanceRepository _instanceRepository;

        public PhysicalModulePathQuery(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public IDictionary<string, IList<string>> Query(string hostModule, IList<string> moduleNames)
        {
            var result = new Dictionary<string, IList<string>>();
            foreach (var moduleName in moduleNames)
                result.Add(moduleName, new List<string>());
            
            var currentPath="";
            QueryPathsIn(hostModule, currentPath, result, moduleNames);
            
            return result;
        }

        private void QueryPathsIn(string hostModule ,string currentPath, Dictionary<string, IList<string>> result, IList<string> moduleNames)
        {
            var instances = _instanceRepository.GetByModule(hostModule);

            foreach (var instance in instances)
            {
                if (moduleNames.Contains(instance.CellName))
                    result[instance.CellName].Add(currentPath + ", "+ instance.InstanceName);
                if (instance.IsModule)
                    QueryPathsIn(instance.CellName, currentPath + ", " + instance.InstanceName, result, moduleNames);
            }
        }
    }
}