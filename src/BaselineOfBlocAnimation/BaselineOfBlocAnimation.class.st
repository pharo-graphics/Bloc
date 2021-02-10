Class {
	#name : #BaselineOfBlocAnimation,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocAnimation
}

{ #category : #baseline }
BaselineOfBlocAnimation >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ].
		spec 
			package: #'Bloc-Animation' with: [
				spec requires: #(#BlocCore ). ] ].
]
