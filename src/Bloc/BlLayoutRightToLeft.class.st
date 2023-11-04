"
I am a concrete right-to-left direction

"
Class {
	#name : #BlLayoutRightToLeft,
	#superclass : #BlLayoutDirection,
	#category : 'Bloc-Layouts-Support'
}

{ #category : 'accessing' }
BlLayoutRightToLeft >> inverted [

	^ self class leftToRight
]

{ #category : 'testing' }
BlLayoutRightToLeft >> isLeftToRight [
	^ false
]

{ #category : 'testing' }
BlLayoutRightToLeft >> isRightToLeft [
	^ true
]

{ #category : 'dispatch' }
BlLayoutRightToLeft >> of: anObject [
	^ anObject rightToLeft
]

{ #category : 'enumerating' }
BlLayoutRightToLeft >> with: aCollection do: aBlock [
	aCollection reverseDo: aBlock
]

{ #category : 'enumerating' }
BlLayoutRightToLeft >> with: aCollection inject: thisValue into: binaryBlock [
	"Reversed implementation of Collection>>#inject:into:"
	| nextValue |
	nextValue := thisValue.
	aCollection reverseDo: [ :each | nextValue := binaryBlock value: nextValue value: each ].
	^ nextValue
]
