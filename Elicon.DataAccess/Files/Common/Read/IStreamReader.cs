namespace Elicon.DataAccess.Files.Common.Read
{
    public interface IStreamReader
    {
        string ReadLine();
        void Close();
    }
}