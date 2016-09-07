using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NativeModulesPortListQueryTests : IntegrationTestBase
    {
        private INativeModulesPortListQuery _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<INativeModulesPortListQuery>();
        }

        [Test]
        public void GetNativeModulesPortsList_NetlistWithNativeModules_ReturnsAllNativeModulesPortsList()
        {
            var result = _target.GetNativeModulesPortsList(ExampleNetlistFilePath);

            var expected = new List<NativeModulePorts>
            {
                new NativeModulePorts("an2", new[] {"z", "a", "b"}),
                new NativeModulePorts("an3", new[] {"z", "a", "b", "c"}),
                new NativeModulePorts("an4", new[] {"z", "a", "b", "c", "d"}),
                new NativeModulePorts("aoi21", new[] {"b", "a2", "a1", "zn"}),
                new NativeModulePorts("aoi22", new[] {"b2", "b1", "a2", "a1", "zn"}),
                new NativeModulePorts("aoi31", new[] {"b", "a3", "a2", "a1", "zn"}),
                new NativeModulePorts("b1", new[] {"z", "a"}),
                new NativeModulePorts("bd", new[] {"z", "a"}),
                new NativeModulePorts("cvdd", new[] {"z"}),
                new NativeModulePorts("cvss", new[] {"z"}),
                new NativeModulePorts("dspbrs", new[] {"q", "c", "d", "rn", "sd", "se", "sn", "qn"}),
                new NativeModulePorts("i1", new[] {"zn", "a"}),
                new NativeModulePorts("ic", new[] {"z", "pad"}),
                new NativeModulePorts("iobhc", new[] {"pad", "z", "a", "e"}),
                new NativeModulePorts("mx21", new[] {"z", "a", "b", "sb"}),
                new NativeModulePorts("mx21i", new[] {"zn", "a", "b", "sb"}),
                new NativeModulePorts("mx41", new[] {"z", "i0", "i1", "i2", "i3", "s0", "s1"}),
                new NativeModulePorts("na2", new[] {"zn", "a", "b"}),
                new NativeModulePorts("na3", new[] {"c", "b", "a", "zn"}),
                new NativeModulePorts("na4", new[] {"d", "c", "b", "a", "zn"}),
                new NativeModulePorts("no2", new[] {"b", "a", "zn"}),
                new NativeModulePorts("no3", new[] {"c", "b", "a", "zn"}),
                new NativeModulePorts("no4", new[] {"d", "c", "b", "a", "zn"}),
                new NativeModulePorts("oai21", new[] {"b", "a2", "a1", "zn"}),
                new NativeModulePorts("oai211", new[] {"c", "b", "a2", "a1", "zn"}),
                new NativeModulePorts("oai22", new[] {"b2", "b1", "a2", "a1", "zn"}),
                new NativeModulePorts("or2", new[] {"z", "a", "b"}),
                new NativeModulePorts("or3", new[] {"c", "z", "a", "b"}),
                new NativeModulePorts("or4", new[] {"d", "c", "z", "a", "b"}),
                new NativeModulePorts("oth", new[] {"pad", "a", "e"}),
                new NativeModulePorts("por", new[] {"zn"}),
                new NativeModulePorts("xn2", new[] {"b", "a", "zn"}),
                new NativeModulePorts("xo2", new[] {"z", "a", "b"})
            };

            foreach (var module in result)
                Assert.That(GetPorts(expected, module.ModuleName),
                    Is.EquivalentTo(module.Ports));

            foreach (var module in expected)
                Assert.That(GetPorts(result, module.ModuleName),
                    Is.EquivalentTo(module.Ports));
        }

        private IList<string> GetPorts(IList<NativeModulePorts> list, string moduleName)
        {
            return list.First(nmp => nmp.ModuleName == moduleName).Ports;
        }
    }
 }