using System.Linq;
using Elicon.Domain.Netlist.Statements.Criterias;

namespace Elicon.Domain.Netlist.Read
{
    public interface IMultiLineStatementVerifier
    {
        bool IsMultiLineStatement(string commnad);
    }

    public class MultiLineStatementVerifier : IMultiLineStatementVerifier
    {
        private readonly IStatementCriteria[] _multiLineStatementsCounterSet = {
            new EmptyStatementCriteria(), new EndModuleStatementCriteria(), new DefineTopStatementCriteria()
        };
        
        public bool IsMultiLineStatement(string commnad)
        {
            if (commnad.EndsWith(";"))
                return false;

            return !_multiLineStatementsCounterSet
                    .Any(criteria => criteria.IsSatisfied(commnad));
        }
    }
}