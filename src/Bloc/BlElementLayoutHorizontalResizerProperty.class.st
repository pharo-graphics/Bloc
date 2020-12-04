Class {
	#name : #BlElementLayoutHorizontalResizerProperty,
	#superclass : #BlElementLayoutResizerProperty,
	#category : #'Bloc-Basic-Properties'
}

{ #category : #'api - property' }
BlElementLayoutHorizontalResizerProperty >> applyOnElement: anElement [
	self resizer isExact
		ifTrue: [ anElement states addState: (BrLayoutHorizontalResizerState exact) ].
		
	self resizer isFitContent
		ifTrue: [ anElement states addState: (BrLayoutHorizontalResizerState fitContent) ].
		
	self resizer isFitContentLimited
		ifTrue: [ anElement states addState: (BrLayoutHorizontalResizerState fitContentLimited) ].
		
	self resizer isMatchParent
		ifTrue: [ anElement states addState: (BrLayoutHorizontalResizerState matchParent) ].

	anElement constraints horizontal resizer = self resizer
		ifTrue: [ ^ self ].

	anElement constraintsDo: [ :c | c horizontal resizer: self resizer ]
]
