"
I have been automatically converted and probably manually tweaked from BlErrorHandlingExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlErrorHandlingTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Errors'
}

{ #category : #metadata }
BlErrorHandlingTest >> originClassName [
	"This test was generated from..."
	^ 'BlErrorHandlingExamples'
]

{ #category : #fixture }
BlErrorHandlingTest >> sceneWith: aFaultyElement [

	"Create a visual scene with a faulty element embedded in it"

	| aContainer aLeftChild aRightChild aSpace |
	aContainer := BlElement new.
	aContainer layout: BlLinearLayout horizontal.
	aContainer constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	aLeftChild := BlElement new.
	aLeftChild background: Color veryVeryLightGray.
	aLeftChild margin: (BlInsets all: 20).
	aLeftChild layout: BlFrameLayout new.
	aLeftChild constraintsDo: [ :c | 
		c linear weight: 0.7.
		c horizontal matchParent.
		c vertical matchParent ].

	aFaultyElement constraintsDo: [ :c | 
		c frame horizontal
			weight: 0.5;
			alignCenter.
		c frame vertical
			weight: 0.3;
			alignCenter.
		c horizontal matchParent.
		c vertical matchParent ].

	aLeftChild addChild: aFaultyElement.

	aRightChild := BlElement new.
	aRightChild background: Color veryVeryLightGray.
	aRightChild margin: (BlInsets all: 20).
	aRightChild constraintsDo: [ :c | 
		c linear weight: 0.3.
		c horizontal matchParent.
		c vertical matchParent ].

	aContainer addChildren: { 
			aLeftChild.
			aRightChild }.

	aSpace := BlSpace new.
	aSpace host: BlMorphicWindowHost new.
	aSpace root addChild: aContainer.
	aSpace show.

	self assert: (BlSpace
			pulseUntilEmptyTaskQueue: aSpace
			timeout: 200 milliSeconds).

	aSpace close.
	aContainer removeFromParent.

	self assert: (BlSpace
			pulseUntilEmptyTaskQueue: aSpace
			timeout: 200 milliSeconds).

	^ aContainer
]

{ #category : #tests }
BlErrorHandlingTest >> testSceneElementThatHasBrokenDrawing [
	<sampleInstance>
	
	| aFaultyElement theErrors aSceneElement |
	self skip.
	
	aFaultyElement := BlElementWithBrokenDrawingMock new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.

	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 1.
	self assert: (theErrors first error isKindOf: ZeroDivide).
	self
		assert: theErrors first errorHandler
		equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isDrawingPhase.
	self assert: theErrors first element equals: aFaultyElement.

	^ aSceneElement
]

{ #category : #tests }
BlErrorHandlingTest >> testSceneElementThatHasBrokenDrawingAndOnLayout [
	<sampleInstance>

	| aFaultyElement theErrors aSceneElement |
	self skip.

	aFaultyElement := BlElementWithBrokenDrawingAndOnLayoutMock new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.

	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 2.

	self assert: (theErrors first error isKindOf: SubscriptOutOfBounds).
	self
		assert: theErrors first errorHandler
		equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isLayoutPhase.
	self assert: theErrors first element equals: aFaultyElement.

	self assert: (theErrors second error isKindOf: ZeroDivide).
	self
		assert: theErrors second errorHandler
		equals: aFaultyElement errorHandler.
	self assert: theErrors second framePhase isDrawingPhase.
	self assert: theErrors second element equals: aFaultyElement.

	^ aSceneElement
]

{ #category : #tests }
BlErrorHandlingTest >> testSceneElementThatHasBrokenOnLayout [
	<sampleInstance>

	| aSceneElement aFaultyElement theErrors |
	self skip.

	aFaultyElement := BlElementWithBrokenOnLayoutMock new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.

	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 1.
	self assert: (theErrors first error isKindOf: SubscriptOutOfBounds).
	self
		assert: theErrors first errorHandler
		equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isLayoutPhase.
	self assert: theErrors first element equals: aFaultyElement.

	^ aSceneElement
]
