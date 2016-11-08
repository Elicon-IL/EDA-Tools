namespace Elicon.Domain.GateLevel.Library
{
    public interface ILibrary
    {
        LibraryGate GetGate(string gateName);
        void AddGate(LibraryGate libraryGate);
    }
}