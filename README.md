## Trusted Device Plugin for Apache Cordova (Jailbreak/Root Detection)

## Based on

  * https://github.com/Appverse/appverse-mobile/blob/master/appverse-platform-android/src/com/gft/unity/android/AndroidSecurity.java
  * https://github.com/jimmyliao/cordova-plugin-device-detection
  * https://github.com/trykovyura/cordova-plugin-jailbreak-detection
  * https://github.com/lcaprini/it.lcaprini.cordova.plugins.unlocksdetector

## Install

### Locally

```
cordova plugin add https://appverse.gftlabs.com/git/scm/appverse/cordova-plugin-trusted-device.git
```

## Usage

## isTrusted
```js
trustedDevice.isTrusted(onSuccess, onFail);
```

- => `onSuccess` is called with `true` if the device is is Trusted (not Rooted or Jailbroken), otherwise `false`
- => `onFail` is called if there was an error determining if the device is Trusted

## Supported platforms
* iOS
* Android

## License

     Copyright (c) 2015 GFT Appverse, S.L., Sociedad Unipersonal

     This Source  Code Form  is subject to the  terms of  the Appverse Public License
     Version 2.0  ("APL v2.0").  If a copy of  the APL  was not  distributed with this
     file, You can obtain one at <http://appverse.org/#/license/information>.

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
     
