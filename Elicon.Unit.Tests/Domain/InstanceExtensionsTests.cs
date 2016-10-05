using Elicon.Domain;
using Elicon.Domain.GateLevel;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain
{
    [TestFixture]
    public class InstanceExtensionsTests
    {
        private Instance _target;

        [Test]
        public void IsModule_InstanceTypeIsModule_ReturnTrue()
        {
            _target = new Instance("netlist","host","m1","inst1") {Type = InstanceType.Module};


            var result = _target.IsModule();

            Assert.That(result, Is.True);
        }

        [TestCase(InstanceType.LibraryGate)]
        [TestCase(InstanceType.Unknown)]
        public void IsModule_InstanceTypeIsNotModule_ReturnFalse(InstanceType type)
        {
            _target = new Instance("netlist", "host", "m1", "inst1") { Type = type };

            var result = _target.IsModule();

            Assert.That(result, Is.False);
        }

        [Test]
        public void GetWire_PortNotExists_ReturnNull()
        {
            _target = new Instance("netlist", "host", "m1", "inst1") { Type = InstanceType.Module };

            var result = _target.GetWire("a");

            Assert.That(result, Is.Null);
        }

        [Test]
        public void GetWire_PortExists_ReturnWire()
        {
            _target = new Instance("netlist", "host", "m1", "inst1") { Type = InstanceType.Module };
            _target.Net.Add(new PortWirePair("a","w1"));
            _target.Net.Add(new PortWirePair("b", "w2"));

            var result = _target.GetWire("a");

            Assert.That(result, Is.EqualTo("w1"));
        }
    }
}
