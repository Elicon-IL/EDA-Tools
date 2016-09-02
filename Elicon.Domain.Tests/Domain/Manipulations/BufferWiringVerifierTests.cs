using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Moq;
using NUnit.Framework;

namespace Elicon.Domain.Tests.Domain.Manipulations
{
    [TestFixture]
    public class BufferWiringVerifierTests
    {
        private Mock<IModuleRepository> _moduleRepository;
        
        [SetUp]
        public void SetUp()
        {
            _moduleRepository = new Mock<IModuleRepository>();
        }

        [Test]
        public void Verify_BufferNotConnectedToModulePorts_ReturnsNotConnectedWiring()
        {
            var buffer = new Instance("some netlist", "some host", "b1", "inst1") {
                Net = new List<PortWirePair> {new PortWirePair("a", "w1"), new PortWirePair("b", "w2")} 
            };
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w3"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).Verify(buffer, "a","b");

            Assert.That(result, Is.EqualTo(BufferWiring.NotConnectedToHostModule));
        }

        [Test]
        public void Verify_OnlyBufferInputConnectedToModulePort_ReturnsDrivenByModuleOption()
        {
            var buffer = new Instance("some netlist", "some host", "b1", "inst1") {
                Net = new List<PortWirePair> { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).Verify(buffer, "a", "b");

            Assert.That(result, Is.EqualTo(BufferWiring.DrivenByHostModule));
        }

        [Test]
        public void IsPassThroughBuffer_OnlyBufferOutputConnectedToModulePort_ReturnsDrivesHostModule()
        {
            var buffer = new Instance("some netlist", "some host", "b1", "inst1") {
                Net = new List<PortWirePair> { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w2"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).Verify(buffer, "a", "b");

            Assert.That(result, Is.EqualTo(BufferWiring.DrivesHostModule));
        }

        [Test]
        public void IsPassThroughBuffer_BothBufferInputAndOutputConnectedToModulePort_ReturnsPassThroughBuffer()
        {
            var buffer = new Instance("some netlist", "some host", "b1", "inst1")
            {
                Net = new List<PortWirePair> { new PortWirePair("a", "w1"), new PortWirePair("b", "w2") }
            };
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            module.Ports.Add(new Port("w2"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).Verify(buffer, "a", "b");

            Assert.That(result, Is.EqualTo(BufferWiring.PassThroughBuffer));
        }

        private void StubBufferHostModule(Instance buffer, Module module)
        {
            _moduleRepository.Setup(mr => mr.Get(buffer.Netlist, buffer.HostModuleName)).Returns(module);
        }
    }
}
