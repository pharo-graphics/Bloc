"
I exemplify how Bloc handles errors in different parts of the BlElement such as drawing, layout or event handling
"
Class {
	#name : #BlErrorHandlingExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Examples-Errors'
}

{ #category : #'error - examples' }
BlErrorHandlingExamples >> sceneElementThatHasBrokenDrawing [
	<gtExample>
	<noTest>
	| aFaultyElement theErrors aSceneElement |
	
	aFaultyElement := BlExampleElementWithBrokenDrawing new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.
	
	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 1.
	self assert: (theErrors first error isKindOf: ZeroDivide).
	self assert: theErrors first errorHandler equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isDrawingPhase.
	self assert: theErrors first element equals: aFaultyElement.

	^ aSceneElement
]

{ #category : #'error - examples' }
BlErrorHandlingExamples >> sceneElementThatHasBrokenDrawingAndOnLayout [
	<gtExample>
	<noTest>
	| aFaultyElement theErrors aSceneElement |
	
	aFaultyElement := BlExampleElementWithBrokenDrawingAndOnLayout new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.
	
	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 2.

	self assert: (theErrors first error isKindOf: SubscriptOutOfBounds).
	self assert: theErrors first errorHandler equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isLayoutPhase.
	self assert: theErrors first element equals: aFaultyElement.
	
	self assert: (theErrors second error isKindOf: ZeroDivide).
	self assert: theErrors second errorHandler equals: aFaultyElement errorHandler.
	self assert: theErrors second framePhase isDrawingPhase.
	self assert: theErrors second element equals: aFaultyElement.

	^ aSceneElement
]

{ #category : #'error - examples' }
BlErrorHandlingExamples >> sceneElementThatHasBrokenOnLayout [
	<gtExample>
	<noTest>
	| aSceneElement aFaultyElement  theErrors |

	aFaultyElement := BlExampleElementWithBrokenOnLayout new.
	aFaultyElement background: Color gray.

	aSceneElement := self sceneWith: aFaultyElement.

	theErrors := aFaultyElement errorHandler errors.
	self assert: theErrors size equals: 1.
	self assert: (theErrors first error isKindOf: SubscriptOutOfBounds).
	self assert: theErrors first errorHandler equals: aFaultyElement errorHandler.
	self assert: theErrors first framePhase isLayoutPhase.
	self assert: theErrors first element equals: aFaultyElement.
	
	^ aSceneElement
]

{ #category : #'instance creation' }
BlErrorHandlingExamples >> sceneWith: aFaultyElement [
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
		c frame horizontal weight: 0.5; alignCenter.
		c frame vertical weight: 0.3; alignCenter.
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

	aContainer addChildren: { aLeftChild . aRightChild }.
	
	aSpace := BlSpace new.
	aSpace host: BlMorphicWindowHost new.
	aSpace addChild: aContainer.
	aSpace show.
	aSpace pulse.
	aSpace close.
	aContainer removeFromParent. 
	
	^ aContainer
]
