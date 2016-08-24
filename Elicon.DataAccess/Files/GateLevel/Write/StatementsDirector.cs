using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public interface IStatementsDirector
    {
        void Construct(string source, StatementsBuilder builder);
    }

    public class StatementsDirector : IStatementsDirector
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public StatementsDirector(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public void Construct(string source, StatementsBuilder builder)
        {
            var netlist = _netlistRepository.Get(source);
            var modules = _moduleRepository.GetAll(source);

            builder.BuildMetaStatements(netlist);

            foreach (var module in modules)
            {
                builder.BuildModuleDeclaration(module);
                builder.BuildNewLine();
                builder.BuildPortDeclarations(module);
                builder.BuildSupplyDeclarations(module);
                builder.BuildAssignDeclarations(module);

                foreach (var instance in _instanceRepository.GetBy(source, module.Name))
                    builder.BuildInstanceDeclaration(instance);

                builder.BuildEndModule();
                builder.BuildNewLine();
            }
        }
    }
}