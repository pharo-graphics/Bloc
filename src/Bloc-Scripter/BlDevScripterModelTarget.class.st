Class {
	#name : 'BlDevScripterModelTarget',
	#superclass : 'BlDevScripterTarget',
	#category : 'Bloc-Scripter-Scripter-Targets'
}

{ #category : 'searching' }
BlDevScripterModelTarget >> findTargetIn: anElement [
	<return: #BlElement>
	^ anElement devScripterData model
]

{ #category : 'searching' }
BlDevScripterModelTarget >> findTargetStartingInScripter: aScripter [
	^ aScripter model
]

{ #category : 'accessing' }
BlDevScripterModelTarget >> identifier [
	^ 'model'
]

{ #category : 'printing' }
BlDevScripterModelTarget >> printOn: aStream [
	aStream nextPutAll: 'Scripter Model'.
]

{ #category : 'updating' }
BlDevScripterModelTarget >> updateUsing: aScripterEventTarget on: aStep [
	| aNestedTarget |
	aNestedTarget := BlDevScripterNestedChildEventTarget new.
	aNestedTarget targets: { self. aScripterEventTarget }.
	aStep target: aNestedTarget.
]
