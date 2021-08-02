Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:main/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:main/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:feenk102' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:main/src' ].
		spec 
			package: #'Bloc-Text-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Layout-Examples' with: [
				spec requires: #('Bloc' 'GToolkitExamplesEngine' ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #('Bloc' #'Bloc-Examples' ). ];
			package: #'Bloc-Docs' with: [
				spec requires: #('Bloc' ). ]. ].

]
