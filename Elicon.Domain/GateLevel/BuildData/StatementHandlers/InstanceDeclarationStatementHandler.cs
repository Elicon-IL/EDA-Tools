using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Parse;

namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public class InstanceDeclarationStatementHandler : IStatementHandler
    {
        private readonly InstanceStatementParser _parser = new InstanceStatementParser();
        private readonly IInstanceRepository _instanceRepository;

        public InstanceDeclarationStatementHandler(IInstanceRepository instanceRepository)
        {
            _instanceRepository = instanceRepository;
        }
        
        public void Handle(BuildState state)
        {
            var instance = new Instance(
                state.NetlistSource,
                state.CurrentModuleName,
                _parser.GetModuleName(state.CurrentStatement),
                _parser.GeInstanceName(state.CurrentStatement)
                ) {
                Net = _parser.GetNet(state.CurrentStatement)
            };

            _instanceRepository.AddInstance(instance);
        }

        public bool CanHandle(BuildState state)
        {
            return true;
        }
    }
}