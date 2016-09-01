﻿using Elicon.Framework;

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
            statement = statement.Trim();

            if (statement.FirstTokenIs("wire"))
                return string.Empty;

            if (HasComment(statement))
                return RemoveComment(statement);

            return statement;
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