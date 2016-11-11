using System.Web.Script.Serialization;
using Elicon.Domain.GateLevel.Contracts.DataAccess;

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

            var deserializer = new JavaScriptSerializer();
            var lib = deserializer.Deserialize<Library>(jsonContents);

            lib.Source = sourcePath;
            _libraryRepository.Add(lib);

        }
    }
}
