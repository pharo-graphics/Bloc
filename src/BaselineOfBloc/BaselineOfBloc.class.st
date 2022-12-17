"
This Baseline contains the code for Bloc that may be included in the future in Pharo. 
It retrofits a part of the development made at http://github.com/feenkcom/bloc.
This version will focus on core features and stability.
We are currently identifying the core we want for Pharo.

See BaselineOfBloc for more information about Bloc in general.

"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfBloc
}

{ #category : #baseline }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [

			"Bloc-Display"
			spec
				package: 'Bloc-Display';
				package: 'Bloc-Display-Tests' with: [ spec requires: #('Bloc-Display') ].

			"Core"
			spec 
				package: #Bloc with: [
					spec requires: #('Bloc-Display') ];
				package: #'BlocHost-Mock' with: [
					spec requires: #(#Bloc) ];
				package: #'Bloc-Tests' with: [
					spec requires: #(#Bloc 'BlocHost-Mock' ). ].

			"Animation"
			spec 
				package: #'Bloc-Animation' with: [
					spec requires: #('Bloc') ].

			"Morphic host"
			spec 
				package: #'BlocHost-Morphic' with: [
					spec requires: #('Bloc') ] .

			"OSWindow host"
			spec
				package: #'BlocHost-OSWindow' with: [
					spec requires: #('Bloc'). ];
				package: #'BlocHost-OSWindow-SDL2' with: [
					spec requires: #('BlocHost-OSWindow'). ].

			"Text"
			spec 
				package: #'Bloc-Text' with: [
					spec requires: #('Bloc'). ];
				package: #'Bloc-Text-Rope' with: [
					spec requires: #('Bloc' 'Bloc-Text') ];
				package: #'Bloc-Text-Elements' with: [
					spec requires: #('Bloc' 'Bloc-Text') ];
				package: #'Bloc-Text-Rope-Tests' with: [
					spec requires: #('Bloc-Text-Rope') ].

			"Sparta canvas"
			spec
				baseline: 'Sparta' with: [
					spec repository: 'github://pharo-graphics/Sparta:dev-1.0/src' ].
			spec
				package: #'Bloc-Compositor' with: [
					spec requires: #('Bloc' 'Sparta') ];
				package: #'Bloc-Sparta' with: [
					spec requires: #('Sparta' 'Bloc' 'Bloc-Text' 'Bloc-Compositor') ].

			"Alexandrie canvas"
			spec
				baseline: 'Alexandrie' with: [
					spec repository: 'github://pharo-graphics/Alexandrie:master/src' ].
			spec
				package: #'Bloc-Alexandrie' with: [
					spec requires: #('Alexandrie' 'Bloc' 'Bloc-Text') ];
				package: #'Bloc-Alexandrie-Tests' with: [
					spec requires: #('Bloc-Alexandrie') ].

			"Layout"
			spec 
				package: #'Bloc-Layout' with: [
					spec requires: #('Bloc') ];
				package: #'Bloc-LayoutZoomable' with: [
					spec requires: #('Bloc-Layout' 'Bloc-Animation') ];
				"Layout depends also on compositor. See https://github.com/pharo-graphics/Bloc/issues/87"
				package: #'Bloc-Layout-Tests' with: [
					spec requires: #('Bloc-Layout' 'Bloc-Text') ].
				"package: #'Bloc-Layout-Examples' with: [
					spec requires: #('Bloc-Layout') ]."

			"Calypso & Spec2 Extensions"
			spec 
				package: #'Bloc-Spec2';
				package: #'Bloc-PharoExtensions';
				package: #'Bloc-Spec2-Tests' with: [
					spec requires: #('Bloc-Spec2') ].
				
			"Extra"
			spec 
				package: #'Bloc-UnitedTests' with: [
					spec requires: #('Bloc' 'Bloc-Layout' 'Bloc-Animation') ];
				package: #'Bloc-Exporter' with: [
					spec requires: #('Sparta') ];
				package: #'Bloc-DevTool' with: [
					spec requires: #('Bloc-Layout' 'Bloc-UnitedTests') ];
				package: #'Bloc-Scripter' with: [
					spec requires: #('Bloc-Layout' 'Bloc-Exporter' 'BlocHost-Mock' 'Bloc-UnitedTests') ].

			spec
				package: #'Bloc-Examples' with: [
					spec requires: #(#'Bloc-DevTool') ];
				package: #'Bloc-Compositor-Examples' with: [
					spec requires: #(#'Bloc-Examples') ];
				package: #'Bloc-Text-Examples' with: [
					spec requires: #(#'Bloc-Examples') ]

			].
]
