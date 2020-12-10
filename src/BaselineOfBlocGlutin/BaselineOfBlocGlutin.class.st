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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster/src' ];
			baseline: 'Glutin' with: [
				spec repository: 'github://feenkcom/gtoolkit-glutin/src' ].
		
		spec
			package: #'BlocHost-Glutin' with: [
				spec requires: #(#BlocCore #GToolkitFenster #Glutin) ] ]
]
