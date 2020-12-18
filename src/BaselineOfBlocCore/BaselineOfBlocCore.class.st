Class {
	#name : #BaselineOfBlocCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocCore
}

{ #category : #baseline }
BaselineOfBlocCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Beacon' with: [
				self repository: 'github://feenkcom/pharo-beacon/repository' for: spec ];
			baseline: 'GToolkitFenster' with: [
				self repository: 'github://feenkcom/gtoolkit-fenster/src' for: spec ].
		spec 
			package: #Bloc with: [
				spec requires: #(#Beacon GToolkitFenster) ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc 'BlocHost-Mock' ). ]. ].
]
