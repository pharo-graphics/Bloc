Class {
	#name : #BlElementGeometryProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'geometry'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementGeometryProperty >> applyOnElement: anElement [
	anElement geometry: self geometry
]

{ #category : #accessing }
BlElementGeometryProperty >> geometry [
	^ geometry
]

{ #category : #accessing }
BlElementGeometryProperty >> geometry: anObject [
	geometry := anObject
]
