Class {
	#name : 'BlElementGeometryProperty',
	#superclass : 'BlElementProperty',
	#instVars : [
		'geometry'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'comparing' }
BlElementGeometryProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ geometry = anObject geometry
]

{ #category : 'api - property' }
BlElementGeometryProperty >> applyOnElement: anElement [
	anElement geometry: self geometry
]

{ #category : 'api - property' }
BlElementGeometryProperty >> cleanUpOnElement: anElement [
	anElement geometry: BlElementVisuals defaultGeometry
]

{ #category : 'accessing' }
BlElementGeometryProperty >> geometry [
	^ geometry
]

{ #category : 'accessing' }
BlElementGeometryProperty >> geometry: anObject [
	geometry := anObject
]

{ #category : 'comparing' }
BlElementGeometryProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ geometry hash
]

{ #category : 'printing' }
BlElementGeometryProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Geometry - ';
		print: self geometry
]
