using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Manipulations;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Manipulations
{
    [TestFixture]
    public class ModulePortsTypeUpdaterTests
    {
        private IModulePortsTypeUpdater _target;

        [SetUp]
        public void SetUp()
        {
            _target = new ModulePortsTypeUpdater();
        }

        [Test]
        public void UpdatePortsType_NoPortsSpecified_NoUpdate()
        {
            var module = new Module("netlist","moduleName");
            module.Ports.Add(new Port("p1", PortType.Input));
            
            _target.UpdatePortsType(module, new List<string>(), PortType.Output);

            Assert.That(module.Ports[0].PortType, Is.EqualTo(PortType.Input));
        }

        [Test]
        public void UpdatePortsType_PortsAreNotInModule_NoUpdate()
        {
            var module = new Module("netlist", "moduleName");
            module.Ports.Add(new Port("p1", PortType.Input));
          
            _target.UpdatePortsType(module, new List<string> { "p4", "p5" }, PortType.Output);

            Assert.That(module.Ports[0].PortType, Is.EqualTo(PortType.Input));
        }

        [Test]
        public void UpdatePortsType_OnePortIsInModule_UpdateThisPort()
        {
            var module = new Module("netlist", "moduleName");
            module.Ports.Add(new Port("p1", PortType.Input));
            module.Ports.Add(new Port("p2", PortType.Input));

            _target.UpdatePortsType(module, new List<string> { "p1", "p5" }, PortType.Output);

            Assert.That(module.Ports[0].PortType, Is.EqualTo(PortType.Output));
            Assert.That(module.Ports[1].PortType, Is.EqualTo(PortType.Input));
        }

        [Test]
        public void UpdatePortsType_AllPortsAreInModule_UpdateThesePort()
        {
            var module = new Module("netlist", "moduleName");
            module.Ports.Add(new Port("p1", PortType.Input));
            module.Ports.Add(new Port("p2", PortType.Input));
            module.Ports.Add(new Port("p3", PortType.Input));

            _target.UpdatePortsType(module, new List<string> { "p1", "p2" }, PortType.Output);

            Assert.That(module.Ports[0].PortType, Is.EqualTo(PortType.Output));
            Assert.That(module.Ports[1].PortType, Is.EqualTo(PortType.Output));
            Assert.That(module.Ports[2].PortType, Is.EqualTo(PortType.Input));
        }


    }
}

