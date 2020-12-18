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
			baseline: 'BlocCore' with: [
				self thisRepositoryFor: spec ];
			baseline: 'BlocLayout' with: [
				self thisRepositoryFor: spec ];
			baseline: 'BlocAnimation' with: [
				self thisRepositoryFor: spec ];
			baseline: 'BlocText' with: [
				self thisRepositoryFor: spec ];
			baseline: 'Sparta' with: [
				self repository: 'github://feenkcom/Sparta/src' for: spec ];
			baseline: 'SpartaSkia' with: [
				self repository: 'github://feenkcom/Sparta/src' for: spec ];
			
			"Glutin window host, provides OpenGL context and Window events"
			baseline: 'BlocGlutin' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'Bloc-Sparta' with: [
				spec requires: #(#BlocCore 'BlocText' 'Sparta' 'Bloc-Compositor'). ];
			package: #'Bloc-Exporter' with: [
				spec requires: #(#BlocCore 'Bloc-Sparta' ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #(#BlocCore #BlocLayout ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('BlocLayout' 'BlocText' 'Bloc-DevTool'). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#BlocCore ). ].
		
		"Compositor"
		spec
			package: #'Bloc-Compositor' with: [
				spec requires: #(#BlocCore SpartaSkia). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #('Bloc-Compositor' 'Bloc-Examples'). ];
			package: #'Bloc-Compositor-GToolkit' with: [
				spec requires: #('Bloc-Compositor'). ].
		
		spec
			package: #'Bloc-Extensions' with: [
				spec requires: #('BlocCore' 'Bloc-Sparta' #'BlocAnimation' 'Bloc-DevTool' ). ] ].

]
