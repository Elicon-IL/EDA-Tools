using Elicon.DataAccess;
using Elicon.Domain.Netlist;
using Elicon.Framework;
using Ninject;
using Ninject.Extensions.Conventions;

namespace Elicon.Console.Config
{
    public static class Bootstrapper
    {
        private static readonly IKernel Kernel = new StandardKernel();

        public static void Boot()
        {
            Kernel.Bind(x =>
            {
                x.FromAssemblyContaining<Instance>()
                    .SelectAllClasses()
                    .BindDefaultInterfaces()
                    .Configure(y => y.InSingletonScope());

                x.FromAssemblyContaining<IdGenerator>()
                    .SelectAllClasses()
                    .BindDefaultInterfaces()
                    .Configure(y => y.InSingletonScope());

                x.FromAssemblyContaining<StreamReaderAdapter>()
                   .SelectAllClasses()
                   .BindDefaultInterfaces()
                   .Configure(y => y.InSingletonScope());
            });
        }

        public static T Get<T>()
        {
            return Kernel.Get<T>();
        }
    }
}
