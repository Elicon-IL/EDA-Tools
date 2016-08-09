namespace Elicon.Domain.Netlist.BuildData.CommandHandlers
{
    public interface ICommandHandler
    {
        void Handle(BuildState state);
        bool CanHandle(BuildState state);
    }
}