Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacScripter' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ];
			baseline: 'BlocPacResizable' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ].

		spec 
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #(#'Bloc' #'BlocPacScripter'). ];
			package: #'Bloc-Examples' with: [
				spec requires: #(#'Bloc' #'BlocPacScripter' #'BlocPacResizable' #'GToolkitExamplesEngine') ] ].
]
