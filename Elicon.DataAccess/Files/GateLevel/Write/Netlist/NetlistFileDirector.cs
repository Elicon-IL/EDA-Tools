using Elicon.Domain.GateLevel.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public interface INetlistFileDirector
    {
        string Construct(string source);
    }

    public class NetlistFileDirector : INetlistFileDirector
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public NetlistFileDirector(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public string Construct(string source)
        {
            var builder = new NetlistFileBuilder();
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

            return builder.GetResult();
        }
    }
}

