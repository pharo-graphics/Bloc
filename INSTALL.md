# Installation

## OSX

1. Download Pharo 6.1 for OSX (http://files.pharo.org/platform/Pharo6.1-mac.zip)
2. Extract `Pharo6.1.app` from the archive and copy it to `~/Applications`
3. Run `Pharo6.1.app`. Depending on your security preferences Pharo may fail to launch because "it is from an unidentified developer". In this case you can go to `System Preferences > Security & Privacy > General` and click "Open Anyway" where it says that "Pharo6.1.app was blocked from opening ...". Click "Open" in confirmation dialog window. Pharo should now dissapear.
Now you will be able to launch `Pharo6.1.app` as usual from `Applications`.
4. Open `Playground`. It can be launched from the `World menu`: Left mouse click anywhere on the background around `Welcome in Pharo6.1` window and select `Playground`.
5. Copy the following installation script in Playground and execute it (either by selecting everything and doing `CMD+d` or clicking green play button).
```smalltalk
Metacello new
   baseline: 'Bloc';
   repository: 'github://pharo-graphics/Bloc/src';
   load: #core
```
6. During installation you may be asked to enter your `Author` name. You should put either you nickname or a real name like `JaneRoe` that will help other developers identify your code.
7. If evertyhing went OK, a new `World Menu` item should appear named `Bloc`. Done!
