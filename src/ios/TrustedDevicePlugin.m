//
//  JailbreakDetection.m
//  Copyright (c) 2014 Lee Crossley - http://ilee.co.uk
//  Techniques from http://highaltitudehacks.com/2013/12/17/ios-application-security-part-24-jailbreak-detection-and-evasion/
//
//  Adapted by Jordi Murgó <jordi.murgo@gft.com>

#import "Cordova/CDV.h"
#import "Cordova/CDVViewController.h"
#import "TrustedDevicePlugin.h"

@implementation TrustedDevicePlugin

- (void) isTrusted:(CDVInvokedUrlCommand*)command;
{
    CDVPluginResult *pluginResult;

    @try
    {
        bool jailbroken = [self jailbroken];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool: !jailbroken];
    }
    @catch (NSException *exception)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (bool) jailbroken {

#if !(TARGET_IPHONE_SIMULATOR)

    // Cydia APP
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"])
    {
        return YES;
    }

    // APT cmdline tools
    else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"])
    {
        return YES;
    }

    // Cydia 1.1.15 and earlier apps dir
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/stash"])
    {
        return YES;
    }

    // Cydia >=1.1.16 apps dir
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/db/stash"])
    {
        return YES;
    }

    // Cydia Substrate (MobileSubstrate) framework to patch apps
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"])
    {
        return YES;
    }

    // Sell? Busybox installed
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"])
    {
        return YES;
    }

    // SSHd
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"])
    {
        return YES;
    }

    // Snoop-it security tracer
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Snoop-it Config.app"])
    {
        return YES;
    }

    // is /system Writable?
    if ([[NSFileManager defaultManager] isWritableFileAtPath:@"/system"])
    {
        return YES;
    }

    // is /private Writable?
    if ([[NSFileManager defaultManager] isWritableFileAtPath:@"/private"])
    {
        return YES;
    }

#endif

    return NO;
}

@end
