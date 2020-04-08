Class {
	#name : #BlSvgPathMoveSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'moveTo'
	],
	#category : #'Bloc-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathMoveSegment >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject moveTo = self moveTo ]
]

{ #category : #executing }
BlSvgPathMoveSegment >> executeOn: aBuilder [
	aBuilder moveTo: self moveTo
]

{ #category : #comparing }
BlSvgPathMoveSegment >> hash [
	^ self isAbsolute hash bitXor: self moveTo hash
]

{ #category : #initialization }
BlSvgPathMoveSegment >> initialize [
	super initialize.
	
	moveTo := 0@0
]

{ #category : #accessing }
BlSvgPathMoveSegment >> moveTo [
	<return: #Point>

	^ moveTo
]

{ #category : #accessing }
BlSvgPathMoveSegment >> moveTo: aPoint [
	moveTo := aPoint
]

{ #category : #printing }
BlSvgPathMoveSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Move ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to '.
	self moveTo printOn: aStream
]
