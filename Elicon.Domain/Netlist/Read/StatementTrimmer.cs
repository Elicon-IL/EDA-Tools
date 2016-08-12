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
            if (statement.Contains("//"))
                return statement.KeepUntilFirst("//");

            return statement.Trim();
        }
    }
}