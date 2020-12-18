"
!Bloc

Bloc is a graphical framework that is drawing agnostic. The concrete drawing is achieved through the binding to the Sparta canvas. See ${class:BaselineOfSparta}$ for more details.

The central concept is ${class:BlElement}$.

!!Organization

The packages of Bloc are organized as follows. The visualization also shows the depended projects in gray: ${class:BaselineOfBloc|show=#gtPackagesMapFor:|expanded=true}$

!!Tutorial

You can learn Bloc following a memory game tutorial: ${icebergFile:path=feenkcom/Bloc/doc/tutorial-memory-game/00-memory-game.pillar}$.

"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBloc
}

{ #category : #baseline }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster/src' ];
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin/src' ].
		
		spec 
			package: #Bloc with: [
				spec requires: #(#Beacon GToolkitFenster) ];
			package: #'Bloc-Animation' with: [
				spec requires: #(#Bloc) ];
			package: #'Bloc-Layout' with: [
				spec requires: #(#Bloc) ];
			package: #'Bloc-Layout-Tests' with: [
				spec requires: #('Bloc-Layout') ];
			package: #'Bloc-Text' with: [
				spec requires: #('Bloc'). ];
			package: #'Bloc-Text-Rope' with: [
				spec requires: #('Bloc' 'Bloc-Text') ];
			package: #'Bloc-Text-Elements' with: [
				spec requires: #('Bloc' 'Bloc-Text'). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc). ];
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#'Bloc') ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc 'BlocHost-Mock' ). ].
			
		spec 
			package: #'Bloc-Sparta' with: [
				spec requires: #(#Bloc 'Bloc-Text' 'Sparta' 'Bloc-Compositor'). ];
			package: #'Bloc-Exporter' with: [
				spec requires: #(#Bloc 'Bloc-Sparta' ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #(#Bloc #'Bloc-Layout'). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('Bloc' 'Bloc-Text' 'Bloc-DevTool'). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc). ];
			package: #'BlocHost-Glutin' with: [
				spec requires: #(#Bloc #GToolkitFenster #Glutin) ].
		
		"Compositor"
		spec
			package: #'Bloc-Compositor' with: [
				spec requires: #(#Bloc SpartaSkia). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #('Bloc-Compositor' 'Bloc-Examples'). ];
			package: #'Bloc-Compositor-GToolkit' with: [
				spec requires: #('Bloc-Compositor'). ].
		
		spec
			package: #'Bloc-Extensions' with: [
				spec requires: #('Bloc' 'Bloc-Sparta' #'Bloc-Animation' 'Bloc-DevTool' ). ] ].

]
