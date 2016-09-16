using System.Collections.Generic;
using System.Linq;
using Elicon.Domain.GateLevel.Reports.ListLibraryGates;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class ListLibraryGatesQueryTests : IntegrationTestBase
    {
        private IListLibraryGatesQuery _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<IListLibraryGatesQuery>();
        }

        [Test]
        public void GetLibraryGates_NetlistWithLibraryGates_ReturnsAllLibraryGates()
        {
            var result = _target.GetLibraryGates(ExampleNetlistFilePath);

            var expected = new List<LibraryGate>
            {
                new LibraryGate("an2", new[] {"z", "a", "b"}),
                new LibraryGate("an3", new[] {"z", "a", "b", "c"}),
                new LibraryGate("an4", new[] {"z", "a", "b", "c", "d"}),
                new LibraryGate("aoi21", new[] {"b", "a2", "a1", "zn"}),
                new LibraryGate("aoi22", new[] {"b2", "b1", "a2", "a1", "zn"}),
                new LibraryGate("aoi31", new[] {"b", "a3", "a2", "a1", "zn"}),
                new LibraryGate("b1", new[] {"z", "a"}),
                new LibraryGate("bd", new[] {"z", "a"}),
                new LibraryGate("cvdd", new[] {"z"}),
                new LibraryGate("cvss", new[] {"z"}),
                new LibraryGate("dspbrs", new[] {"q", "c", "d", "rn", "sd", "se", "sn", "qn"}),
                new LibraryGate("i1", new[] {"zn", "a"}),
                new LibraryGate("ic", new[] {"z", "pad"}),
                new LibraryGate("iobhc", new[] {"pad", "z", "a", "e"}),
                new LibraryGate("mx21", new[] {"z", "a", "b", "sb"}),
                new LibraryGate("mx21i", new[] {"zn", "a", "b", "sb"}),
                new LibraryGate("mx41", new[] {"z", "i0", "i1", "i2", "i3", "s0", "s1"}),
                new LibraryGate("na2", new[] {"zn", "a", "b"}),
                new LibraryGate("na3", new[] {"c", "b", "a", "zn"}),
                new LibraryGate("na4", new[] {"d", "c", "b", "a", "zn"}),
                new LibraryGate("no2", new[] {"b", "a", "zn"}),
                new LibraryGate("no3", new[] {"c", "b", "a", "zn"}),
                new LibraryGate("no4", new[] {"d", "c", "b", "a", "zn"}),
                new LibraryGate("oai21", new[] {"b", "a2", "a1", "zn"}),
                new LibraryGate("oai211", new[] {"c", "b", "a2", "a1", "zn"}),
                new LibraryGate("oai22", new[] {"b2", "b1", "a2", "a1", "zn"}),
                new LibraryGate("or2", new[] {"z", "a", "b"}),
                new LibraryGate("or3", new[] {"c", "z", "a", "b"}),
                new LibraryGate("or4", new[] {"d", "c", "z", "a", "b"}),
                new LibraryGate("oth", new[] {"pad", "a", "e"}),
                new LibraryGate("por", new[] {"zn"}),
                new LibraryGate("xn2", new[] {"b", "a", "zn"}),
                new LibraryGate("xo2", new[] {"z", "a", "b"})
            };

            foreach (var module in result)
                Assert.That(GetPorts(expected, module.ModuleName),
                    Is.EquivalentTo(module.Ports));

            foreach (var module in expected)
                Assert.That(GetPorts(result, module.ModuleName),
                    Is.EquivalentTo(module.Ports));
        }

        private IList<string> GetPorts(IList<LibraryGate> list, string moduleName)
        {
            return list.First(nmp => nmp.ModuleName == moduleName).Ports;
        }
    }
 }