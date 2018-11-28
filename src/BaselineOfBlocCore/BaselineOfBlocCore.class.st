Class {
	#name : #BaselineOfBlocCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocCore
}

{ #category : #baselines }
BaselineOfBlocCore >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		postLoadDoIt: #postLoadBloc:;

		"GT-Examples is examples and testing framework"
		baseline: 'GToolkitExamplesEngine' with: [ spec 
			repository: 'github://feenkcom/gtoolkit-examples/src' ];
						
		"main core package, implements element composition, event handling and universe infrastructure.
		*core* must not depend on anything"
		package: #Bloc;
		package: #'BlocHost-Mock' with: [ spec requires: #(Bloc) ];
		package: #'Bloc-Tests' with: [ spec 
			requires: #(Bloc GToolkitExamplesEngine 'BlocHost-Mock') ]
	]
]

{ #category : #actions }
BaselineOfBlocCore >> postLoadBloc: aSpecLoader [

	"register right Meta key for OSX"
	Key macOSVirtualKeyTable
		at: 16r36 put: (Key value: 16rffe8). "  kVK_Command_R = 0x36"
]
