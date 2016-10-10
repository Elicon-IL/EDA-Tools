using System;

namespace Elicon.Framework
{
    public static class Time
    {
        public static Func<DateTime> Now = () => DateTime.Now;
    }
}
