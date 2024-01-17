"
# Child bounds-based finder

I help users to find a child element within its parent based on the bounds constraints

"
Class {
	#name : 'BlChildBoundsBasedFinder',
	#superclass : 'Object',
	#instVars : [
		'fromIndex',
		'toIndex',
		'preferredConstraints',
		'acceptableConstraints'
	],
	#category : 'Bloc-Basic-Bounds',
	#package : 'Bloc',
	#tag : 'Basic-Bounds'
}

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> acceptableConstraints [

	^ acceptableConstraints
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> acceptableConstraints: aBlBoundsMatcherConstraints [

	acceptableConstraints := aBlBoundsMatcherConstraints
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> childAt: anIndex [
	
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> childEndOf: anElement [
	
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> childStartOf: anElement [
	
	^ self subclassResponsibility
]

{ #category : 'api - finder' }
BlChildBoundsBasedFinder >> detect [
	<return: #BlElement or: nil>
	
	^ self
		detectIfFound: [ :anElement | anElement ]
		ifNone: [ nil ]
]

{ #category : 'api - finder' }
BlChildBoundsBasedFinder >> detectIfFound: aFoundBlock ifNone: aNoneBlock [

	| aMatcher anAcceptableMatch aStep |
	aMatcher := BlBoundsMatcher new
		parentStart: self parentStart;
		parentEnd: self parentEnd.
	
	anAcceptableMatch := nil.
	
	aStep := toIndex >= fromIndex
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	fromIndex to: toIndex by: aStep do: [ :eachIndex |
		| eachChild |
		
		eachChild := self childAt: eachIndex.
		
		aMatcher
			childStart: (self childStartOf: eachChild);
			childEnd: (self childEndOf: eachChild).
			
		preferredConstraints isEmpty
			ifFalse: [
				aMatcher constraints: preferredConstraints.
				aMatcher matches
					ifTrue: [ ^ aFoundBlock cull: eachChild ] ].
				
		acceptableConstraints isEmpty
			ifFalse: [
				aMatcher constraints: acceptableConstraints.
				aMatcher matches
					ifTrue: [ anAcceptableMatch := eachChild ] ] ].
			
	^ anAcceptableMatch
		ifNil: aNoneBlock
		ifNotNil: aFoundBlock
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> fromIndex [

	^ fromIndex
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> fromIndex: anInteger [

	fromIndex := anInteger
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> parentEnd [
	
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> parentStart [
	
	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> preferredConstraints [

	^ preferredConstraints
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> preferredConstraints: aBlBoundsMatcherConstraints [

	preferredConstraints := aBlBoundsMatcherConstraints
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> toIndex [

	^ toIndex
]

{ #category : 'accessing' }
BlChildBoundsBasedFinder >> toIndex: anInteger [

	toIndex := anInteger
]
