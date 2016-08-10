using System;

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
            if (statement.Contains("//"))
                return statement
                    .Substring(0, statement.IndexOf("//", StringComparison.Ordinal))
                    .Trim();

            return statement.Trim();
        }
    }
}