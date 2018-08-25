Class {
	#name : #BaselineOfBlocLayout,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocLayout
}

{ #category : #baselines }
BaselineOfBlocLayout >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		baseline: 'BlocCore' with: [ spec
			repository: 'github://pharo-graphics/Bloc/src' ];

		"GT-Examples is examples and testing framework"
		baseline: 'GToolkitExamplesEngine' with: [ spec repository: 'github://feenkcom/gtoolkit-examples/src' ];
	
		"contains most common layout types. May be optional"
		package: #'Bloc-Layout' with: [ spec requires: #(BlocCore) ];
		package: #'Bloc-Layout-Tests' with: [ spec requires: #('Bloc-Layout' GToolkitExamplesEngine) ]
	]
]
