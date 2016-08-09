using Elicon.Framework;

namespace Elicon.Domain.Netlist.Commands.Criterias
{
    public class SupplyDeclarationCommandCriteria : ICommandCriteria
    {
        private const string Supply0KeyWord = "supply0";
        private const string Supply1KeyWord = "supply1";

        public bool IsSatisfied(string commnad)
        {
            return commnad.FirstTokenIs(Supply0KeyWord) || commnad.FirstTokenIs(Supply1KeyWord);
        }
    }
}