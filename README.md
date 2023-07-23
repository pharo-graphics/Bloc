# Bloc 

[![License](https://img.shields.io/github/license/pharo-graphics/Bloc.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml)

Bloc is a low-level UI infrastructure & framework for [Pharo](http://pharo.org/).

:warning:
This repository contains the code for Bloc that will included in the future in Pharo.
It retrofits a part of the development made at https://github.com/feenkcom/bloc. This version will focus on core features and stability. We are currently identifying the core we want for Pharo.

You can join the mailing-list lse-openbloc@inria.fr from http://sympa.inria.fr.

## Installation

The following script installs Bloc in [Pharo 11](https://pharo.org/download):

```smalltalk
[ Metacello new
	baseline: 'Bloc';
	repository: 'github://pharo-graphics/Bloc:dev-1.0/src';
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
