Class {
	#name : #BlSignalProgress,
	#superclass : #DynamicVariable,
	#category : #'Bloc-TaskIt-Signals'
}

{ #category : #accessing }
BlSignalProgress class >> enabled [
	"Answer if Task progress should be signalled.
	The default is false."
	
	^ self value
		ifNil: [ false ]
		ifNotNil: [ :value | value ]
]

{ #category : #accessing }
BlSignalProgress class >> ifEnabledDo: aBlock [
	"Evaluate the block if Task progress should be signalled.
	The default is no evaluation."
	
	^ self enabled 
		ifTrue: aBlock
		ifFalse: nil
]
