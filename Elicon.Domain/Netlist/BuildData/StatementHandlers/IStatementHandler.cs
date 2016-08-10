namespace Elicon.Domain.Netlist.BuildData.StatementHandlers
{
    public interface IStatementHandler
    {
        void Handle(BuildState state);
        bool CanHandle(BuildState state);
    }
}