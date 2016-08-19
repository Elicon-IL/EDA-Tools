namespace Elicon.Framework
{
    public interface IPrecentageCalculator
    {
        short CalculatePrecentage(long part, long total );
    }

    public class PrecentageCalculator : IPrecentageCalculator
    {
        public short CalculatePrecentage(long part, long total)
        {
            if (part < 0)
                return 0;

            return (short) ((decimal)part / total * 100);
        }
    }
}