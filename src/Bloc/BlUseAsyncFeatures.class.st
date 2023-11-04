"
I define whether asynchronous features should be used and a code execution therefore should be triggered in different processes.

All code that trigger async executions should use one of my class side methods:

- {{gtMethod:BlUseAsyncFeatures class>>#ifEnabledDo:otherwise:}}
- {{gtMethod:BlUseAsyncFeatures class>>#ifEnabledDo:}}
- {{gtMethod:BlUseAsyncFeatures class>>#ifDisabledDo:}}

In the cases where the async should be disabled, {{gtMethod:BlUseAsyncFeatures class>>#disableDuring:}} should be used.


"
Class {
	#name : #BlUseAsyncFeatures,
	#superclass : #DynamicVariable,
	#category : 'Bloc-Space - Tasks'
}

{ #category : 'controlling' }
BlUseAsyncFeatures class >> disableDuring: aBlock [
	^ self value: false during: aBlock
]

{ #category : 'accessing' }
BlUseAsyncFeatures class >> enabled [
	"Answer true if using async operations (TaskIt) is enabled in a particular process.
	The default is true."
	
	^ self value
		ifNil: [ true ]
		ifNotNil: [ :value | value ]
]

{ #category : 'controlling' }
BlUseAsyncFeatures class >> ifDisabledDo: aSyncBlock [
	^ self ifEnabledDo: [ "do nothing" ] otherwise: aSyncBlock
]

{ #category : 'controlling' }
BlUseAsyncFeatures class >> ifEnabledDo: anAsyncBlock [
	^ self ifEnabledDo: anAsyncBlock otherwise: [ "do nothing" ]
]

{ #category : 'controlling' }
BlUseAsyncFeatures class >> ifEnabledDo: anAsyncBlock otherwise: aSyncBlock [
	^ self enabled 
		ifTrue: anAsyncBlock 
		ifFalse: aSyncBlock
]

{ #category : 'accessing' }
BlUseAsyncFeatures >> enabled [
	"Answer if converting to TaskIt is enabled.
	The default is true."
	
	^ self value
		ifNil: [ true ]
		ifNotNil: [ :value | value ]
]
