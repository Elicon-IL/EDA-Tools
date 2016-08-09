using Elicon.Domain.Netlist.Contracts.DataAccess;
using Elicon.Domain.Netlist.Parse;

namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public class InstanceDeclarationCommandHandler : ICommandHandler
    {
        private readonly InstanceCommnadParser _parser = new InstanceCommnadParser();
        private readonly IInstanceRepository _instanceRepository;

        public InstanceDeclarationCommandHandler(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }

        public void Handle(BuildState state)
        {
            var instance = new Instance(_parser.GetCellName(state.CurrentCommand), _parser.GeInstanceName(state.CurrentCommand));
            _instanceRepository.Add(instance, state.CurrentModuleName);    
        }

        public bool CanHandle(BuildState state)
        {
            return true;
        }
    }
}