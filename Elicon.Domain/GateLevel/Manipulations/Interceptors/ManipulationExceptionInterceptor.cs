using System;
using System.Linq;
using Elicon.Domain.GateLevel.Contracts.DataAccess;
using Elicon.Domain.GateLevel.Manipulations.RemoveBuffer;
using Ninject.Extensions.Interception;

namespace Elicon.Domain.GateLevel.Manipulations.Interceptors
{
    public class ManipulationExceptionInterceptor : IInterceptor
    {
        private readonly INetlistRemover _netlistRemover;

        public ManipulationExceptionInterceptor(INetlistRemover netlistRemover)
        {
            _netlistRemover = netlistRemover;
        }

        public void Intercept(IInvocation invocation)
        {
            try
            {
                invocation.Proceed();
            }
            catch (Exception e)
            {
                var request = invocation.Request.Arguments.OfType<IManipultaionRequest>().First();
                _netlistRemover.Remove(request.TargetNetlist);
                throw e;
            }
        }
    }
}