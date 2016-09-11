using System.Collections.Generic;
using System.Reflection;
using Elicon.DataAccess;
using Elicon.Domain;
using Elicon.Domain.GateLevel;
using Elicon.Framework;
using Ninject;
using Ninject.Extensions.Conventions;

namespace Elicon.Console.Config
{
    public static class Bootstrapper
    {
        private static readonly IKernel Kernel = new StandardKernel();

        public static void Boot(IList<Assembly> moreAssemblies)
        {
            Kernel.Bind(x =>
            {
                x.From(moreAssemblies).SelectAllClasses()
                    .BindDefaultInterfaces()
                    .Configure(y => y.InSingletonScope());

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

            var pubSub = Kernel.Get<IPubSub>();
            foreach (var subscriber in Kernel.GetAll<IEventSubscriber>())
                subscriber.Init(pubSub);
            
        }

        public static T Get<T>()
        {
            return Kernel.Get<T>();
        }
    }
}
