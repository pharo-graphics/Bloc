"
!Bloc

Bloc is a graphical framework that is drawing agnostic. The concrete drawing is achieved through the binding to the Sparta canvas. See ${class:BaselineOfSparta}$ for more details.

The central concept is ${class:BlElement}$.

!!Organization

The packages of Bloc are organized as follows. The visualization also shows the depended projects in gray: ${class:BaselineOfBloc|show=#gtPackagesMapFor:|expanded=true}$


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
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://sbragagnolo/taskit:v1.0.1' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ];
			baseline: 'OSWindowGlutin' with: [
				spec repository: 'github://feenkcom/oswindow-glutin/src' ].
		spec 
			package: #'Bloc-Geometry' with: [
				spec requires: #(#BlocCore ). ];
			package: #'Bloc-Animation' with: [
				spec requires: #(#BlocCore ). ];
			package: #'Bloc-Infinite' with: [
				spec requires: #(#BlocCore 'Bloc-Animation' ). ];
			package: #'Bloc-Infinite-Layouts' with: [
				spec requires: #('Bloc-Infinite' ). ];
			package: #'Bloc-Animation-Tests' with: [
				spec requires: #('Bloc-Animation' #GToolkitExamplesEngine ). ];
			package: #'Bloc-Text' with: [
				spec requires: #(#BlocCore ). ];
			package: #'Bloc-Text-Rope' with: [
				spec requires: #(#BlocCore 'Bloc-Text' ). ];
			package: #'Bloc-Text-Elements' with: [
				spec requires: #(#BlocCore 'Bloc-Text' 'Bloc-Text-Rope' ). ];
			package: #'Bloc-Sparta' with: [
				spec requires: #(#BlocCore 'Bloc-Text' #Sparta ). ];
			package: #'Bloc-Exporter' with: [
				spec requires: #(#BlocCore 'Bloc-Sparta' ). ];
			package: #'Bloc-DevTool' with: [
				spec requires: #(#BlocCore #BlocLayout ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('GToolkitExamplesEngine' 'BlocLayout' 'Bloc-Geometry' 'Bloc-Infinite' 'Bloc-Infinite-Layouts' 'Bloc-DevTool' 'Bloc-Text-Elements' ). ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#BlocCore ). ];
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#BlocCore ). ];
			package: #'BlocHost-OSWindow' with: [
				spec requires: #(#BlocCore 'Bloc-Sparta'). ];
			package: #'BlocHost-OSWindow-Glutin' with: [
				spec requires: #('BlocHost-OSWindow' OSWindowGlutin). ];
			package: #'Bloc-Extensions' with: [
				spec requires: #('BlocCore' 'Bloc-Sparta' 'Bloc-Animation' 'Bloc-DevTool' ). ];
			package: 'Bloc-TaskIt' with: [
				spec requires: #('TaskIt' 'BlocCore' #'Bloc-Animation' #'Bloc-Text-Elements' ). ]. ].

]

{ #category : #'post load' }
BaselineOfBloc >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadDisableTaskItDebugger: spec.
	self postLoadMorphicHost: spec
	
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadDisableTaskItDebugger: spec [
	TKTConfiguration profile: TKTProfile test.
	TKTDebugger disable.
]

{ #category : #'post load' }
BaselineOfBloc >> postLoadMorphicHost: spec [
	BlBlocMorphicUIManager useAsDefault
]
