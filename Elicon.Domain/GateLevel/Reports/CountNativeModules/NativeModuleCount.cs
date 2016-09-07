namespace Elicon.Domain.GateLevel.Reports.CountNativeModules
{
    public class NativeModuleCount
    {
        public NativeModuleCount(string moduleName, long count)
        {
            ModuleName = moduleName;
            Count = count;
        }

        public string ModuleName { get; }
        public long Count { get; }

        protected bool Equals(NativeModuleCount other)
        {
            return ModuleName == other.ModuleName && Count == other.Count;
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;

            return Equals((NativeModuleCount)obj);
        }

        public override int GetHashCode()
        {
            return ModuleName.GetHashCode() ^ Count.GetHashCode();
        }
    }
}