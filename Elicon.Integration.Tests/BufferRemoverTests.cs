using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Elicon.Tests.Framework;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class BufferRemoverTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INetlistRemover _netlistRemover;
        private IBufferRemover _target;
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
            _target = Get<IBufferRemover>();
            _netlistRepository.Add(new Netlist(DummyNetlist));
        }

        [Test]
        public void Remove_BufferIsPassThroughBuffer_NotRemoveBuffer()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "w1").Add("o", "w5").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "w3").Add("b", "w2").Add("z", "w4").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByModuleName(DummyNetlist, "x_buf");
            Assert.That(result, Has.Exactly(1).Matches<Instance>(i => i.InstanceName == "inst1"));
        }

        [Test]
        public void Remove_OneBufferConnectedToInputPort_RemoveBuffer()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "w1").Add("o", "out").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "out").Add("b", "w2").Add("z", "w4").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByModuleName(DummyNetlist, "x_buf").ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, "an2").ToList();
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a" && pwp.Wire == "w1"));
        }

        [Test]
        public void Remove_BufferConnectedToOutputPort_RemoveBuffer()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "out").Add("o", "w4").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "w1").Add("b", "w2").Add("z", "out").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByModuleName(DummyNetlist, "x_buf").ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, "an2").ToList();
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "z" && pwp.Wire == "w4"));
        }

        [Test]
        public void Remove_TwoBuffers_RemoveBuffers()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "i1").Add("o", "o1").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "i1").Add("b", "w2").Add("z", "o2").Build());
            _instanceRepository.Add(builder.New("x_buf", "inst3").Add("i", "o2").Add("o", "o3").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByModuleName(DummyNetlist, "x_buf").ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, "an2").ToList();
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a" && pwp.Wire == "o1"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "z" && pwp.Wire == "o3"));
        }

        [Test]
        public void Remove_ChainOfTwoBuffers_RemoveBuffers()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "w3").Add("o", "out1").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "z1").Add("b", "w2").Add("z", "w4").Build());
            _instanceRepository.Add(builder.New("x_buf", "inst3").Add("i", "out1").Add("o", "z1").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByModuleName(DummyNetlist, "x_buf").ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, "an2").ToList();
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a" && pwp.Wire == "w3"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "b" && pwp.Wire == "w2"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "z" && pwp.Wire == "w4"));
        }

        [Test]
        public void Remove_ExtraModule_RemoveBufferAndNotRewireOutsideHostModule()
        {
            var hostModule = CreateHostModule("test_module");
            var builder = new InstanceBuilder(DummyNetlist, hostModule.Name);
            _instanceRepository.Add(builder.New("x_buf", "inst1").Add("i", "i1").Add("o", "out").Build());
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "i1").Add("b", "w2").Add("z", "zout").Build());

            var hostModule2 = CreateHostModule("test_module_2");
            builder = new InstanceBuilder(DummyNetlist, hostModule2.Name);
            _instanceRepository.Add(builder.New("an2", "inst2").Add("a", "i1").Add("b", "w2").Add("z", "zout").Build());

            _target.Remove(DummyNetlist, "x_buf", "i", "o");

            var result = _instanceRepository.GetByHostModule(DummyNetlist, hostModule2.Name).ToList();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a" && pwp.Wire == "i1"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "b" && pwp.Wire == "w2"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "z" && pwp.Wire == "zout"));
        }
   

        [TearDown]
        public void TearDown()
        {
            _netlistRemover.Remove(DummyNetlist);
        }

        private Module CreateHostModule(string moduleName)
        { 
            var hostModule = new Module(DummyNetlist, moduleName) {
                Ports = new List<Port> {new Port("w1", PortType.Input),new Port("w2", PortType.Input),
                    new Port("w3", PortType.Input),new Port("w4", PortType.Output),new Port("w5", PortType.Output)
                }
            };

            _moduleRepository.Add(hostModule);

            return hostModule;
        }
    }
 }


