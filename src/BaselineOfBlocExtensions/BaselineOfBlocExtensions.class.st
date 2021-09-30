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
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].

		spec package: #'Bloc-Extensions' with: [
				spec requires: #('Bloc'). ] ]
]
