using System.Collections.Generic;
using Elicon.Domain.GateLevel.Reports.NativeModulesPortsList;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class NativeModulesPortsListReportTests : IntegrationTestBase
    {
        private INativeModulesPortsListReport _target;

        [SetUp]
        public void SetUp()
        {
            _target = Get<INativeModulesPortsListReport>();
        }

        [Test]
        public void GetNativeModulesPortsList_NetlistWithNativeModules_ReturnsAllNativeModulesPortsList()
        {
            var result = _target.GetNativeModulesPortsList(ExampleNetlistFilePath);

            var expected = new Dictionary<string, string[]> {
                {"an2", new []{"z", "a", "b"}}, {"an3", new []{"z", "a", "b", "c"}}, {"an4", new []{"z", "a", "b", "c", "d"}},
                { "aoi21", new []{"b", "a2", "a1", "zn"}}, {"aoi22", new []{"b2", "b1", "a2", "a1", "zn"}}, {"aoi31", new []{"b", "a3", "a2", "a1", "zn"}},
                { "b1", new []{"z", "a"}}, {"bd",  new []{"z", "a"}}, {"cvdd",  new []{"z"}}, {"cvss",  new []{"z"}},
                { "dspbrs", new []{"q", "c", "d","rn","sd","se", "sn", "qn"}}, {"i1", new []{"zn","a"}}, {"ic", new []{"z","pad"}},
                { "iobhc", new []{"pad", "z", "a", "e"}}, {"mx21",  new []{"z", "a", "b", "sb"}}, {"mx21i", new []{"zn", "a", "b", "sb"}},
                { "mx41", new []{"z", "i0", "i1","i2","i3","s0", "s1"}}, {"na2", new []{"zn", "a", "b"}}, {"na3", new []{"c", "b", "a", "zn"}},
                { "na4", new []{"d","c", "b", "a", "zn"}}, {"no2", new []{"b", "a", "zn"}},{"no3", new []{"c", "b", "a", "zn"}}, {"no4",  new []{"d", "c", "b", "a", "zn"}},
                { "oai21", new []{"b", "a2", "a1", "zn"}}, {"oai211", new []{"c","b", "a2", "a1", "zn"}}, {"oai22", new []{"b2", "b1", "a2", "a1", "zn"}},
                { "or2",  new []{"z", "a", "b"}}, {"or3",  new []{"c", "z", "a", "b"}}, {"or4", new []{"d", "c", "z", "a", "b"}},
                { "oth", new []{"pad", "a", "e"}}, { "por", new []{"zn"}}, {"xn2", new []{"b", "a", "zn"}}, {"xo2", new []{"z", "a", "b"}}
            };

            foreach (var kvp in result)
                Assert.That(kvp.Value, Is.EquivalentTo(expected[kvp.Key]));

            foreach (var kvp in expected)
                Assert.That(kvp.Value, Is.EquivalentTo(result[kvp.Key]));
        }
    }
 }