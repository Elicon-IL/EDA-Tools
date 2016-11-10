using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Newtonsoft.Json;

namespace Elicon.Domain.GateLevel.VendorLibraryGates
{
    public interface ILibraryLoader
    {
        void Load(string source);
    }

    public class LibraryLoader : ILibraryLoader
    {
        private readonly ILibraryRepository _libraryRepository;
        private readonly IStreamReaderProvider _streamReaderProvider;

        public LibraryLoader(ILibraryRepository libraryRepository, IStreamReaderProvider streamReaderProvider)
        {
            _libraryRepository = libraryRepository;
            _streamReaderProvider = streamReaderProvider;
        }

        public void Load(string sourcePath)
        {
            if (_libraryRepository.Exists(sourcePath))
                return;

            var reader = _streamReaderProvider.Get(sourcePath);
            var jsonContents = reader.ReadToEnd();
            reader.Close();

            var lib = JsonConvert.DeserializeObject<Library>(jsonContents);
            _libraryRepository.Add(lib);

        }
    }
}
