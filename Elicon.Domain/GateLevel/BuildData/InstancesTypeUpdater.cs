using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.Domain.GateLevel.BuildData
{
    public interface IInstancesTypeUpdater
    {
        void UpdateInstancesType(string source);
    }

    public class InstancesTypeUpdater : IInstancesTypeUpdater
    {
        private readonly IInstanceRepository _instanceRepository;
        private readonly IModuleRepository _moduleRepository;

        public InstancesTypeUpdater(IInstanceRepository instanceRepository, IModuleRepository moduleRepository)
        {
            _instanceRepository = instanceRepository;
            _moduleRepository = moduleRepository;
        }

        public void UpdateInstancesType(string source)
        {
            foreach (var instance in _instanceRepository.GetBy(source))
            {
                if (!_moduleRepository.Exists(source, instance.ModuleName))
                    continue;
                
                instance.Type = InstanceType.Module;
                _instanceRepository.Update(instance);
            }
        }
    }
}