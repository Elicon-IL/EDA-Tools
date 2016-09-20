using System;
using System.Collections.Generic;
using Elicon.DataAccess.Files.GateLevel.Write.Netlist;
using Elicon.Domain.GateLevel;
using Elicon.Tests.Framework;
using NUnit.Framework;

namespace Elicon.Unit.Tests.DataAccess.Write
{
    [TestFixture]
    public class NetlistFileBuilderTests
    {
        private INetlistFileBuilder _target;

        [SetUp]
        public void SetUp()
        {
            _target = new NetlistFileBuilder();
        }

        [Test]
        public void BuildInstanceDeclaration_InstanceWithEmptyNet_BuildWithEmptyNet()
        {
            var instanceBuilder = new InstanceBuilder("netlist", "hostModule");
            var instance = instanceBuilder.New("an2", "inst1").Build();
            _target.BuildInstanceDeclaration(instance);

            var result = _target.GetResult().Trim();

            Assert.That(result, Is.EqualTo("an2 inst1 (  );"));
        }

        [Test]
        public void BuildInstanceDeclaration_InstanceWithNet_BuildWithNet()
        {
            var instanceBuilder = new InstanceBuilder("netlist", "hostModule");
            var instance = instanceBuilder.New("an2", "inst1").Add("a","w1").Add("\\xc(f", "w2").Build();
            _target.BuildInstanceDeclaration(instance);

            var result = _target.GetResult().Trim();

            Assert.That(result, Is.EqualTo("an2 inst1 ( .a ( w1 ) , .\\xc(f ( w2 ) );"));
        }

        [Test]
        public void BuildModuleDeclaration_ModuleWithoutPorts_BuildWithNoPorts()
        {
            var module = new Module("netlist", "m1");
            _target.BuildModuleDeclaration(module);

            var result = _target.GetResult().Trim();

            Assert.That(result, Is.EqualTo("module m1 (  );"));
        }

        [Test]
        public void BuildModuleDeclaration_ModuleWithPorts_BuildWithPorts()
        {
            var module = new Module("netlist", "m1") {Ports = new List<Port> {new Port("p1"), new Port("\\es,"), new Port("\\es)") } };
            _target.BuildModuleDeclaration(module);
            
            var result = _target.GetResult().Trim();

            Assert.That(result, Is.EqualTo("module m1 ( p1 , \\es, , \\es) );"));
        }

        [Test]
        public void BuildModulePortDeclarations_NoPorts_BuildEmpty()
        {
            var module = new Module("netlist", "m1");
            _target.BuildModulePortDeclarations(module);

            var result = _target.GetResult().Trim();

            Assert.That(result, Is.Empty);
        }

        [Test]
        public void BuildModulePortDeclarations_WithPorts_BuildWithPorts()
        {
            var  module = new Module("netlist", "m1"){ Ports = new List<Port> {
                    new Port("p1", PortType.Input),
                    new Port("p1-1", PortType.Input),
                    new Port("\\p2,", PortType.Output),
                     new Port("p2-2", PortType.Output),
                    new Port("\\es)")
                }
            };

            _target.BuildModulePortDeclarations(module);

            var result = _target.GetResult().Trim();

            var expected = "input p1 , p1-1 ;" + Environment.NewLine +
                            "output \\p2, , p2-2 ;" + Environment.NewLine +
                            "inout \\es) ;";
            Assert.That(result, Is.EqualTo(expected));
        }
    }
}
