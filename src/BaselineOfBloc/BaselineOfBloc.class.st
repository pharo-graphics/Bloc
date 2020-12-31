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
		spec postLoadDoIt: #'postLoadBloc:'.

		spec 
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'Fenster' with: [
				spec repository: 'github://feenkcom/fenster/src' ];
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin/src' ].
		
		spec 
			package: #Bloc with: [
				spec requires: #(#Beacon Fenster) ];
			package: #'Bloc-Animation' with: [
				spec requires: #(#Bloc) ];
			package: #'Bloc-Layout' with: [ "animation is required by animated layouts"
				spec requires: #(#Bloc #'Bloc-Animation') ];
			package: #'Bloc-Layout-Tests' with: [
				spec requires: #('Bloc-Layout') ];
			package: #'Bloc-Text' with: [
				spec requires: #('Bloc'). ];
			package: #'Bloc-Text-Rope' with: [
				spec requires: #('Bloc' 'Bloc-Text') ];
			package: #'Bloc-Text-Elements' with: [
				spec requires: #('Bloc' 'Bloc-Text' 'Bloc-Text-Rope'). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc). ];
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#'Bloc') ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc 'BlocHost-Mock' ). ].
			
		spec 
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc). ];
			package: #'BlocHost-Glutin' with: [
				spec requires: #(#Bloc #Fenster #Glutin) ].
		
		"Compositor"
		spec
			package: #'Bloc-Compositor' with: [
				spec requires: #(#Bloc 'Sparta'). ].
			
		spec
			package: #'Bloc-Sparta' with: [
				spec requires: #('Sparta' 'Bloc' 'Bloc-Text' 'Bloc-Text-Elements' 'Bloc-Compositor'). ];
			package: #'Bloc-Exporter' with: [
				spec requires: #(#Bloc 'Bloc-Sparta' ). ].

		spec
			package: #'Bloc-DevTool' with: [
				spec requires: #(#Bloc #'Bloc-Layout' 'Bloc-Text-Elements' 'Bloc-Text-Rope'). ];
			package: #'Bloc-Scripter' with: [
				spec requires: #(#Bloc #'Bloc-Layout' #'Bloc-Exporter' #'BlocHost-Mock'). ] ].
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadMorphicHost: spec
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadMorphicHost: spec [

	"This will select an appropriate UI manager"
	SystemVersion current major < 8
		ifTrue: [ UIManager default: UIManager forCurrentSystemConfiguration ]
]
