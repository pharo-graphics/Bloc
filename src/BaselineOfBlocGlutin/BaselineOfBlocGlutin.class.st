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
				self thisRepositoryFor: spec ];
			baseline: 'GToolkitFenster' with: [
				self repository: 'github://feenkcom/gtoolkit-fenster/src' for: spec ];
			baseline: 'Glutin' with: [
				self repository: 'github://feenkcom/gtoolkit-glutin/src' for: spec ].
		
		spec
			package: #'BlocHost-Glutin' with: [
				spec requires: #(#BlocCore #GToolkitFenster #Glutin) ] ]
]
