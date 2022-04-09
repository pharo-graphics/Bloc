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

			"Core"
			spec 
				baseline: 'Fenster' with: [
					spec repository: 'github://pharo-graphics/fenster:v0.9.0/src' ];
				package: #Bloc with: [
					spec requires: #(#Fenster) ];
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
					spec requires: #('Bloc' 'Fenster') ] .

			"OSWindow host"
			spec
				package: #'BlocHost-OSWindow' with: [
					spec requires: #('Bloc' 'Fenster'). ];
				package: #'BlocHost-OSWindow-SDL2' with: [
					spec requires: #('BlocHost-OSWindow'). ].

			"Text"
			spec 
				package: #'Bloc-Text' with: [
					spec requires: #('Bloc'). ];
				package: #'Bloc-Text-Rope' with: [
					spec requires: #('Bloc' 'Bloc-Text') ];
				package: #'Bloc-Text-Elements' with: [
					spec requires: #('Bloc' 'Bloc-Text') ].

			"Sparta"
			spec 
				baseline: 'Sparta' with: [
					spec repository: 'github://pharo-graphics/Sparta:v0.9.0/src' ].
			spec
				package: #'Bloc-Compositor' with: [
					spec requires: #('Bloc' 'Sparta') ];
				package: #'Bloc-Sparta' with: [
					spec requires: #('Sparta' 'Bloc' 'Bloc-Text' 'Bloc-Compositor') ].

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
					spec requires: #('Bloc-Layout' 'Bloc-Exporter' 'BlocHost-Mock' 'Bloc-UnitedTests') ]"

			spec
				package: #'Bloc-Examples' with: [
					spec requires: #(#'Bloc-DevTool') ];
				package: #'Bloc-Compositor-Examples' with: [
					spec requires: #(#'Bloc-Examples') ];
				package: #'Bloc-Text-Examples' with: [
					spec requires: #(#'Bloc-Examples') ]"

			].
]
