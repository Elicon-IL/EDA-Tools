using System.Linq;
using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public class ErrorStatementCriteria : IStatementCriteria
    {
        private readonly string[] _errorTokens = {
            "defparam", "initial", "tri", "tri0", "tri1", "tran"
        };
        
        public bool IsSatisfied(string statement)
        {
            return _errorTokens.Any(statement.FirstTokenIs);
        }
    }
}