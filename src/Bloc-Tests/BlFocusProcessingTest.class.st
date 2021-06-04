"
This class contains tests

"
Class {
	#name : #BlFocusProcessingTest,
	#superclass : #BlEventTestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #accessing }
BlFocusProcessingTest >> firedEvents [
	^ space focusProcessor firedEvents
]

{ #category : #tests }
BlFocusProcessingTest >> testFocus [
	self assert: self child focused not.
	self assert: self root focused.

	self assertFiredEventIs: BlFocusInEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: self root withPropagation: false.

	self child requestFocus.

	self assertFiredEventIs: BlFocusOutEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlBlurEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlFocusInEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: self child withPropagation: false.
	self assert:self child focused.
	self assert: self root focused not.
	
	self root requestFocus.
	
	self assertFiredEventIs: BlFocusOutEvent target: self child withPropagation: true.
	self assertFiredEventIs: BlBlurEvent target: self child withPropagation: false.
	
	self assertFiredEventIs: BlFocusInEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: self root withPropagation: false.
	
	self assert:self child focused not.
	self assert: self root focused.
]

{ #category : #tests }
BlFocusProcessingTest >> testFocusLostOfRemovedChild [
	| aChild |
	
	aChild := self child.
	
	self assert: aChild focused not.
	self assert: self root focused.

	self assertFiredEventIs: BlFocusInEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: self root withPropagation: false.

	aChild requestFocus.

	self assertFiredEventIs: BlFocusOutEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlBlurEvent target: self root withPropagation: false.
	self assertFiredEventIs: BlFocusInEvent target: aChild withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: aChild withPropagation: false.
	self assert:aChild focused.
	self assert: self root focused not.

	aChild removeFromParent.

	self assert: aChild focused.
	self assert: self root focused not.

	self root requestFocus.

	self assertFiredEventIs: BlFocusOutEvent target: aChild withPropagation: true.
	self assertFiredEventIs: BlFocusOutEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlBlurEvent target: aChild withPropagation: false.

	self assertFiredEventIs: BlFocusInEvent target: self root withPropagation: true.
	self assertFiredEventIs: BlFocusEvent target: self root withPropagation: false.
	
	self assert: aChild focused not.
	self assert: self root focused.
]
