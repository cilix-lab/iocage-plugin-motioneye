# iocage-plugin-motioneye

Artifact repo for iocage MotionEye plugin.

## Documentation

Official documentation for MotionEye can be found [here](https://github.com/motioneye-project/motioneye/wiki).

Most settings can be set from the web GUI as describen in [MotionEye's](https://github.com/motioneye-project/motioneye/tree/dev) offical repository.

The initial log-in until modified is user: 'admin' and password is blank.

## Settings

The only configuration that can be set for the plugin is the listening port with the `port` keyword.

Assuming your plugin jail is called "motioneye" you can set it by calling something along the lines of:

```
iocage set -P port=8765 motioneye
```


