using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Manipulations.RemoveBuffer
{
    public interface IOpenOutputModuleRemover
    {
        void Remove(string netlist, string moduleName, string outputPort);
    }

    public class OpenOutputModuleRemover : IOpenOutputModuleRemover
    {
        private readonly IInstanceRepository _instanceRepository;

        public OpenOutputModuleRemover(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public void Remove(string netlist, string moduleName, string outputPort)
        {
            var instances = _instanceRepository.GetByModuleName(netlist, moduleName);
            foreach (var instance in instances)
                if (instance.GetWire(outputPort).IsNullOrEmpty())
                    _instanceRepository.Remove(instance);
        }
    }
}