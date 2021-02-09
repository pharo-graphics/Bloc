Class {
	#name : #BaselineOfBlocText,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocText
}

{ #category : #baseline }
BaselineOfBlocText >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ].
		spec 
			package: #'Bloc-Text' with: [
				spec requires: #('BlocCore'). ];
			package: #'Bloc-Text-Rope' with: [
				spec requires: #('BlocCore' 'Bloc-Text') ];
			package: #'Bloc-Text-Elements' with: [
				spec requires: #('BlocCore' 'Bloc-Text'). ]. ]
]
