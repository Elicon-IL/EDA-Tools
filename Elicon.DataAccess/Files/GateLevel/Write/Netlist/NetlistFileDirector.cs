using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileContentDirector : INetlistFileContentDirector
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;

        public NetlistFileContentDirector(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
        }

        public string Construct(string source)
        {
            var builder = new NetlistFileBuilder();
            var netlist = _netlistRepository.Get(source);
            var modules = _moduleRepository.GetAll(netlist.Source);

            builder.BuildMetaStatements(netlist);

            foreach (var module in modules)
            {
                builder.BuildModuleDeclaration(module);
                builder.BuildNewLine();
                builder.BuildModulePortDeclarations(module);
                builder.BuildSupplyDeclarations(module);
               
                foreach (var instance in _instanceRepository.GetByHostModule(netlist.Source, module.Name))
                    builder.BuildInstanceDeclaration(instance);

                builder.BuildNewLine();
                builder.BuildEndModule();
                builder.BuildNewLine();
            }

            return builder.GetResult();
        }
    }
}

