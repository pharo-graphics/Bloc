Class {
	#name : #BaselineOfBlocSparta,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocSparta
}

{ #category : #baseline }
BaselineOfBlocSparta >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Sparta' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocText' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].

		spec
			package: #'Bloc-Compositor' with: [
				spec requires: #('BlocCore' 'Sparta'). ].
			
		spec
			package: #'Bloc-Sparta' with: [
				spec requires: #('Sparta' 'BlocCore' 'BlocText' 'Bloc-Compositor'). ] ].
]
