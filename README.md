# Bloc 

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains the code for Bloc that may be included in the future in Pharo.
It retrofits a part of the development made at https://github.com/feenkcom/bloc. This version will focus on core features and stability. We are currently identifying the core we want for Pharo.

## Available Canvas and Hosts

The **HOST** of a Bloc space determines how will be the concrete window with the surface that will show the rendered elements.

The **CANVAS** of a Bloc space (or host space) determines which graphic library will be used to render each frame.


[Sparta](https://github.com/pharo-graphics/sparta/) provides two options to render the spaces: Sparta-Cairo and Sparta-Skia.
We recently introduced the [Alexandrie](https://github.com/pharo-graphics/Alexandrie) canvas based on Cairo. 

The most relevant hosts that are available on this version of Bloc are:
- `BlOSWindowSDL2Host` (a native OS window)
- `BlMorphicWindowHost` (a window in current Morphic world)

The host should be independent from the canvas. But reality is that to enable the new Alexandrie canvas, we had to workaround some dependency issues, be introducing two analog hosts that forces to open the window with Alexandrie as the canvas:
- `BAOSWindowSDL2Host`
- `BAMorphicWindowHost`

Only the second letter of the class name changes. Some `use`-prefixed methods let specify easily the combinations of host and canvas: 
```smalltalk
"Sparta-Cairo canvas on a SDL2 host."
Bloc useCairoSpartaCanvas.
BlSpace new useSpartaOSWindowSDL2Host; show

"Sparta-Skia canvas on a Morphic host:"
Bloc useSkiaSpartaCanvas.
BlSpace new useSpartaMorphicWindowHost; show

"Alexandrie canvas on a SDL2 host:"
BlSpace new useAlexandrieOSWindowSDL2Host; show

"Alexandrie canvas on a Morphic host:"
BlSpace new useAlexandrieMorphicWindowHost; show
```


## Installation

The following script installs Bloc in [Pharo 11](https://pharo.org/download):

```smalltalk
[ Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:master/src';
	onConflictUseIncoming;
	ignoreImage;
	load ]
		on: MCMergeOrLoadWarning
		do: [ :warning | warning load ]
```

Alternatively, you can do it by terminal (MacOS, linux... and should work as well in Windows with MINGW64). 
Create a directory and execute `<this_repo>/scripts/build.sh`, which first downloads the Pharo image and VM and then loads the project.


## License and Contributing

This code is licensed under the [MIT license](./LICENSE).

If you want to contribute to the project, please read our [contributing guide](./CONTRIBUTING.md).
