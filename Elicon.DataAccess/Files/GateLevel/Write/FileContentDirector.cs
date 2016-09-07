using Elicon.Domain.GateLevel;

namespace Elicon.DataAccess.Files.GateLevel.Write
{
    public interface IFileContentDirector
    {
        bool CanConstruct(IFileWriteRequest request);
        string Construct(IFileWriteRequest request);
    }

    public abstract class FileContentDirector<T> : IFileContentDirector where T : IFileWriteRequest
    {
        public bool CanConstruct(IFileWriteRequest request)
        {
            return request is T;
        }

        public string Construct(IFileWriteRequest request)
        {
            var typedRequest = (T)request;

            return Construct(typedRequest);
        }

        protected abstract string Construct(T typedRequest);
    }
}
