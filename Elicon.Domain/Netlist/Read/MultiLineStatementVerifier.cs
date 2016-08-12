using System.Linq;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.Read
{
    public interface IMultiLineStatementVerifier
    {
        bool IsMultiLineStatement(string statement);
    }

    public class MultiLineStatementVerifier : IMultiLineStatementVerifier
    {
        private readonly IStatementCriteria[] _multiLineStatementsCounterSet = {
            new EmptyStatementCriteria(), new EndModuleStatementCriteria(), new DefineTopStatementCriteria()
        };
        
        public bool IsMultiLineStatement(string statement)
        {
            if (statement.EndsWith(";"))
                return false;

            return !InCounterSet(statement);
        }

        private bool InCounterSet(string statement)
        {
            return _multiLineStatementsCounterSet
                .Any(criteria => criteria.IsSatisfied(statement));
        }
    }
}