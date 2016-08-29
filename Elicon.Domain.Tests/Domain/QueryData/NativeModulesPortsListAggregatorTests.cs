using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.QueryData.NativeModulesPortsList;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.QueryData
{
    [TestFixture]
    public class NativeModulesPortsListAggregatorTests
    {
        private NativeModulesPortsListAggregator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new NativeModulesPortsListAggregator();
        }

        [Test]
        public void Collect_InstanceNotNative_NotCollected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {
                Type = InstanceType.Module,
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };

            _target.Collect(instance);

            var result = _target.Result();
            Assert.That(result,Is.Empty);
        }

        [Test]
        public void Collect_InstanceIsNative_Collected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };

            _target.Collect(instance);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result["moduleName"], Is.EquivalentTo(new[] {"a", "b"}));
        }

        [Test]
        public void Collect_TwoNativeInstanceOfTheSameModule_InstanceWithMorePortsIsCollected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };
            var instance2 = new Instance("netlist", "host", "moduleName", "instName1") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2"), new PortWirePair("c", "w3") }
            };

            _target.Collect(instance);
            _target.Collect(instance2);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result["moduleName"], Is.EquivalentTo(new[] { "a", "b", "c"}));
        }

        [Test]
        public void Collect_TwoNativeInstancesOfDifferentModules_BothAreCollected()
        {
            var instance = new Instance("netlist", "host", "moduleName", "instName") {
                Net = new List<PortWirePair>() { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };
            var instance2 = new Instance("netlist", "host", "moduleName2", "instName1") {
                Net = new List<PortWirePair>() { new PortWirePair("c", "w1"), new PortWirePair("d", "w2") }
            };

            _target.Collect(instance);
            _target.Collect(instance2);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(result["moduleName"], Is.EquivalentTo(new[] { "a", "b" }));
            Assert.That(result["moduleName2"], Is.EquivalentTo(new[] { "c", "d" }));
        }
    }
}

