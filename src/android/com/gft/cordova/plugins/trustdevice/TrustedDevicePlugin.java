package com.gft.cordova.plugins.trustdevice;

import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.util.Log;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author Kevin Kowalewski
 * @author Jimmy Liao
 * @author Marga Parets
 * @author Francisco Javier Martin Bueno
 * @author Jordi Murgo
 */
public class TrustedDevicePlugin extends CordovaPlugin {

    final static String LOG_TAG = TrustedDevicePlugin.class.getName();

    /**
     * Execution entry point from javascript world.
     *
     * @param action          The action to execute ("isTrusted").
     * @param args            The exec() arguments (Ignored, no arguments).
     * @param callbackContext The callback context used when calling back into JavaScript.
     * @return resultStatus
     * @throws JSONException
     */
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        boolean resultStatus = false;
        if ("isTrusted".equals(action)) {
            callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, !isDeviceRooted()));
            resultStatus = true;
        }
        return resultStatus;
    }

    /**
     * Checks if device is Rooted ussing several tests.
     *
     * @return true = rooted; false = not rooted.
     */
    public boolean isDeviceRooted() {
        return isCustomAndroid() || isSuPresent() || isWriteAccessViolation() || isReadAccessViolation() || isRootAppInstalled();
    }

    /**
     * Custom, test and emulator android images contains "test-keys" string in Build Number info.
     *
     * @return true = test or custom or debug ROM.
     */
    public boolean isCustomAndroid() {
        String buildTags = android.os.Build.TAGS.toLowerCase();
        return buildTags != null && (buildTags.contains("test-keys") || buildTags.contains("debug") || buildTags.contains("custom"));
    }

    /**
     * Check su command in common paths.
     *
     * @return true = su is present.
     */
    public boolean isSuPresent() {
        String[] paths = {"/sbin/su", "/system/bin/su", "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
                "/system/bin/failsafe/su", "/data/local/su"};

        for (String path : paths) {
            File suBinary = new File(path);
            // Glubs!!
            if (suBinary.canExecute())
                return true;
            // Current SuperUser apps don't have 'su' executable for your userID
            // The permissions are changed during few seconds on app request to SuperUser
            if (suBinary.exists())
                return true;
        }
        return false;
    }

    /**
     * Check Write access in forbiden folders.
     *
     * @return true = have read access
     */
    private boolean isWriteAccessViolation() {
        String[] foldersToCheckWriteAccess = {
                "/data",
                "/",
                "/system",
                "/system/bin",
                "/system/sbin",
                "/system/xbin",
                "/vendor/bin",
                "/sys",
                "/sbin",
                "/etc",
                "/proc",
                "/dev"
        };

        try {
            for (String folder : foldersToCheckWriteAccess) {
                File file = new File(folder);
                if (file.canWrite()) {
                    return true;
                }
            }
        } catch (Exception e) {
        }
        return false;
    }

    /**
     * Check Read access in forbiden folders.
     *
     * @return true = have read access
     */
    private boolean isReadAccessViolation() {

        String[] foldersToCheckReadAccess = {
                "/data"
        };
        try {
            for (String folder : foldersToCheckReadAccess) {
                File file = new File(folder);
                if (file.canRead()) {
                    return true;
                }
            }
        } catch (Exception e) {
        }
        return false;
    }

    /**
     * Check if most common rooted apps are installed.
     *
     * @return true = rooted app installed.
     */
    private boolean isRootAppInstalled() {
        // Installed ussing adb shell
        try {
            File file = new File("/system/app/Superuser.apk");
            if (file.exists())
                return true;
        } catch (Exception e) {
        }

        String[] forbiddenInstalledPackages = {
                "com.noshufou.android.su",
                "com.thirdparty.superuser",
                "eu.chainfire.supersu",
                "com.koushikdutta.superuser",
                "com.zachspong.temprootremovejb",
                "com.ramdroid.appquarantine"
        };
        try {
            List<String> badApps = Arrays.asList(forbiddenInstalledPackages);
            List<ApplicationInfo> packages;
            PackageManager pm = webView.getContext().getPackageManager();
            packages = pm.getInstalledApplications(0);
            for (ApplicationInfo packageInfo : packages) {
                if (badApps.contains(packageInfo.packageName))
                    return true;
            }
        } catch (Exception e) {
        }
        return false;
    }
}
