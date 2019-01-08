"
!Bloc

Bloc is a graphical framework that is drawing agnostic. The concrete drawing is achieved through the binding to the Sparta canvas. See ${class:BaselineOfSparta}$ for more details.

The central concept is ${class:BlElement}$.

!!Organization

The packages of Bloc are organized as follows. The visualization also shows the depended projects in gray.

${example:BaselineOfBloc class>>#itself|previewShow=#gtPackagesMapFor:|noCode=|previewHeight=300}$




"
Class {
	#name : #BaselineOfBloc,
	#superclass : #BaselineOf,
	#category : #BaselineOfBloc
}

{ #category : #accessing }
BaselineOfBloc class >> itself [
	<gtExample>
	^ self
]

{ #category : #baseline }
BaselineOfBloc >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc:v0.4.1/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://pharo-graphics/Bloc:v0.4.1/src' ];
			baseline: 'Sparta' with: [
				spec repository: 'github://syrel/Sparta:v0.4.1/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://sbragagnolo/taskit:v1.0.1' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.4.1/src' ].
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
			package: #'Bloc-Extensions' with: [
				spec requires: #('BlocCore' 'Bloc-Sparta' 'Bloc-Animation' 'Bloc-DevTool' ). ];
			package: 'Bloc-TaskIt' with: [
				spec requires: #('TaskIt' 'BlocCore' #'Bloc-Animation' #'Bloc-Text-Elements' ). ]. ].

]
