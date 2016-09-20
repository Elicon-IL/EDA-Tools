using Elicon.Tests.Framework;
using System.Collections.Generic;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Moq;
using NUnit.Framework;

namespace Elicon.Unit.Tests.Domain.Manipulations
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
        public void HostModuleDrivesBuffer_BufferInputNotConnectedToModulePort_ReturnsFalse()
        {
            var buffer = new InstanceBuilder("some netlist", "some host").New("b1", "inst1")
                .Add("a", "ina").Add("b", "w3").Build();
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w3"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).HostModuleDrivesBuffer(buffer, "a");
            Assert.That(result, Is.False);
        }

        [Test]
        public void HostModuleDrivesBuffer_BufferInputConnectedToModulePort_ReturnsTrue()
        {
            var buffer = new InstanceBuilder("some netlist", "some host").New("b1", "inst1")
               .Add("a", "w1").Add("b", "w2").Build();
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).HostModuleDrivesBuffer(buffer, "a");

            Assert.That(result, Is.True);
        }

        [Test]
        public void IsPassThroughBuffer_BothBufferInputAndOutputConnectedToModulePort_ReturnsTrue()
        {
            var buffer = new InstanceBuilder("some netlist", "some host").New("b1", "inst1")
              .Add("a", "w1").Add("b", "w2").Build();
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            module.Ports.Add(new Port("w2"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).IsPassThroughBuffer(buffer, "a", "b");

            Assert.That(result, Is.True);
        }

        [Test]
        public void IsPassThroughBuffer_BufferInputNotConnectedToModulePort_ReturnsFalse()
        {
            var buffer = new InstanceBuilder("some netlist", "some host").New("b1", "inst1")
               .Add("a", "ain").Add("b", "w2").Build();
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            module.Ports.Add(new Port("w2"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).IsPassThroughBuffer(buffer, "a", "b");

            Assert.That(result, Is.False);
        }

        [Test]
        public void IsPassThroughBuffer_BufferOutputNotConnectedToModulePort_ReturnsFalse()
        {
            var buffer = new InstanceBuilder("some netlist", "some host").New("b1", "inst1")
              .Add("a", "w1").Add("b", "bout").Build();
            var module = new Module("some netlist", "some host");
            module.Ports.Add(new Port("w1"));
            module.Ports.Add(new Port("w2"));
            StubBufferHostModule(buffer, module);

            var result = new BufferWiringVerifier(_moduleRepository.Object).IsPassThroughBuffer(buffer, "a", "b");

            Assert.That(result, Is.False);
        }

        private void StubBufferHostModule(Instance buffer, Module module)
        {
            _moduleRepository.Setup(mr => mr.Get(buffer.Netlist, buffer.HostModuleName)).Returns(module);
        }
    }
}
