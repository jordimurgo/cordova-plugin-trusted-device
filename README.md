## Trusted Device Plugin for Apache Cordova (Jailbreak/Root Detection)

## Inspired from 

    * https://github.com/jimmyliao/cordova-plugin-device-detection
    * https://github.com/trykovyura/cordova-plugin-jailbreak-detection
    * https://github.com/lcaprini/it.lcaprini.cordova.plugins.unlocksdetector

## Install

### Locally

```
cordova plugin add https://appverse.gftlabs.com/git/scm/devltools/cordova-plugin-trusted-device.git
```

## Usage

## isTrusted
```js
window.plugins.trustedDevice.isTrusted(onSuccess, onFail);
```

- => `successCallback` is called with `true` if the device is is Trusted (not Rooted or Jailbroken), otherwise `false`
- => `failureCallback` is called if there was an error determining if the device is Trusted

## Platform Support

Android.
iOS.

## License

[MIT License](http://ilee.mit-license.org)
