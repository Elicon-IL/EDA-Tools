using Elicon.Framework;

namespace Elicon.DataAccess.ReadFiles
{
    public interface IStatementTrimmer
    {
        string Trim(string statement);
    }

    public class StatementTrimmer : IStatementTrimmer
    {
        public string Trim(string statement)
        {
            if (HasComment(statement))
                return RemoveComment(statement);

            return statement.Trim();
        }

        private string RemoveComment(string statement)
        {
            return statement.KeepUntilFirst("//");
        }

        private bool HasComment(string statement)
        {
            return statement.Contains("//");
        }
    }
}