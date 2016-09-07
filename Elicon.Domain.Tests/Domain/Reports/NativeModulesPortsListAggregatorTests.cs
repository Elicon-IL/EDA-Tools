using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;
using Elicon.Tests.Framework;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Reports
{
    [TestFixture]
    public class NativeModulesPortsListAggregatorTests
    {
        private NativeModulesPortListAggregator _target;

        [SetUp]
        public void SetUp()
        {
            _target = new NativeModulesPortListAggregator();
        }

        [Test]
        public void Collect_InstanceNotNative_NotCollected()
        {
            var instance = new InstanceBuilder("netlist", "host").New("moduleName", "instName",InstanceType.Module)
                .Add("a","w1").Add("b","w2").Build();

            _target.Collect(instance);

            var result = _target.Result();
            Assert.That(result,Is.Empty);
        }

        [Test]
        public void Collect_InstanceIsNative_Collected()
        {
            var instance = new InstanceBuilder("netlist", "host").New("moduleName", "instName")
                .Add("a", "w1").Add("b", "w2").Build();

            _target.Collect(instance);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(GetPorts(result, instance.ModuleName), Is.EquivalentTo(new[] {"a", "b"}));
        }

        [Test]
        public void Collect_TwoNativeInstanceOfTheSameModule_InstanceWithMorePortsIsCollected()
        {
            var instance = new InstanceBuilder("netlist", "host").New("moduleName", "instName")
                .Add("a", "w1").Add("b", "w2").Build();
            var instance2 = new InstanceBuilder("netlist", "host").New("moduleName", "instName2")
                .Add("a", "w1").Add("b", "w2").Add("c", "w3").Build();
         
            _target.Collect(instance);
            _target.Collect(instance2);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(GetPorts(result, instance.ModuleName), Is.EquivalentTo(new[] { "a", "b", "c"}));
        }

        [Test]
        public void Collect_TwoNativeInstancesOfDifferentModules_BothAreCollected()
        {
            var instance = new InstanceBuilder("netlist", "host").New("moduleName", "instName")
               .Add("a", "w1").Add("b", "w2").Build();
            var instance2 = new InstanceBuilder("netlist", "host").New("moduleName2", "instName2")
                .Add("c", "w1").Add("d", "w2").Build();

            _target.Collect(instance);
            _target.Collect(instance2);

            var result = _target.Result();
            Assert.That(result, Has.Count.EqualTo(2));
            Assert.That(GetPorts(result, instance.ModuleName), Is.EquivalentTo(new[] {"a", "b"}));
            Assert.That(GetPorts(result, instance2.ModuleName),Is.EquivalentTo(new[] { "c", "d" }));
        }

        private IList<string> GetPorts(IList<NativeModulePorts> list, string moduleName)
        {
            return list.First(nmp => nmp.ModuleName == moduleName).Ports;
        }
    }
}

