using Elicon.Domain.GateLevel;

namespace Elicon.Tests.Framework
{
    public class InstanceBuilder
    {
        private readonly string _netlist;
        private readonly string _hostModule;
        private Instance _instance;

        public InstanceBuilder(string netlist, string hostModule)
        {
            _netlist = netlist;
            _hostModule = hostModule;
        }

        public InstanceBuilder New(string moduleName, string instanceName, InstanceType instanceType = InstanceType.Unknown)
        {
            _instance = new Instance(_netlist, _hostModule, moduleName, instanceName) { Type = instanceType };
            return this;
        }

        public InstanceBuilder Add(string port, string wire)
        {
            _instance.Net.Add(new PortWirePair(port, wire));
            return this;
        }

        public Instance Build()
        {
            return _instance;
        }
    }
}
