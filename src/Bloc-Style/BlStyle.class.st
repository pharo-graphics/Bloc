Class {
	#name : #BlStyle,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declaration',
		'conditions',
		'ordinal'
	],
	#category : 'Bloc-Style-Util'
}

{ #category : #comparing }
BlStyle >> < aStyle [
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)
]

{ #category : #comparing }
BlStyle >> <= aStyle [
	^ ((self compareTo: aStyle) = 1) not
]

{ #category : #comparing }
BlStyle >> = aStyle [
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]
]

{ #category : #comparing }
BlStyle >> > aStyle [
	^ (self compareTo: aStyle) = 1 or: (self specificity = aStyle specificity and: self ordinal > aStyle ordinal)
]

{ #category : #comparing }
BlStyle >> >= aStyle [
	^ (self compareTo: aStyle) != -1
]

{ #category : #comparing }
BlStyle >> compareTo: aStyle [
	self isImportant = aStyle isImportant
		ifFalse: [ ^ self isImportant
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self origin = aStyle origin
		ifFalse:
			[ ^ (self origin priority >= aStyle origin priority and: [ self specificity >= aStyle specificity ])
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self specificity = aStyle specificity
		ifFalse: [ ^ self specificity >= aStyle specificity
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	^ 0
]

{ #category : #accessing }
BlStyle >> conditions [
	^ conditions
]

{ #category : #accessing }
BlStyle >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
BlStyle >> declaration [
	^ declaration
]

{ #category : #accessing }
BlStyle >> declaration: anObject [
	declaration := anObject
]

{ #category : #testing }
BlStyle >> isImportant [
	^ declaration isImportant
]

{ #category : #testing }
BlStyle >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
]

{ #category : #accessing }
BlStyle >> ordinal [
	^ ordinal
]

{ #category : #accessing }
BlStyle >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
BlStyle >> origin [
	^ selector origin
]

{ #category : #printing }
BlStyle >> printOn: aStream [
	self declaration printOn: aStream
]

{ #category : #accessing }
BlStyle >> selector [
	^ selector
]

{ #category : #accessing }
BlStyle >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
BlStyle >> specificity [
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
]
