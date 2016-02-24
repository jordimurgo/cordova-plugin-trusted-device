/*
 Copyright (c) 2016 GFT Appverse, S.L., Sociedad Unipersonal.
 
 This Source  Code Form  is subject to the  terms of  the Appverse Public License 
 Version 2.0  (“APL v2.0”).  If a copy of  the APL  was not  distributed with this 
 file, You can obtain one at http://appverse.org/legal/appverse-license/.
 
 Redistribution and use in  source and binary forms, with or without modification, 
 are permitted provided that the  conditions  of the  AppVerse Public License v2.0 
 are met.
 
 THIS SOFTWARE IS PROVIDED BY THE  COPYRIGHT HOLDERS  AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS  OR IMPLIED WARRANTIES, INCLUDING, BUT  NOT LIMITED TO,   THE IMPLIED
 WARRANTIES   OF  MERCHANTABILITY   AND   FITNESS   FOR A PARTICULAR  PURPOSE  ARE
 DISCLAIMED. EXCEPT IN CASE OF WILLFUL MISCONDUCT OR GROSS NEGLIGENCE, IN NO EVENT
 SHALL THE  COPYRIGHT OWNER  OR  CONTRIBUTORS  BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL,  SPECIAL,   EXEMPLARY,  OR CONSEQUENTIAL DAMAGES  (INCLUDING, BUT NOT
 LIMITED TO,  PROCUREMENT OF SUBSTITUTE  GOODS OR SERVICES;  LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT(INCLUDING NEGLIGENCE OR OTHERWISE) 
 ARISING  IN  ANY WAY OUT  OF THE USE  OF THIS  SOFTWARE,  EVEN  IF ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE.
*/

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
