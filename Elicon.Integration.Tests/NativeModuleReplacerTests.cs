using System;
using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations;
using Elicon.Domain.GateLevel.Manipulations.ReplaceNativeModule;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NativeModuleReplacerTests : IntegrationTestBase
    {
        private const string DummyNetlist = "MY-DUMMY-NETLIST";
        private INativeModuleReplacer _target;
        private IInstanceRepository _instanceRepository;

        [SetUp]
        public void SetUp()
        {
            _instanceRepository = Get<IInstanceRepository>();
            Get<INetlistCloner>().Clone(ExampleNetlistFilePath, DummyNetlist);
            _target = Get<INativeModuleReplacer>();
        }

        [Test]
        public void Replace_ModuleIsNativeWithoutMapping_ReplaceModule()
        {
            // oai22 inst056453  ( .b2(n37), .b1(i3), .a2(n36), .a1(i1), .zn(o) );
            const string moduleToReplace = "oai22";
            const string newModule = "oai22new";

            _target.Replace(DummyNetlist, moduleToReplace, newModule, new PortsMapping());

            var result = _instanceRepository.GetByModuleName(DummyNetlist, moduleToReplace).ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, newModule).ToList();
            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "b2" & pwp.Wire == "n37"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "b1" & pwp.Wire == "i3"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a2" & pwp.Wire == "n36"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a1" & pwp.Wire == "i1"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "zn" & pwp.Wire == "o"));
        }

        [Test]
        public void Replace_ModuleIsNativeWithMapping_ReplaceModuleAndMapPorts()
        {
            // oai22 inst056453  ( .b2(n37), .b1(i3), .a2(n36), .a1(i1), .zn(o) );
            const string moduleToReplace = "oai22";
            const string newModule = "oai22new";
            var portsMap = new PortsMapping().AddMapping("b2", "banana2").AddMapping("zn", "zinzana");

            _target.Replace(DummyNetlist, moduleToReplace, newModule, portsMap);

            var result = _instanceRepository.GetByModuleName(DummyNetlist, newModule).ToList();

            Assert.That(result, Has.Count.EqualTo(1));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "banana2" & pwp.Wire == "n37"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "b1" & pwp.Wire == "i3"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a2" & pwp.Wire == "n36"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "a1" & pwp.Wire == "i1"));
            Assert.That(result[0].Net, Has.Exactly(1).Matches<PortWirePair>(pwp => pwp.Port == "zinzana" & pwp.Wire == "o"));
        }

        [Test]
        public void Replace_ModuleIsNative_ReplaceModuleNameForAllInstacnes()
        {
            const string moduleToReplace = "or3";
            var expectedCount = _instanceRepository.GetByModuleName(DummyNetlist, moduleToReplace).ToList().Count;
            const string newModule = "or3new";
         
            _target.Replace(DummyNetlist, moduleToReplace, newModule, new PortsMapping());

            var result = _instanceRepository.GetByModuleName(DummyNetlist, moduleToReplace).ToList();
            Assert.That(result, Is.Empty);

            result = _instanceRepository.GetByModuleName(DummyNetlist, newModule).ToList();
            Assert.That(result, Has.Count.EqualTo(expectedCount));
        }

        [Test]
        public void Replace_ModuleIsNotNative_ThrowsInvalidOperationException()
        {
            var portsMap = new PortsMapping().AddMapping("a", "apricot").AddMapping("b", "banana");
            const string nonNativeModule = "x_lut4_0xfefa";
            const string newModule = "x_lut4_0xfefa_new";

            Assert.Throws<InvalidOperationException>(() => _target.Replace(DummyNetlist, nonNativeModule, newModule, portsMap));
        }

        [TearDown]
        public void TearDown()
        {
            Get<INetlistRemover>().Remove(DummyNetlist);
        }
    }
 }