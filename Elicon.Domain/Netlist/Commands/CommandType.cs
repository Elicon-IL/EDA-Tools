namespace Elicon.Domain.Netlist.Commands
{
    public enum CommandType
    {
        Empty,
        Error,
        DefineTop,
        ModuleDeclaration,
        AssignDeclaration,
        PortDeclaration,
        SupplyDeclaration,
        Instance,
        EndModule,
        WireDeclaration
    }
}