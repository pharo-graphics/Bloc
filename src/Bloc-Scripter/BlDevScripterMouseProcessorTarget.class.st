Class {
	#name : 'BlDevScripterMouseProcessorTarget',
	#superclass : 'BlDevScripterEventProcessorTarget',
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterMouseProcessorTarget >> findTargetStartingInSpace: aSpace [
	^ aSpace mouseProcessor
]

{ #category : 'accessing' }
BlDevScripterMouseProcessorTarget >> identifier [
	^ 'mouse processor'
]

{ #category : 'printing' }
BlDevScripterMouseProcessorTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Mouse Processor'.
]
