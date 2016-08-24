using System.Text;
using Elicon.DataAccess.Files.Common.Write;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;

namespace Elicon.DataAccess.Files.Netlist.Write
{
    public class NetlistFileWriter : INetlistFileWriter
    {
        private readonly INetlistRepository _netlistRepository;
        private readonly IModuleRepository _moduleRepository;
        private readonly IInstanceRepository _instanceRepository;
        private readonly IStreamWriterProvider _streamWriterProvider;

        public NetlistFileWriter(INetlistRepository netlistRepository, IModuleRepository moduleRepository, IInstanceRepository instanceRepository, IStreamWriterProvider streamWriterProvider)
        {
            _netlistRepository = netlistRepository;
            _moduleRepository = moduleRepository;
            _instanceRepository = instanceRepository;
            _streamWriterProvider = streamWriterProvider;
        }

        public void Write(string source)
        {
            var writer = _streamWriterProvider.Get(source);
            var netlist = _netlistRepository.Get(source);
            var modules = _moduleRepository.GetAll(source);

            WriteMetaStatements(netlist, writer);

            foreach (var module in modules)
            {
                WriteModuleDeclaration(writer, module);

                WriteEmptyLine(writer);
                WritePortDeclarations(module, writer);
                WriteSupplyDeclarations(module, writer);
                WriteAssignDeclarations(module, writer);

                foreach (var instance in _instanceRepository.GetBy(source, module.Name))
                    WriteInstance(instance, writer);
                
                writer.WriteLine("endmodule");
                WriteEmptyLine(writer);
            }

            writer.Close();
        }

        private static void WriteInstance(Instance instance, IStreamWriter writer)
        {
            var net = new StringBuilder("( ");
            foreach (var portWirePair in instance.Net)
                net.Append("." + portWirePair.Port + "( " + portWirePair.Wire + " ), ");
            net.Append(" );");

            writer.WriteLine(instance.ModuleName + " " + instance.InstanceName + " " + net);
        }

        private static void WriteEmptyLine(IStreamWriter writer)
        {
            writer.WriteLine();
        }

        private static void WritePortDeclarations(Module module, IStreamWriter writer)
        {
            foreach (var portDeclaration in module.PortDeclarations)
                writer.WriteLine(portDeclaration);
        }

        private static void WriteAssignDeclarations(Module module, IStreamWriter writer)
        {
            foreach (var assignDeclaration in module.AssignDeclarations)
                writer.WriteLine(assignDeclaration);
        }

        private static void WriteSupplyDeclarations(Module module, IStreamWriter writer)
        {
            foreach (var supplyDeclaration in module.SupplyDeclarations)
                writer.WriteLine(supplyDeclaration);
        }

        private static void WriteModuleDeclaration(IStreamWriter writer, Module module)
        {
            writer.WriteLine("module " + module.Name + " " + module.Ports);
            foreach (var portDeclaration in module.PortDeclarations)
                writer.WriteLine(portDeclaration);
        }

        private static void WriteMetaStatements(Domain.Netlist.Netlist netlist, IStreamWriter writer)
        {
            foreach (var metaStatement in netlist.MetaStatements)
                writer.WriteLine(metaStatement);
        }
    }

    public interface INetlistFileWriter
    {
        void Write(string source);
    }
}
