Class {
	#name : #BaselineOfBlocMorphic,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocMorphic
}

{ #category : #baseline }
BaselineOfBlocMorphic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ];
			baseline: 'Fenster' with: [
				spec repository: 'github://pharo-graphics/fenster/src' ].

		spec 
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#BlocCore #Fenster) ] ].
]
