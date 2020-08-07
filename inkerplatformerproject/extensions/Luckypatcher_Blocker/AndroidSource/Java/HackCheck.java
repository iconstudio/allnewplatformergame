package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.content.pm.ApplicationInfo;

import java.util.ArrayList;
import java.util.List;
import android.util.Log;

import java.security.MessageDigest;

public class HackCheck
{
	private final String luckypatcher_package[] = {
		"23XD4YX3LiY463DCx2cKN9z2m6T",
		"23XD2m6CNxEDC92cKN9z2m",
		"23XD9L4T3Y4Di6L4YL7DMYCCYL7DQLfNNGYCCYL7q6TiY26DvfpF",
		"23XD9L4T3Y4Di6L4YL7DMYCCYL7DQLfNNGYCCYL7q6TiY26DvSpF"
	};

	public double isLuckyPatcherInstalled()
	{
		for (int i = 0; i < luckypatcher_package.length; ++i) {
	    	if (packageExists(StringJumble.unobfuscate(luckypatcher_package[i]))) {
	    		return 1;
	    	}
	    }
	    return 0;
	}
	
	private boolean packageExists(String targetPackage){
        List<ApplicationInfo> packages;
		Context context = RunnerJNILib.ms_context;
	   PackageManager pm=context.getPackageManager();
        packages = pm.getInstalledApplications(0);
        for (ApplicationInfo packageInfo : packages) {

            if(packageInfo.packageName.equals(targetPackage)){
                return true;
            }
        }
        return false;
    }

	public double checkSignature(String obfuscatedCertificate)
	{
		Context context = RunnerJNILib.ms_context;
		String certificate = obfuscatedCertificate;

		return BTD(getSignature().equals(obfuscatedCertificate));
	}

	public double BTD(boolean b) 
	{
		return (b ? 1 : 0);
	}

	public String getSignature()
	{
		try
		{
			Context context = RunnerJNILib.ms_context;
			Signature[] signatures = context.getPackageManager().getPackageInfo(context.getPackageName(), PackageManager.GET_SIGNATURES).signatures;
			return createhash(StringJumble.obfuscate(signatures[0].toCharsString()));
		}
		catch (NameNotFoundException ex)
		{
			return "";
		}
		catch (Throwable e)
		{
			return e.getMessage();
		}
	}

	private String createhash(String str)
	{
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(str.getBytes("UTF-8")); // Change this to "UTF-16" if needed
			byte[] digest = md.digest();
			return String.format("%064x", new java.math.BigInteger(1, digest));
		} catch (Throwable e) {
			//
			return "";
		}
	}
}