namespace Elicon.Framework
{
    public interface IPrecentageCalculator
    {
        short ClaculatePrecentage(long part, long total );
    }

    public class PrecentageCalculator : IPrecentageCalculator
    {
        public short ClaculatePrecentage(long part, long total)
        {
            return (short) ((decimal)part / total * 100);
        }
    }
}