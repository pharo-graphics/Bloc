Class {
	#name : #BaselineOfBlocCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocCore
}

{ #category : #baseline }
BaselineOfBlocCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadBloc:'.
		spec baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.4.4/src' ].
		spec 
			package: #Bloc;
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc #GToolkitExamplesEngine 'BlocHost-Mock' ). ]. ].

]

{ #category : #actions }
BaselineOfBlocCore >> postLoadBloc: aSpecLoader [

	"register right Meta key for OSX"
	Key macOSVirtualKeyTable
		at: 16r36 put: (Key value: 16rffe8). "  kVK_Command_R = 0x36"
]
