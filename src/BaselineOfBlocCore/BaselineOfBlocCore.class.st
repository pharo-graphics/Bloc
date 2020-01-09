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
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ];
			baseline: 'GToolkitResourcesUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'GToolkitFenster' with: [
				spec repository: 'github://feenkcom/gtoolkit-fenster/src' ].
		spec 
			package: #Bloc with: [
				spec requires: #(#Beacon GToolkitFenster) ];
			package: #'BlocHost-Mock' with: [
				spec requires: #(#Bloc ). ];
			package: #'Bloc-Tests' with: [
				spec requires: #(#Bloc #GToolkitExamplesEngine 'BlocHost-Mock' ). ]. ].

]
