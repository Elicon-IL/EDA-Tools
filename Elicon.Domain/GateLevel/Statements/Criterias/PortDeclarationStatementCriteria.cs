using Elicon.Framework;

namespace Elicon.Domain.GateLevel.Statements.Criterias
{
    public class PortDeclarationStatementCriteria : IStatementCriteria
    {
        private const string InputKeyWord = "input";
        private const string OutputKeyWord = "output";
        private const string InoutKeyWord = "inout";

        public bool IsSatisfied(string statement)
        {
            return statement.FirstTokenIs(InputKeyWord) ||
                   statement.FirstTokenIs(OutputKeyWord) ||
                   statement.FirstTokenIs(InoutKeyWord);
        }
    }
}