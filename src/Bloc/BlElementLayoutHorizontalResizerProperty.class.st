Class {
	#name : #BlElementLayoutHorizontalResizerProperty,
	#superclass : #BlElementLayoutResizerProperty,
	#category : 'Bloc-Basic-Properties'
}

{ #category : 'api - property' }
BlElementLayoutHorizontalResizerProperty >> applyOnElement: anElement [
	anElement constraints horizontal resizer = self resizer
		ifTrue: [ ^ self ].

	anElement constraintsDo: [ :c | c horizontal resizer: self resizer ]
]

{ #category : 'accessing' }
BlElementLayoutHorizontalResizerProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Vertical resizer - ';
		print: self resizer
]
