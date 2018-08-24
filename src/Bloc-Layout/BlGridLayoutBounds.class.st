Class {
	#name : #BlGridLayoutBounds,
	#superclass : #Object,
	#instVars : [
		'before',
		'after',
		'flexibility'
	],
	#pools : [
		'BlGridLayoutConstants'
	],
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #accessing }
BlGridLayoutBounds class >> canStretch [
	^ BlGridFlexibility canStretch
]

{ #category : #accessing }
BlGridLayoutBounds class >> inflexible [
	^ BlGridFlexibility inflexible
]

{ #category : #accessing }
BlGridLayoutBounds class >> maxSize [
	^ 100000
]

{ #category : #testing }
BlGridLayoutBounds >> canStretch [
	^ flexibility = self class canStretch
]

{ #category : #accessing }
BlGridLayoutBounds >> includeBefore: newBefore after: newAfter [
]

{ #category : #accessing }
BlGridLayoutBounds >> includeElement: anElement spec: aSpec axis: anAxis size: size [
	| alignment newBefore newAfter |
	flexibility := flexibility and: aSpec flexibility.
	alignment := aSpec absoluteAlignment: anAxis horizontal.
	newBefore := alignment alignmentValue: anElement viewSize: size.
	newAfter := size - newBefore.
	
	before < newBefore
		ifTrue: [	 before := newBefore ].
	after < newAfter
		ifTrue: [ after := newAfter ].
		
	self includeBefore: newBefore after: newAfter
]

{ #category : #initialization }
BlGridLayoutBounds >> initialize [
	super initialize.
	
	self reset
]

{ #category : #accessing }
BlGridLayoutBounds >> offset: anElement alignment: anAlignment size: size [
	^ before - (anAlignment alignmentValue: anElement viewSize: size)
]

{ #category : #printing }
BlGridLayoutBounds >> printOn: aStream [
	aStream
		nextPutAll: 'before: ';
		nextPutAll: before asString;
		nextPutAll: ' after: ';
		nextPutAll: after asString;
		nextPutAll: ' size(false): ';
		nextPutAll: (self size: false) asString;
		nextPutAll: ' size(true): ';
		nextPutAll: (self size: true) asString
]

{ #category : #initialization }
BlGridLayoutBounds >> reset [
	before := UNDEFINED.
   after := UNDEFINED.
   flexibility := self class canStretch "we are flexible when empty"
]

{ #category : #accessing }
BlGridLayoutBounds >> size: min [
	^ (min not and: [ self canStretch ])
		ifTrue: [ self class maxSize ]
		ifFalse: [ before + after ]
]
