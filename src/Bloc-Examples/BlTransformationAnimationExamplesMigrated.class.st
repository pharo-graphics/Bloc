Class {
	#name : #BlTransformationAnimationExamplesMigrated,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-AnimationMigrated'
}

{ #category : #'setup - elements' }
BlTransformationAnimationExamplesMigrated >> animationElement [
	<gtExample>
	^ BlElement new
		size: 50@50;
		background: Color veryLightGray;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #assertions }
BlTransformationAnimationExamplesMigrated >> assertNotStartedAnimation: animation [
	self assert: animation isStarted not.
	self assert: animation isRunning not.
	self assert: animation progress equals: 0.0.
	self assert: animation repeats equals: 0.
]

{ #category : #'setup - elements' }
BlTransformationAnimationExamplesMigrated >> containerElement [
	<gtExample>
	^ BlElement new
		size: 350@350;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		border: ((BlBorder paint: Color gray width: 2)).
]

{ #category : #'setup - elements' }
BlTransformationAnimationExamplesMigrated >> containerWithOneElement [
	<gtExample>
	| container element |
	container := self containerElement.
	element := self animationElement.
	element relocate: 5@5.
	container addChild: element.
	^ container
]

{ #category : #'examples - elements animation' }
BlTransformationAnimationExamplesMigrated >> elementWithLinearTranslationAnimation [
	<gtExample>
	| container element animation |
	
	animation := self linearTranslationAnimation.
	
	element := self animationElement.
	element relocate: 5@5.
	container := self containerElement.
	container addChild: element.
	
	element addAnimation: animation. 
	^ container
	 
]

{ #category : #'examples - elements animation' }
BlTransformationAnimationExamplesMigrated >> elementWithLinearTranslationAnimationWithDelayAndLoop [
	<gtExample>
	| container animation |
	
	animation := self linearTranslationAnimationWithDelayAndLoop.
	container := self containerWithOneElement.
	container children first addAnimation: animation. 
	^ container
	 
]

{ #category : #'examples - elements animation' }
BlTransformationAnimationExamplesMigrated >> elementWithLinearTranslationAnimationWithDurationAndEasing [
	<gtExample>
	| container animation |
	
	animation := self linearTranslationAnimationWithDurationAndEasing.
	container := self containerWithOneElement.
	container children first addAnimation: animation. 
	^ container
	 
]

{ #category : #'examples - animations' }
BlTransformationAnimationExamplesMigrated >> linearTranslationAnimation [
	<gtExample>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 200@0;
		apply. 
	self assert: animation duration equals: 1 second.
	self assert: animation loops equals: 1.
	self assert: animation easing equals: BlEasing linear.
	self assert: animation delay equals: 0 second.
	self assertNotStartedAnimation: animation.
	^ animation
]

{ #category : #'examples - animations' }
BlTransformationAnimationExamplesMigrated >> linearTranslationAnimationWithDelayAndLoop [
	<gtExample>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 50@0;
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

{ #category : #'examples - animations' }
BlTransformationAnimationExamplesMigrated >> linearTranslationAnimationWithDurationAndEasing [
	<gtExample>
	| animation |
	animation := BlTransformAnimation new.
	animation transform
		translateBy: 200@0;
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
