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
				spec repository: 'github://pharo-graphics/Bloc/src' ];
			baseline: 'BlocAnimation' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ].
		spec 
			package: #'Bloc-Layout' with: [
				spec requires: #(#BlocCore #BlocAnimation). ];
			package: #'Bloc-Layout-Examples' with: [
				spec requires: #('Bloc-Layout'). ]. ].
]
