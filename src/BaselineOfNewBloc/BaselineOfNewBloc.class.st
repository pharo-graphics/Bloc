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
				package: #'Bloc-Spec2';
				package: #'Bloc-PharoExtensions';
				package: #'Bloc-Spec2-Tests' with: [
					spec requires: #('Bloc-Spec2') ];

				package: #'BlocHost-Mock' with: [
					spec requires: #(#'BlocLayout') ];
				package: #'Bloc-Exporter' with: [
					spec requires: #(#'BlocLayout' #'BlocSparta') ];

				package: #'Bloc-DevTool' with: [
					spec requires: #(#'BlocLayout') ];
				package: #'Bloc-Scripter' with: [
					spec requires: #(#'BlocLayout' #'Bloc-Exporter' #'BlocHost-Mock') ];

				package: #'Bloc-Examples' with: [
					spec requires: #(#'Bloc-DevTool') ]";
				package: #'Bloc-Compositor-Examples' with: [
					spec requires: #(#'Bloc-Examples') ];
				package: #'Bloc-Text-Examples' with: [
					spec requires: #(#'Bloc-Examples') ]"

			].
]
