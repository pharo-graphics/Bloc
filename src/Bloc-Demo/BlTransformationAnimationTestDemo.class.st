Class {
	#name : #BlTransformationAnimationTestDemo,
	#superclass : #TestCase,
	#category : #'Bloc-Demo-FromTests'
}

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> animationElement [
	^ self testAnimationElement
]

{ #category : #helpers }
BlTransformationAnimationTestDemo >> assertNotStartedAnimation: animation [
	self assert: animation isStarted not.
	self assert: animation isRunning not.
	self assert: animation progress equals: 0.0.
	self assert: animation loopCount equals: 0
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> containerElement [
	^ self testContainerElement
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> containerWithOneElement [
	<sampleInstance>	
	^ self testContainerWithOneElement
]

{ #category : #tests }
BlTransformationAnimationTestDemo >> linearTranslationAnimation [
	<sampleInstance>	
	^ self testLinearTranslationAnimation
]

{ #category : #tests }
BlTransformationAnimationTestDemo >> linearTranslationAnimationWithDelayAndLoop [
	<sampleInstance>
	^ self testLinearTranslationAnimationWithDelayAndLoop
	
]

{ #category : #tests }
BlTransformationAnimationTestDemo >> linearTranslationAnimationWithDurationAndEasing [
	<sampleInstance>
	^ self testLinearTranslationAnimationWithDurationAndEasing
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> testAnimationElement [
	<sampleInstance>
	^ BlElement new
		size: 50 @ 50;
		background: Color veryLightGray;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> testContainerElement [
	<sampleInstance>
	^ BlElement new
		size: 350 @ 350;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		border: (BlBorder paint: Color gray width: 2)
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> testContainerWithOneElement [
	<sampleInstance>
	| container element |
	container := self containerElement.
	element := self animationElement.
	element position: 5 @ 5.
	container addChild: element.
	^ container
]

{ #category : #'smoke tests - demo' }
BlTransformationAnimationTestDemo >> testElementWithLinearTranslationAnimation [
	<sampleInstance>
	| container element animation |
	animation := self linearTranslationAnimation.
	element := self animationElement.
	element position: 5 @ 5.
	container := self containerElement.
	container addChild: element.
	element addAnimation: animation.
	^ container
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> testElementWithLinearTranslationAnimationWithDelayAndLoop [
	<sampleInstance>
	| container animation |
	animation := self linearTranslationAnimationWithDelayAndLoop.
	container := self containerWithOneElement.
	container children first addAnimation: animation.
	^ container
]

{ #category : #'tests - demo' }
BlTransformationAnimationTestDemo >> testElementWithLinearTranslationAnimationWithDurationAndEasing [
	<sampleInstance>
	| container animation |
	animation := self linearTranslationAnimationWithDurationAndEasing.
	container := self containerWithOneElement.
	container children first addAnimation: animation.
	^ container
]

{ #category : #tests }
BlTransformationAnimationTestDemo >> testLinearTranslationAnimation [
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
BlTransformationAnimationTestDemo >> testLinearTranslationAnimationWithDelayAndLoop [
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
BlTransformationAnimationTestDemo >> testLinearTranslationAnimationWithDurationAndEasing [
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
