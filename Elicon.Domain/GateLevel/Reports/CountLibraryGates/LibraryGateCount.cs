namespace Elicon.Domain.GateLevel.Reports.CountLibraryGates
{
    public class LibraryGateCount
    {
        public LibraryGateCount(string moduleName, long count)
        {
            ModuleName = moduleName;
            Count = count;
        }

        public string ModuleName { get; }
        public long Count { get; }

        protected bool Equals(LibraryGateCount other)
        {
            return ModuleName == other.ModuleName && Count == other.Count;
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;

            return Equals((LibraryGateCount)obj);
        }

        public override int GetHashCode()
        {
            return ModuleName.GetHashCode() ^ Count.GetHashCode();
        }
    }
}