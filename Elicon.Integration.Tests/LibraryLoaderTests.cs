using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.VendorLibraryGates;
using NUnit.Framework;

namespace Elicon.Integration.Tests
{
    [TestFixture]
    public class LibraryLoaderTests : IntegrationTestBase
    {
        private ILibraryLoader _target;
        private ILibraryRepository _libraryRepository;

        [SetUp]
        public void SetUp()
        {
            _libraryRepository = Get<ILibraryRepository>();
            _target = Get<ILibraryLoader>();
        }

        [Test]
        public void Load_LoadOnce_LoadedCorrectly()
        {
            _target.Load(ExampleLibraryGateFilePath);
            
            var result = _libraryRepository.Get(ExampleLibraryGateFilePath);

            Assert.That(result.Gates, Has.Count.EqualTo(2));

            Assert.That(result.Gates, Has.Exactly(1).Matches<LibraryGate>(gate => 
                gate.Name.Equals("an2") 
                && gate.Nd2Size == 2 
                && gate.Type == LibraryGateType.And
                && gate.Ports.Count == 3
                && gate.Ports.Any(p => p.Name == "a" && p.Type == LibraryGatePortType.Input)
                && gate.Ports.Any(p => p.Name == "b" && p.Type == LibraryGatePortType.Input)
                && gate.Ports.Any(p => p.Name == "z" && p.Type == LibraryGatePortType.Output)
             ));

            Assert.That(result.Gates, Has.Exactly(1).Matches<LibraryGate>(gate => 
                gate.Name.Equals("or3") 
                && gate.Nd2Size == 3 
                && gate.Type == LibraryGateType.Or
                && gate.Ports.Count == 4
                && gate.Ports.Any(p => p.Name =="a" && p.Type==LibraryGatePortType.Input)
                && gate.Ports.Any(p => p.Name == "b" && p.Type == LibraryGatePortType.Input)
                && gate.Ports.Any(p => p.Name == "c" && p.Type == LibraryGatePortType.Input)
                && gate.Ports.Any(p => p.Name == "z" && p.Type == LibraryGatePortType.Output)
            ));
        }

        [Test]
        public void Load_ReLoadTheSameLibraryTwice_OnlyOneLibraryLoaded()
        {
            _target.Load(ExampleLibraryGateFilePath);
            _target.Load(ExampleLibraryGateFilePath);

            var result = _libraryRepository.GetAll();

            Assert.That(result, Has.Count.EqualTo(1));
        }

        [TearDown]
        public void TearDown()
        {
            _libraryRepository.Remove(ExampleLibraryGateFilePath);
        }
    }
}
