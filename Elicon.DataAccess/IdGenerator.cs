namespace Elicon.DataAccess
{
    public interface IIdGenerator
    {
        long GenerateId();
    }

    public class IdGenerator : IIdGenerator
    {
        private long _id;
        public long GenerateId()
        {
            return ++_id;
        }
    }
}