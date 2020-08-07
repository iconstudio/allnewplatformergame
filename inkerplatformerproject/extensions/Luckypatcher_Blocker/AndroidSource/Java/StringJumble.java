package ${YYAndroidPackageName};

public class StringJumble
{
  static final String source = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.";
  static final String target = "9M246d7mYJcCXL3NuTEzxioeKlfGpkBUHhQrFvO8Syt5qnbIAWVasj1R0Zw.gPD";

  public static String obfuscate(String s) 
  {
      char[] result= new char[s.length()];
      for (int i=0;i<s.length();i++) {
          char c=s.charAt(i);
          int index=source.indexOf(c);
          result[i]=target.charAt(index);
      }

      return new String(result);
  }

  public static String unobfuscate(String s) 
  {
      char[] result= new char[s.length()];
      for (int i=0;i<s.length();i++) {
          char c=s.charAt(i);
          int index=target.indexOf(c);
          result[i]=source.charAt(index);
      }

      return new String(result);
  }
}