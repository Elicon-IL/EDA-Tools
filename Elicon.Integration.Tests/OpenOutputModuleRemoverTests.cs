using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Tests.Framework;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class OpenOutputModuleRemoverTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INetlistRemover _netlistRemover;
        private IOpenOutputModuleRemover _target;
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
            _target = Get<IOpenOutputModuleRemover>();
        }

        [Test]
        public void Remove_OneHostModule_RemoveOpenOutputInstances()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist,"m1"));
            var instanceBuilder = new InstanceBuilder(DummyNetlist, "m1");
            _instanceRepository.Add(instanceBuilder.New("an2","inst1").Add("a","w").Build());
            _instanceRepository.Add(instanceBuilder.New("b1", "inst2").Add("a", "w1").Build());
            _instanceRepository.Add(instanceBuilder.New("b1", "inst3").Add("a", "w1").Add("z", null).Build());
            _instanceRepository.Add(instanceBuilder.New("b1", "inst4").Add("a", "w1").Add("z", "").Build());
            _instanceRepository.Add(instanceBuilder.New("b1", "inst5").Add("a", "w1").Add("z", "w2").Build());
            
            _target.Remove(DummyNetlist, "b1", "z");
      
            var instances = _instanceRepository.GetBy(DummyNetlist).ToList();
            Assert.That(instances, Has.Count.EqualTo(2));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1"));
            Assert.That(instances, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst5"));
        }

        [Test]
        public void Remove_NetlistMoreThanOneHostModule_RemoveFromAllHostModules()
        {
            _netlistRepository.Add(new Netlist(DummyNetlist));
            _moduleRepository.Add(new Module(DummyNetlist, "m1"));
            _moduleRepository.Add(new Module(DummyNetlist, "m2"));

            var instanceBuilder = new InstanceBuilder(DummyNetlist, "m1");
            _instanceRepository.Add(instanceBuilder.New("b1", "inst2").Add("a", "w1").Build());
            instanceBuilder = new InstanceBuilder(DummyNetlist, "m2");
            _instanceRepository.Add(instanceBuilder.New("b1", "inst4").Add("a", "w1").Add("z", "").Build());
            
            _target.Remove(DummyNetlist, "b1", "z");

            var instances = _instanceRepository.GetBy(DummyNetlist).ToList();
            Assert.That(instances, Is.Empty);
        }

        [TearDown]
        public void TearDown()
        {
           _netlistRemover.Remove(DummyNetlist);
        }
    }
 }

