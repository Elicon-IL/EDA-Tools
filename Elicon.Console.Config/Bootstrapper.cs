using Elicon.DataAccess;
using Elicon.Domain;
using Elicon.Domain.Netlist;
using Elicon.Domain.Netlist.Contracts.DataAccess;
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
                // Domain
                x.FromAssemblyContaining<Instance>()
                    .SelectAllClasses()
                    .BindDefaultInterfaces()
                    .Configure(y => y.InSingletonScope());

                // DataAccess
                x.FromAssemblyContaining<IIdGenerator>()
                    .SelectAllClasses()
                    .BindDefaultInterfaces()
                    .Configure(y => y.InSingletonScope());
                
                // Framework
                x.FromAssemblyContaining<PrecentageCalculator>()
                   .SelectAllClasses()
                   .BindDefaultInterfaces()
                   .Configure(y => y.InSingletonScope());
            });

            foreach (var subscriber in Kernel.GetAll<IEventSubscriber>())
                subscriber.Init();
            
            
        }

        public static T Get<T>()
        {
            return Kernel.Get<T>();
        }
    }
}
