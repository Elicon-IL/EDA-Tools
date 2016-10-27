using System;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NetlistClonerTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private const string NewDummyNetlist = "MY-NEW-DUMMY-NETLIST";
        private INetlistRemover _netlistRemover;
        private INetlistCloner _target;
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
            _target = Get<INetlistCloner>();
        }

        [Test]
        public void Clone_SourceNetlistNotExists_ThrowsInvalidOperationException()
        {        
           Assert.Throws<InvalidOperationException>(()=> _target.Clone(DummyNetlist, NewDummyNetlist));       
        }

        [Test]
        public void Clone_SourceNetlistExists_Clone()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist,"m1"));
            _moduleRepository.Add(new Module(DummyNetlist, "m2"));
            _instanceRepository.Add(new Instance(DummyNetlist,"m1","an2","inst1"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "an2", "inst2"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m2", "an3", "inst3"));

            _target.Clone(DummyNetlist, NewDummyNetlist);
            
            var netlist = _netlistRepository.Get(NewDummyNetlist);
            Assert.That(netlist, Is.Not.Null);

            var modules = _moduleRepository.GetAll(NewDummyNetlist).ToList();
            Assert.That(modules, Has.Count.EqualTo(2));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m1"));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m2"));

            var instances = _instanceRepository.GetBy(NewDummyNetlist).ToList();
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst2"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst3"));
        }

        [Test]
        public void Clone_TargetNetlistExists_SourceRemainsTheSame()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist, "m1"));
            _moduleRepository.Add(new Module(DummyNetlist, "m2"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "an2", "inst1"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "an2", "inst2"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m2", "an3", "inst3"));
        
            _target.Clone(DummyNetlist, DummyNetlist);

            var netlist = _netlistRepository.Get(DummyNetlist);
            Assert.That(netlist, Is.Not.Null);

            var modules = _moduleRepository.GetAll(DummyNetlist).ToList();
            Assert.That(modules, Has.Count.EqualTo(2));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m1"));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m2"));

            var instances = _instanceRepository.GetBy(DummyNetlist).ToList();
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst2"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst3"));
        }

        [Test]
        public void Clone_SourceNetlistSameAsTarget_NotClone()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist, "m1"));
            _moduleRepository.Add(new Module(DummyNetlist, "m2"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "an2", "inst1"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m1", "an2", "inst2"));
            _instanceRepository.Add(new Instance(DummyNetlist, "m2", "an3", "inst3"));

            _target.Clone(DummyNetlist, NewDummyNetlist);

            var netlist = _netlistRepository.Get(NewDummyNetlist);
            Assert.That(netlist, Is.Not.Null);

            var modules = _moduleRepository.GetAll(NewDummyNetlist).ToList();
            Assert.That(modules, Has.Count.EqualTo(2));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m1"));
            Assert.That(modules, Has.Exactly(1).Matches<Module>(m => m.Name == "m2"));

            var instances = _instanceRepository.GetBy(NewDummyNetlist).ToList();
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst2"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst3"));
        }

        [TearDown]
        public void TearDown()
        {
           _netlistRemover.Remove(DummyNetlist);
           _netlistRemover.Remove(NewDummyNetlist);
        }
    }
 }

