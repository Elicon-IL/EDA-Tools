using System;
using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.UpperCaseNativeModulePorts;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NativeModulePortsReplacerTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INetlistRemover _netlistRemover;
        private INativeModulePortsReplacer _target;
        private INetlistRepository _netlistRepository;
        private IModuleRepository _moduleRepository;
        private IInstanceRepository _instanceRepository;

        [SetUp]
        public void SetUp()
        {
            _netlistRepository = Get<INetlistRepository>();
            _moduleRepository = Get<IModuleRepository>();
            _instanceRepository = Get<IInstanceRepository>();
            _netlistRemover = Get<INetlistRemover>();
            _target = Get<INativeModulePortsReplacer>();
        }

        [Test]
        public void PortsToUpper_BothNativeAndNonNativeInstances_UppercasePortsOnlyForNativeInstances()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist,"m1"));
            _moduleRepository.Add(new Module(DummyNetlist, "m2"));
            _instanceRepository.Add(new Instance(DummyNetlist,"m1","an2","inst1") {Net = new List<PortWirePair>() {new PortWirePair("a","w")} });
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "some-non-native", "inst2") {Type = InstanceType.Module, Net = new List<PortWirePair>() { new PortWirePair("b", "w") } });
            _instanceRepository.Add(new Instance(DummyNetlist, "m2", "an2", "inst3") { Net = new List<PortWirePair>() { new PortWirePair("c", "w") } });

            _target.PortsToUpper(DummyNetlist);
      
            var instances = _instanceRepository.GetBy(DummyNetlist).ToList();
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1" && i.Net[0].Port == "A"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst2" && i.Net[0].Port == "b"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst3" && i.Net[0].Port == "C"));
        }

        [TearDown]
        public void TearDown()
        {
           _netlistRemover.Remove(DummyNetlist);
        }
    }
 }

