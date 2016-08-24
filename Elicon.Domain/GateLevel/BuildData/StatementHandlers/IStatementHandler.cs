namespace Elicon.Domain.GateLevel.BuildData.StatementHandlers
{
    public interface IStatementHandler
    {
        void Handle(BuildState state);
        bool CanHandle(BuildState state);
    }
}