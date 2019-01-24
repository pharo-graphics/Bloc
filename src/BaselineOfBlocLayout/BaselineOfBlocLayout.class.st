Class {
	#name : #BaselineOfBlocLayout,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocLayout
}

{ #category : #baseline }
BaselineOfBlocLayout >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc:v0.4.4/src' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.4.4/src' ].
		spec 
			package: #'Bloc-Layout' with: [
				spec requires: #(#BlocCore ). ];
			package: #'Bloc-Layout-Tests' with: [
				spec requires: #('Bloc-Layout' #GToolkitExamplesEngine ). ]. ].

]
