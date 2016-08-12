using Elicon.Framework;

namespace Elicon.Domain.Netlist.Statements.Criterias
{
    public class PortDeclarationStatementCriteria : IStatementCriteria
    {
        private const string InputKeyWord = "input";
        private const string OutputKeyWord = "output";
        private const string InoutKeyWord = "inout";

        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs(InputKeyWord) ||
                   commnad.FirstTokenIs(OutputKeyWord) ||
                   commnad.FirstTokenIs(InoutKeyWord);
        }
    }
}