Class {
	#name : #BaselineOfBlocExtensions,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExtensions
}

{ #category : #baseline }
BaselineOfBlocExtensions >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'NewBloc' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ].

		spec package: #'Bloc-Extensions' with: [
				spec requires: #('NewBloc'). ] ]
]
