Class {
	#name : #BlElementLayoutVerticalResizerProperty,
	#superclass : #BlElementLayoutResizerProperty,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementLayoutVerticalResizerProperty >> applyOnElement: anElement [
	anElement constraints vertical resizer = self resizer
		ifTrue: [ ^ self ].

	anElement constraintsDo: [ :c | c vertical resizer: self resizer ]
]

{ #category : #accessing }
BlElementLayoutVerticalResizerProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Horizontal resizer - ';
		print: self resizer
]
