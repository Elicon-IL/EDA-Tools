using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations;

namespace Elicon.DataAccess.Files.GateLevel.Write.Netlist
{
    public class NetlistFileContentDirector : FileContentDirector<NetlistFileWriteRequest>
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

        protected override string Construct(NetlistFileWriteRequest typedRequest)
        {
            var builder = new NetlistFileBuilder();
            var netlist = _netlistRepository.Get(typedRequest.Destination);
            var modules = _moduleRepository.GetAll(netlist.Source);

            builder.BuildMetaStatements(netlist);

            foreach (var module in modules)
            {
                builder.BuildModuleDeclaration(module);
                builder.BuildNewLine();
                builder.BuildPortDeclarations(module);
                builder.BuildSupplyDeclarations(module);
                builder.BuildAssignDeclarations(module);

                foreach (var instance in _instanceRepository.GetByHostModule(netlist.Source, module.Name))
                    builder.BuildInstanceDeclaration(instance);

                builder.BuildEndModule();
                builder.BuildNewLine();
            }

            return builder.GetResult();
        }
    }
}

