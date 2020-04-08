Class {
	#name : #BlSvgPathLineSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'lineTo'
	],
	#category : #'Bloc-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathLineSegment >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject lineTo = self lineTo ]
]

{ #category : #executing }
BlSvgPathLineSegment >> executeOn: aBuilder [
	aBuilder lineTo: self lineTo
]

{ #category : #comparing }
BlSvgPathLineSegment >> hash [
	^ self isAbsolute hash bitXor: self lineTo hash
]

{ #category : #initialization }
BlSvgPathLineSegment >> initialize [
	super initialize.
	
	lineTo := 0@0
]

{ #category : #accessing }
BlSvgPathLineSegment >> lineTo [
	<return: #Point>

	^ lineTo
]

{ #category : #accessing }
BlSvgPathLineSegment >> lineTo: aPoint [
	lineTo := aPoint
]

{ #category : #printing }
BlSvgPathLineSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Line ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to '.
	self lineTo printOn: aStream
]
