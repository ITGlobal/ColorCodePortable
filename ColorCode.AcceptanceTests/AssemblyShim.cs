using System.Reflection;

namespace ColorCode
{
    public static class AssemblyShim
    {
        public static Assembly GetExecutingAssembly()
        {
            return typeof(AssemblyShim).GetTypeInfo().Assembly;
        }
    }
}