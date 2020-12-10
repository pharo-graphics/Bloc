Class {
	#name : #BaselineOfBlocOSWindow,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocOSWindow
}

{ #category : #baseline }
BaselineOfBlocOSWindow >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster/src' ].

		spec
			package: #'BlocHost-OSWindow' with: [
				spec requires: #(#BlocCore #GToolkitFenster #Beacon). ];
			package: #'BlocHost-OSWindow-SDL2' with: [
				spec requires: #(#'BlocHost-OSWindow'). ] ].
]
