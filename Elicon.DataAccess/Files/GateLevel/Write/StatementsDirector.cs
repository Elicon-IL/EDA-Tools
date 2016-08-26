using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public interface IStatementDirector
    {
        void Construct(string source, IStatementBuilder builder);
    }

    public class StatementDirector : IStatementDirector
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public StatementDirector(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public void Construct(string source, IStatementBuilder builder)
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

                foreach (var instance in _instanceRepository.GetByHostModule(source, module.Name))
                    builder.BuildInstanceDeclaration(instance);

                builder.BuildEndModule();
                builder.BuildNewLine();
            }
        }
    }
}