using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Elicon.DataAccess;
using Elicon.Domain;
using Elicon.Domain.GateLevel;
using Elicon.Domain.GateLevel.Manipulations.Interceptors;
using Elicon.Framework;
using Ninject;
using Ninject.Extensions.Conventions;
using Ninject.Extensions.Interception;
using Ninject.Extensions.Interception.Infrastructure.Language;

namespace Elicon.Config
{
    public static class Bootstrapper
    {
        private static readonly IKernel Kernel = new StandardKernel(
            new NinjectSettings {LoadExtensions = false}, new LinFuModule());

        private static readonly Assembly[] Assemblies = {
                typeof(Bootstrapper).Assembly, // Config
                typeof(Instance).Assembly, // Domain
                typeof(IIdGenerator).Assembly, // DataAccess
                typeof(PrecentageCalculator).Assembly // Framework
        };

        public static void Boot(IList<Assembly> moreAssemblies)
        {
            var assemblies = Assemblies.Concat(moreAssemblies).ToArray();

            Kernel.Bind(x =>
            {
                x.From(assemblies)
                .SelectAllClasses()
                .Where(type => !type.Name.EndsWith("Manipulation"))
                .BindDefaultInterfaces()
                .Configure(y => y.InSingletonScope());
            });

            Kernel.Bind(x =>
            {
               x.From(assemblies)
                .SelectAllClasses()
                .Where(type => type.Name.EndsWith("Manipulation"))
                .BindDefaultInterfaces()
                .Configure(y => {
                    y.InSingletonScope();
                    y.Intercept().With<ManipulationExceptionInterceptor>();
                });
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
