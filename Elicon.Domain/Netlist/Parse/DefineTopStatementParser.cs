using System;

namespace Elicon.Domain.Netlist.Parse
{
    public class DefineTopStatementParser
    {
        public string GetTopModuleName(string statement)
        {
            statement = RemoveDefineKeyword(statement);
            return RemoveTopKeyword(statement);
        }

        private static string RemoveTopKeyword(string statement)
        {
            return statement
                .Substring(statement.IndexOf(' '))
                .Trim();
        }

        private static string RemoveDefineKeyword(string statement)
        {
            return statement
                .Substring(statement.IndexOf(' '))
                .Trim();
        }
    }
}