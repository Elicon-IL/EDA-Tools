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
            Assert.That(result.Gates, Has.Exactly(1).Matches<LibraryGate>(gate => gate.Name.Equals("an2") && 
                        gate.Nd2Size == 2 && gate.Type == LibraryGateType.And));
            Assert.That(result.Gates, Has.Exactly(1).Matches<LibraryGate>(gate => gate.Name.Equals("or3") && 
                        gate.Nd2Size == 3 && gate.Type == LibraryGateType.Or));
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
