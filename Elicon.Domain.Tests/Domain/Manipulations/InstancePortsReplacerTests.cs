using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Manipulations;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Manipulations
{
    [TestFixture]
    public class InstancePortsReplacerTests
    {
        private IInstancePortsReplacer _target;

        [SetUp]
        public void SetUp()
        {
            _target = new InstancePortsReplacer();
        }

        [Test]
        public void ReplacePorts_NoMapping_NoReplace()
        {
            var portsMap = new Dictionary<string, string>();
            var instances = new List<Instance> { new Instance("netlist","host","name","instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a","w1"), new PortWirePair("b", "w2") }
            }};
            
            _target.ReplacePorts(instances, portsMap);

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("a"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("b"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplacePorts_MappingOfNoExistingPorts_NoReplace()
        {
            var portsMap = new Dictionary<string, string> { { "aa", "apple" }, { "bb", "boom" } };
            var instances = new List<Instance> { new Instance("netlist","host","name","instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a","w1"), new PortWirePair("b", "w2") }
            }};

            _target.ReplacePorts(instances, portsMap);

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("a"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("b"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplacePorts_PartialMapping_ReplaceSpecifiedPorts()
        {
            var portsMap = new Dictionary<string, string> { { "a", "apple" } };
            var instances = new List<Instance> { new Instance("netlist","host","name","instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a","w1"), new PortWirePair("b", "w2") }
            }};

            _target.ReplacePorts(instances, portsMap);

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("apple"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("b"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplacePorts_MappingForAllPorts_ReplaceAll()
        {
            var portsMap = new Dictionary<string, string> { { "a", "apple" }, { "b", "banana" } };
            var instances = new List<Instance> { new Instance("netlist","host","name","instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a","w1"), new PortWirePair("b", "w2") }
            }};

            _target.ReplacePorts(instances, portsMap);

            Assert.That(instances[0].Net, Has.Count.EqualTo(2));
            Assert.That(instances[0].Net[0].Port, Is.EqualTo("apple"));
            Assert.That(instances[0].Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instances[0].Net[1].Port, Is.EqualTo("banana"));
            Assert.That(instances[0].Net[1].Wire, Is.EqualTo("w2"));
        }
    }
}
