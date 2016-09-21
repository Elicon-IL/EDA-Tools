using Elicon.Framework;

namespace Elicon.DataAccess.Files.GateLevel.Read
{
    public interface IStatementTrimmer
    {
        string Trim(string statement);
    }

    public class StatementTrimmer : IStatementTrimmer
    {
        public string Trim(string statement)
        {
            return HasComment(statement) ? 
                RemoveComment(statement) : 
                statement.Trim();
        }

        private string RemoveComment(string statement)
        {
            return statement.KeepUntilFirstExclusiveAndTrim("//");
        }

        private bool HasComment(string statement)
        {
            return statement.Contains("//");
        }
    }
}