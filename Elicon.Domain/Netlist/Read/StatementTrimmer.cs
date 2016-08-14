using System;
using Elicon.Framework;

namespace Elicon.Domain.Netlist.Read
{
    public interface IStatementTrimmer
    {
        string Trim(string statement);
    }

    public class StatementTrimmer : IStatementTrimmer
    {
        public string Trim(string statement)
        {
            if (IsMetaStatement(statement))
                return "";

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

        private bool IsMetaStatement(string statement)
        {
            return statement.Trim().StartsWith("`");
        }
    }
}