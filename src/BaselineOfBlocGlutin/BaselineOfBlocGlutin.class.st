Class {
	#name : #BaselineOfBlocGlutin,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocGlutin
}

{ #category : #baseline }
BaselineOfBlocGlutin >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ];
			baseline: 'Fenster' with: [
				spec repository: 'github://feenkcom/fenster/src' ];
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin/src' ].

		spec
			package: #'BlocHost-Glutin' with: [
				spec requires: #(#BlocCore #Fenster #Glutin) ] ]
]
