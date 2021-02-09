Class {
	#name : #BaselineOfBlocMorphic,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocMorphic
}

{ #category : #baseline }
BaselineOfBlocMorphic >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://pharo-graphics/Bloc/src' ];
			baseline: 'Fenster' with: [
				spec repository: 'github://feenkcom/fenster/src' ].

		spec 
			package: #'BlocHost-Morphic' with: [
				spec requires: #(#BlocCore #Fenster) ] ].
]

{ #category : #'post load' }
BaselineOfBlocMorphic >> postLoadBloc: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadMorphicHost: spec
]

{ #category : #'post load' }
BaselineOfBlocMorphic >> postLoadMorphicHost: spec [

	"This will select an appropriate UI manager"
	SystemVersion current major < 8
		ifTrue: [ UIManager default: UIManager forCurrentSystemConfiguration ]
]
