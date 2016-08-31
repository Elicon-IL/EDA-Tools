using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Manipulations;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Manipulations
{
    [TestFixture]
    public class InstanceWiresReplacerTests
    {
        private IInstanceWiresReplacer _target;

        [SetUp]
        public void SetUp()
        {
            _target = new InstanceWiresReplacer();
        }

        [Test]
        public void ReplaceWires_NoPortConnectedToOldWire_NoReplace()
        {
            var instances = new List<Instance> { new Instance("netlist", "host", "name", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            }};

            _target.ReplaceWires(instances, "w3", "w33");

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("a"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("b"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplaceWires_PortConnectedToOldWire_ReplaceWires()
        {
            var instances = new List<Instance> { new Instance("netlist", "host", "name", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            }};

            _target.ReplaceWires(instances, "w1", "w11");

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("a"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w11"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("b"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }
    }
}
