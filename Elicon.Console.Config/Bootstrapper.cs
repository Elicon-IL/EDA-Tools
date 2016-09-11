using System.Collections.Generic;
using System.Linq;
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
        private static readonly Assembly[] Assemblies = {
                typeof(Instance).Assembly, // Domain
                typeof(IIdGenerator).Assembly, // DataAccess
                typeof(PrecentageCalculator).Assembly // Framework
        };

        public static void Boot(IList<Assembly> moreAssemblies)
        {
            Kernel.Bind(x => {
                x.From(Assemblies.Concat(moreAssemblies)).SelectAllClasses()
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
