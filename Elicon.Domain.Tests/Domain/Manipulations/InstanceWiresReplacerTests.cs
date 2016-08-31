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
        public void ReplaceWires_NoMapping_NoReplace()
        {
            var wiresMap = new Dictionary<string, string>();
            var instance = new Instance("netlist","host","name","instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a","w1"), new PortWirePair("b", "w2") }
            };
            
            _target.ReplaceWires(instance, wiresMap);

            Assert.That(instance.Net, Has.Count.EqualTo(2));
            Assert.That(instance.Net[0].Port, Is.EqualTo("a"));
            Assert.That(instance.Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instance.Net[1].Port, Is.EqualTo("b"));
            Assert.That(instance.Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplaceWires_MappingOfNoExistingWires_NoReplace()
        {
            var wiresMap = new Dictionary<string, string> { { "w3", "w33" }, { "w4", "w44" } };
            var instance = new Instance("netlist", "host", "name", "instName")
            {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };

            _target.ReplaceWires(instance, wiresMap);

            Assert.That(instance.Net, Has.Count.EqualTo(2));
            Assert.That(instance.Net[0].Port, Is.EqualTo("a"));
            Assert.That(instance.Net[0].Wire, Is.EqualTo("w1"));
            Assert.That(instance.Net[1].Port, Is.EqualTo("b"));
            Assert.That(instance.Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplaceWires_PartialMapping_ReplaceSpecifiedPorts()
        {
            var wiresMap = new Dictionary<string, string> { { "w1", "w11" } };
            var instance = new Instance("netlist", "host", "name", "instName")
            {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };

            _target.ReplaceWires(instance, wiresMap);

            Assert.That(instance.Net, Has.Count.EqualTo(2));
            Assert.That(instance.Net[0].Port, Is.EqualTo("a"));
            Assert.That(instance.Net[0].Wire, Is.EqualTo("w11"));
            Assert.That(instance.Net[1].Port, Is.EqualTo("b"));
            Assert.That(instance.Net[1].Wire, Is.EqualTo("w2"));
        }

        [Test]
        public void ReplaceWires_MappingForAllWires_ReplaceAll()
        {
            var wiresMap = new Dictionary<string, string> { { "w1", "w11" }, { "w2", "w22" } };
            var instance = new Instance("netlist", "host", "name", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };

            _target.ReplaceWires(instance, wiresMap);

            Assert.That(instance.Net, Has.Count.EqualTo(2));
            Assert.That(instance.Net[0].Port, Is.EqualTo("a"));
            Assert.That(instance.Net[0].Wire, Is.EqualTo("w11"));
            Assert.That(instance.Net[1].Port, Is.EqualTo("b"));
            Assert.That(instance.Net[1].Wire, Is.EqualTo("w22"));
        }
    }
}
