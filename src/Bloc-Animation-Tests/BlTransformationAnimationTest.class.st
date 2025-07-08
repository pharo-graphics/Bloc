"
I have been automatically converted and probably manually tweaked from BlTransformationAnimationExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlTransformationAnimationTest,
	#superclass : #TestCase,
	#category : #'Bloc-Animation-Tests'
}

{ #category : #tests }
BlTransformationAnimationTest >> animationElement [
	^ self testAnimationElement
]

{ #category : #helpers }
BlTransformationAnimationTest >> assertNotStartedAnimation: animation [
	self assert: animation isStarted not.
	self assert: animation isRunning not.
	self assert: animation progress equals: 0.0.
	self assert: animation loopCount equals: 0
]

{ #category : #tests }
BlTransformationAnimationTest >> containerElement [
	^ self testContainerElement
]

{ #category : #tests }
BlTransformationAnimationTest >> containerWithOneElement [
	<sampleInstance>	
	^ self testContainerWithOneElement
]

{ #category : #tests }
BlTransformationAnimationTest >> linearTranslationAnimation [
	<sampleInstance>	
	^ self testLinearTranslationAnimation
]

{ #category : #tests }
BlTransformationAnimationTest >> linearTranslationAnimationWithDelayAndLoop [
	<sampleInstance>
	^ self testLinearTranslationAnimationWithDelayAndLoop
	
]

{ #category : #tests }
BlTransformationAnimationTest >> linearTranslationAnimationWithDurationAndEasing [
	<sampleInstance>
	^ self testLinearTranslationAnimationWithDurationAndEasing
]

{ #category : #tests }
BlTransformationAnimationTest >> testAnimationElement [
	<sampleInstance>
	<demo>
	^ BlElement new
		extent: 50 @ 50;
		background: Color veryLightGray;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #tests }
BlTransformationAnimationTest >> testContainerElement [
	<sampleInstance>
	<demo>
	^ BlElement new
		extent: 350 @ 350;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		border: (BlBorder paint: Color gray width: 2)
]

{ #category : #tests }
BlTransformationAnimationTest >> testContainerWithOneElement [
	<sampleInstance>
	<demo>
	| container element |
	container := self containerElement.
	element := self animationElement.
	element position: 5 @ 5.
	container addChild: element.
	^ container
]

{ #category : #'smoke tests' }
BlTransformationAnimationTest >> testElementWithLinearTranslationAnimation [
	<sampleInstance>
	<demo>
	| container element animation |
	animation := self linearTranslationAnimation.
	element := self animationElement.
	element position: 5 @ 5.
	container := self containerElement.
	container addChild: element.
	element addAnimation: animation.
	^ container
]

{ #category : #tests }
BlTransformationAnimationTest >> testElementWithLinearTranslationAnimationWithDelayAndLoop [
	<sampleInstance>
	<demo>
	| container animation |
	animation := self linearTranslationAnimationWithDelayAndLoop.
	container := self containerWithOneElement.
	container children first addAnimation: animation.
	^ container
]

{ #category : #tests }
BlTransformationAnimationTest >> testElementWithLinearTranslationAnimationWithDurationAndEasing [
	<sampleInstance>
	<demo>
	| container animation |
	animation := self linearTranslationAnimationWithDurationAndEasing.
	container := self containerWithOneElement.
	container children first addAnimation: animation.
	^ container
]

{ #category : #tests }
BlTransformationAnimationTest >> testLinearTranslationAnimation [
	<sampleInstance>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 200 @ 0;
		apply.
	self assert: animation duration equals: 1 second.
	self assert: animation loops equals: 1.
	self assert: animation easing equals: BlEasing linear.
	self assert: animation delay equals: 0 second.
	self assertNotStartedAnimation: animation.
	^ animation
]

{ #category : #tests }
BlTransformationAnimationTest >> testLinearTranslationAnimationWithDelayAndLoop [
	<sampleInstance>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 50 @ 0;
		apply.
	animation delay: 1 second.
	animation loops: 3.
	animation easing: BlEasing bounceIn.
	self assert: animation duration equals: 1 second.
	self assert: animation loops equals: 3.
	self assert: animation easing equals: BlEasing bounceIn.
	self assert: animation delay equals: 1 second.
	self assertNotStartedAnimation: animation.
	^ animation 
]

{ #category : #tests }
BlTransformationAnimationTest >> testLinearTranslationAnimationWithDurationAndEasing [
	<sampleInstance>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 200 @ 0;
		apply.
	animation duration: 2 seconds.
	animation easing: BlEasing bounceIn.
	self assert: animation duration equals: 2 second.
	self assert: animation loops equals: 1.
	self assert: animation easing equals: BlEasing bounceIn.
	self assert: animation delay equals: 0 second.
	self assertNotStartedAnimation: animation.
	^ animation
]
