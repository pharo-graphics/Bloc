Class {
	#name : 'BlDevScripterFocusProcessorTarget',
	#superclass : 'BlDevScripterEventProcessorTarget',
	#category : 'Bloc-Scripter-Scripter-Targets',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterFocusProcessorTarget >> findTargetStartingInSpace: aSpace [
	^ aSpace focusProcessor
]

{ #category : 'accessing' }
BlDevScripterFocusProcessorTarget >> identifier [
	^ 'focus processor'
]

{ #category : 'printing' }
BlDevScripterFocusProcessorTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Focus Processor'.
]
