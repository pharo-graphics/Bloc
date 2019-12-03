Class {
	#name : #BlUseAsyncFeatures,
	#superclass : #DynamicVariable,
	#category : #'Bloc-TaskIt-Variables'
}

{ #category : #accessing }
BlUseAsyncFeatures class >> enabled [
	"Answer true if using async operations (TaskIt) is enabled in a particular process.
	The default is true."
	
	^ self value
		ifNil: [ true ]
		ifNotNil: [ :value | value ]
]

{ #category : #controlling }
BlUseAsyncFeatures class >> ifEnabledDo: anAsyncBlock otherwise: aSyncBlock [
	^ self enabled 
		ifTrue: anAsyncBlock 
		ifFalse: aSyncBlock
]

{ #category : #accessing }
BlUseAsyncFeatures >> enabled [
	"Answer if converting to TaskIt is enabled.
	The default is true."
	
	^ self value
		ifNil: [ true ]
		ifNotNil: [ :value | value ]
]
