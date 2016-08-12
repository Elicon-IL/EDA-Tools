using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class WireDeclarationStatementCriteria : IStatementCriteria
    {
        private const string WireKeyWord = "wire";

        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs(WireKeyWord);
        }
    }
}