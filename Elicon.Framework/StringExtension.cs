using System;

namespace Elicon.Framework
{
    public static class StringExtension
    {
        public static bool FirstTokenIs(this string str, string token)
        {
            if (!str.StartsWith(token))
                return false;

            return str.Length == token.Length
                || str[token.Length] == ' '
                || str[token.Length] == '\t';

        }

        public static bool IsNullOrEmpty(this string str)
        {
            return string.IsNullOrEmpty(str);
        }

        public static bool IsEscaped(this string str)
        {
            return str.StartsWith("\\");
        }

        public static string KeepUntilFirst(this string str, string delimiter)
        {
            return str.Substring(0, str.IndexOf(delimiter, StringComparison.Ordinal)).Trim();
        }

        public static string KeepFromFirst(this string str, string delimiter)
        {
            return str
               .Substring(str.IndexOf(delimiter, StringComparison.Ordinal))
               .Trim();
        }

        public static string KeepUntilFirst(this string str, char delimiter)
        {
            return str.KeepUntilFirst(delimiter.ToString());
        }

        public static string KeepFromFirst(this string str, char delimiter)
        {
            return str.KeepFromFirst(delimiter.ToString());
        }
    }
}
