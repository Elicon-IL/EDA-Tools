namespace Elicon.DataAccess.Files.Common.Write
{
    public interface IStreamWriter
    {
        void WriteLine(string line);
        void WriteLine();
        void Close();
    }
}