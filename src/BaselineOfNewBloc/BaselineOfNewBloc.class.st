"
This Baseline contains the code for Bloc that may be included in the future in Pharo. 
It retrofits a part of the development made at http://github.com/feenkcom/bloc.
This version will focus on core features and stability.
We are currently identifying the core we want for Pharo.

See BaselineOfBloc for more information about Bloc in general.

"
Class {
	#name : #BaselineOfNewBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfNewBloc
}

{ #category : #baseline }
BaselineOfNewBloc >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
				baseline: 'BlocLayout'
					with: [ spec repository: 'github://pharo-graphics/Bloc/src' ];
				baseline: 'BlocMorphic'
					with: [ spec repository: 'github://pharo-graphics/Bloc/src' ];
				baseline: 'BlocSparta'
					with: [ spec repository: 'github://pharo-graphics/Bloc/src' ];
				baseline: 'BlocOSWindow'
					with: [ spec repository: 'github://pharo-graphics/Bloc/src' ].
			spec
				group: 'default'
				with: #(BlocSparta BlocMorphic BlocLayout BlocOSWindow) ].

	spec
		for: #'pharo9.x'
		do: [
			spec 
				package: #'Bloc-Spec2';
				package: #'Bloc-PharoExtensions';
				package: #'Bloc-Spec2-Tests' with: [ spec requires: #('Bloc-Spec2' ) ].

			spec
				package: #'BlocHost-Mock' with: [ spec requires: #(#'BlocLayout'). ];
				package: #'Bloc-Exporter' with: [ spec requires: #(#'BlocLayout' #'BlocSparta') ];
				package: #'Bloc-Scripter' with: [
					spec requires: #(#'BlocLayout' #'Bloc-Exporter' #'BlocHost-Mock') ].

			spec
				group: 'default'
				with: #(#'Bloc-Scripter' 'Bloc-Spec2-Tests' BlocSparta BlocMorphic BlocLayout BlocOSWindow) ].
]
