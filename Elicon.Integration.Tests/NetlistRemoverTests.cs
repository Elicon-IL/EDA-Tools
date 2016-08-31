using Elicon.Domain.GateLevel.Contracts.DataAccess;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NetlistRemoverTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INetlistRemover _target;
        private INetlistCloner _netlistCloner;
        private INetlistRepository _netlistRepository;
        private IModuleRepository _moduleRepository;
        private IInstanceRepository _instanceRepository;

        [SetUp]
        public void SetUp()
        {
            _netlistRepository = Get<INetlistRepository>();
            _moduleRepository = Get<IModuleRepository>();
            _instanceRepository = Get<IInstanceRepository>();
            _netlistCloner = Get<INetlistCloner>();
            _target = Get<INetlistRemover>();
        }

        [Test]
        public void Remove_NetlistNotExists_RemoveNetlist()
        {
            Assert.DoesNotThrow(()=>_target.Remove(DummyNetlist));
        }

        [Test]
        public void Remove_NetlistExists_RemoveNetlist()
        {
            _netlistCloner.Clone(ExampleNetlistFilePath, DummyNetlist);

            _target.Remove(DummyNetlist);

            var netlist = _netlistRepository.Get(DummyNetlist);
            Assert.That(netlist, Is.Null);

            var modules  = _moduleRepository.GetAll(DummyNetlist);
            Assert.That(modules, Is.Empty);

            var instances = _instanceRepository.GetBy(DummyNetlist);
            Assert.That(instances, Is.Empty);
        }
    }
 }
