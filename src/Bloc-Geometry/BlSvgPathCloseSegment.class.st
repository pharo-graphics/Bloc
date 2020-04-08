Class {
	#name : #BlSvgPathCloseSegment,
	#superclass : #BlSvgPathSegment,
	#category : #'Bloc-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathCloseSegment >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ anotherObject isAbsolute = self isAbsolute
]

{ #category : #executing }
BlSvgPathCloseSegment >> executeOn: aBuilder [
	aBuilder close
]

{ #category : #comparing }
BlSvgPathCloseSegment >> hash [
	^ self class hash bitXor: self isAbsolute hash
]
