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
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'Bloc-Layout' with: [
				spec requires: #(#BlocCore ). ];
			package: #'Bloc-Layout-Tests' with: [
				spec requires: #('Bloc-Layout'). ]. ].
]
