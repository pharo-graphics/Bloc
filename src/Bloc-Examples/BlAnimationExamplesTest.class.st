"
I contain examples of Bloc animation framework.
"
Class {
	#name : #BlAnimationExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-Examples-Tasks'
}

{ #category : #examples }
BlAnimationExamplesTest >> ballsAnim [
	<sampleInstance>
	<demo>

	| elements animations |
	animations := OrderedCollection new.
	elements := OrderedCollection new.

	1 to: 12 do: [ :i |
		| anElement bounceAnimation colorizeAnimation |
		anElement :=
			BlEllipseGeometry new asElement
			      background: Color white;
			      position: (i * 10) @ 0;
			      size: 50 @ 50;
			      yourself.

		bounceAnimation :=
			BlTransformAnimation new
			      target: anElement;
			      transformDo: [ :aBuilder |
				      aBuilder translateBy:
							0 @ 100 ];
			      delay: 100 milliSeconds * i;
			      duration: 2 seconds;
			      easing: BlEasing bounceOut;
			      yourself.

		colorizeAnimation :=
			BlColorTransition new
			       from: Color white;
			       to: Color random;
			       delay: 100 milliSeconds * i;
			       duration: 1 second;
			       onStepDo: [ :c | anElement background: c ];
			       yourself.

		animations addAll: { bounceAnimation. colorizeAnimation }.
		elements add: anElement ].

	^ self newFrameContainer
		addChildren: elements;
		addAnimation: (BlParallelAnimation withAll: animations);
		yourself
]

{ #category : #running }
BlAnimationExamplesTest >> blueAt: anIndex [
	"0.0 <= anIndex <= 1.0"

	| radians |
	radians := self radiansAt: anIndex.
	radians < (Float pi / 2.0) ifTrue: [ ^ 0 ].

	^ (radians - (Float pi / 2.0)) sin
]

{ #category : #examples }
BlAnimationExamplesTest >> bouncingText [
	"Click on letters to start animation!"
	<sampleInstance>
	<demo>

	| letters container animation clickHandler |
	letters :=
		'click on me'
			collect: [ :aCharacter | self newTextElementFor: aCharacter ]
			as: Array.
	letters withIndexDo: [ :aTextElement :anIndex |
		"change text color according to index in color spectrum"
		aTextElement text:
			(aTextElement text
				foreground: (self colorAt: (anIndex / letters size) asFloat);
				yourself) ].

	animation := BlParallelAnimation withAll:
		(letters withIndexCollect: [ :aChild :anIndex |
			self newJiggleAnimation
				delay: 20 milliSeconds * (anIndex - 1);
				target: aChild;
				yourself ]).

	container := self newTextContainer.
	container addChildren: letters.

	clickHandler := nil.
	clickHandler := BlEventHandler
		on: BlClickEvent
		do: [
			container removeEventHandler: clickHandler.
			container addAnimation: animation ].
	container addEventHandler: clickHandler.

	^ self newFrameContainer
		addChild: container;
		yourself
]

{ #category : #running }
BlAnimationExamplesTest >> colorAt: anIndex [
	"0.0 <= anIndex <= 1.0"

	| normalizedIndex |
	normalizedIndex := anIndex.
	normalizedIndex > 1 ifTrue: [ normalizedIndex := 1 ].
	normalizedIndex < 0 ifTrue: [ normalizedIndex := 0 ].
	
	^ Color
		r: (self redAt: normalizedIndex)
		g: (self greenAt: normalizedIndex)
		b: (self blueAt: normalizedIndex)
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> exampleDate [

	^ DateAndTime year: 2018 month: 3 day: 31
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> exampleDelay [

	^ 0.5 seconds
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> exampleDuration [

	^ 2 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> firstSequentialDuration [

	^ 8 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> firstSequentialLoops [

	^ 2
]

{ #category : #running }
BlAnimationExamplesTest >> greenAt: anIndex [
	"0.0 <= anIndex <= 1.0"

	| radians |
	radians := self radiansAt: anIndex.
	radians > Float pi ifTrue: [ ^ 0 ].

	^ radians sin
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> newExampleBlTime [

	^ BlTime simulated
		date: self exampleDate;
		yourself
]

{ #category : #running }
BlAnimationExamplesTest >> newFrameContainer [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  clipChildren: false;
		  yourself
]

{ #category : #running }
BlAnimationExamplesTest >> newJiggleAnimation [

	| anAnimation |
	anAnimation := BlTransformAnimation new.
	anAnimation transform
		translateBy: 0 @ (50 + 20 atRandom) negated;
		rotateBy: 30 atRandom - 15;
		scaleBy: 1.3 + (20 atRandom / 100.0) @ (1.3 + (20 atRandom / 100.0));
		apply.
	anAnimation absolute.
	anAnimation easing: (BlSineInterpolator new range: Float pi).
	anAnimation loops: 3.
	anAnimation duration: 1 second.

	^ anAnimation
]

{ #category : #running }
BlAnimationExamplesTest >> newTextContainer [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignBottomCenter;
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  clipChildren: false;
		  yourself
]

{ #category : #running }
BlAnimationExamplesTest >> newTextElementFor: aCharacter [

	| aText |
	aText := aCharacter asRopedText
		fontSize: 90;
		yourself.
	
	^ BlTextElement new 
		text: aText;
		effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0);
		yourself
]

{ #category : #running }
BlAnimationExamplesTest >> radiansAt: anIndex [
	"0.0 <= anIndex <= 1.0"

	^ anIndex * (Float pi * 3) / 2.0
]

{ #category : #running }
BlAnimationExamplesTest >> redAt: anIndex [
	"0.0 <= anIndex <= 1.0"

	| radians |
	radians := self radiansAt: anIndex.
	(radians between: Float pi / 2.0 and: Float pi) ifTrue: [ ^ 0 ].

	radians < (Float pi/ 2.0)
		ifTrue: [ ^ (radians + (Float pi / 2)) sin ].

	^ (radians + Float pi) sin
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> secondSequentialDelay [

	^ 2 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> secondSequentialDuration [

	^ 4 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> secondSequentialLoops [

	^ 1
]

{ #category : #examples }
BlAnimationExamplesTest >> sequential [
	<sampleInstance>
	<demo>

	| element translation scale sequential |
	translation := (BlTransformAnimation translate: 100 @ 100)
		               easing: BlEasing bounceOut;
		               duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		         easing: BlEasing bounceOut;
		         duration: 2 seconds.

	sequential :=
		BlSequentialAnimation withAll: { translation. scale }.

	element := BlElement new
		           background: Color blue;
		           size: 100 @ 100;
		           position: 100 @ 50;
		           addAnimation: sequential;
		           yourself.

	^ element
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testBaseAnimation [

	| aBaseAnimation |
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: self newExampleBlTime.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.
	self assert: aBaseAnimation isInfinite not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testBaseAnimationTolaratesRedundantStartAndStop [

	| anAnimation |
	anAnimation := BlAnimation new.
	self deny: anAnimation isRunning.
	anAnimation stop.
	self deny: anAnimation isRunning.
	anAnimation stop; stop; stop.
	self deny: anAnimation isRunning.

	anAnimation start.
	self assert: anAnimation isRunning.
	anAnimation run.
	anAnimation start; start; start.
	self assert: anAnimation isRunning.
	anAnimation run.
	self assert: anAnimation isRunning.

	anAnimation stop.
	self deny: anAnimation isRunning.
	anAnimation stop.
	self deny: anAnimation isRunning
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testBaseAnimationWithDelay [

	| aBaseAnimation |
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: self newExampleBlTime.

	aBaseAnimation delay: self exampleDelay.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testBaseAnimationWithDelayAndDurationAndTwoLoops [

	| aBaseAnimation |
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: self newExampleBlTime.

	aBaseAnimation delay: self exampleDelay.
	aBaseAnimation loops: 2.
	aBaseAnimation duration: self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testBaseAnimationWithDelayAndTwoLoops [

	| aBaseAnimation |
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: self newExampleBlTime.

	aBaseAnimation delay: self exampleDelay.
	aBaseAnimation loops: 2.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> testInfiniteAnimation [

	| aBaseAnimation |
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: self newExampleBlTime.
	aBaseAnimation beInfinite.

	self assert: aBaseAnimation isInfinite.
	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation loopCount equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> testSequentialAddFirstChild [

	| aSequentialAnimation |
	aSequentialAnimation := self testSequentialAnimationWithDelayAndTwoLoops.
	aSequentialAnimation add:
		(BlAnimation new
			duration: self firstSequentialDuration;
			loops: self firstSequentialLoops;
			yourself).
	
	self 
		assert: aSequentialAnimation duration 
		equals: self firstSequentialDuration * self firstSequentialLoops.
	
	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> testSequentialAnimation [

	| aSequentialAnimation |
	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: self newExampleBlTime.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: 0 seconds.
	self assert: aSequentialAnimation loops equals: 1.
	self assert: aSequentialAnimation loopCount equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> testSequentialAnimationWithDelay [

	| aSequentialAnimation |
	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: self newExampleBlTime.

	aSequentialAnimation delay: self exampleDelay.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	self assert: aSequentialAnimation loops equals: 1.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> testSequentialAnimationWithDelayAndTwoLoops [

	| aSequentialAnimation |
	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: self newExampleBlTime.

	aSequentialAnimation delay: self exampleDelay.
	aSequentialAnimation loops: 2.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation loopCount equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_1_1_sequential_addFirstChild [
	
	| aSequentialAnimation |
	aSequentialAnimation := self testSequentialAnimationWithDelayAndTwoLoops.
	aSequentialAnimation add:
		(BlAnimation new
			duration: self firstSequentialDuration;
			loops: self firstSequentialLoops;
			yourself).
	
	self 
		assert: aSequentialAnimation duration 
		equals: self firstSequentialDuration * self firstSequentialLoops.
	
	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_1_2_sequential_addSecondChild [

	| aSequentialAnimation aTotalDuration |
	aSequentialAnimation := self test_1_1_sequential_addFirstChild.
	aSequentialAnimation add:
		(BlAnimation new
			duration: self secondSequentialDuration;
			loops: self secondSequentialLoops;
			delay: self secondSequentialDelay;
			yourself).

	aTotalDuration :=
		(self firstSequentialDuration * self firstSequentialLoops) +
		((self secondSequentialDuration + self secondSequentialDelay) *
			self secondSequentialLoops).

	self assert: aSequentialAnimation duration equals: aTotalDuration.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_1_baseAnimation_start [

	| aBaseAnimation |
	aBaseAnimation := self testBaseAnimationWithDelayAndDurationAndTwoLoops.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamplesTest >> test_1_massive_infiniteAnimation_start [

	| aBaseAnimation |
	aBaseAnimation := self testBaseAnimation.
	aBaseAnimation duration: self exampleDuration.
	aBaseAnimation beInfinite.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.

	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamplesTest >> test_1_massive_oneLoopAnimation_start [

	| aBaseAnimation |
	aBaseAnimation := self testBaseAnimation.
	aBaseAnimation duration: self exampleDuration.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamplesTest >> test_1_massive_twoLoopAnimation_start [

	| aBaseAnimation |
	aBaseAnimation := self testBaseAnimation.
	aBaseAnimation loops: 2.
	aBaseAnimation duration: self exampleDuration.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_2_1_baseAnimation_step [

	| aBaseAnimation |
	aBaseAnimation := self test_1_baseAnimation_start.
	"do a cycle without advancing the clock"
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamplesTest >> test_2_1_massive_infiniteAnimation_step_oneDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate.

	self assert: aBaseAnimation isInfinite.
	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamplesTest >> test_2_1_massive_oneLoopAnimation_step_oneDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self deny: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamplesTest >> test_2_1_massive_twoLoopAnimation_step_oneDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_2_1_sequential_step [

	| aSequentialAnimation |
	aSequentialAnimation := self test_1_2_sequential_addSecondChild.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self
		assert: aSequentialAnimation startTime
		equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_2_2_baseAnimation_step_halfDelay [
	"in this example we see what exactly happens when half of delay elapsed"

	| aBaseAnimation |
	aBaseAnimation := self test_2_1_baseAnimation_step.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamplesTest >> test_2_2_massive_infiniteAnimation_step_twiceDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDuration.

	self assert: aBaseAnimation isInfinite.
	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamplesTest >> test_2_2_massive_oneLoopAnimation_step_twiceDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self deny: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamplesTest >> test_2_2_massive_twoLoopAnimation_step_twiceDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_2_3_baseAnimation_step_fullDelay [
	"in this example we see what exactly happens when the whole delay elapsed"

	| aBaseAnimation |
	aBaseAnimation := self test_2_2_baseAnimation_step_halfDelay.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamplesTest >> test_2_3_massive_infiniteAnimation_step_tripleDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + (self exampleDuration * 2).
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + (self exampleDuration * 2).

	self assert: aBaseAnimation isInfinite.
	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamplesTest >> test_2_3_massive_infiniteAnimation_step_tripleDurationAndHalf [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.5.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self
		assert: aBaseAnimation elapsedTime
		equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + (self exampleDuration * 3).
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + (self exampleDuration * 3).

	self assert: aBaseAnimation isInfinite.
	self assert: aBaseAnimation loops equals: nil.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamplesTest >> test_2_3_massive_oneLoopAnimation_step_tripleDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self deny: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamplesTest >> test_2_3_massive_twoLoopAnimation_step_tripleDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_3_1_baseAnimation_step_quarterOfDuration [
	"in this example we see what exactly happens when one quarter of duration is passed"

	| aBaseAnimation |
	aBaseAnimation := self test_2_3_baseAnimation_step_fullDelay.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.25.
	self
		assert: aBaseAnimation elapsedTime
		equals: self exampleDuration / 4.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_3_1_sequential_step_halfDelay [
	"in this example we see what exactly happens when a half of the delay elapsed"

	| aSequentialAnimation |
	aSequentialAnimation := self test_2_1_sequential_step.
	aSequentialAnimation time wait: self exampleDelay / 2.0.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self
		assert: aSequentialAnimation startTime
		equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_3_2_baseAnimation_step_halfOfDuration [
	"in this example we see what exactly happens when half of the duration is passed"

	| aBaseAnimation |
	aBaseAnimation := self test_3_1_baseAnimation_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self
		assert: aBaseAnimation elapsedTime
		equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_3_2_sequential_step_fullDelay [

	| aSequentialAnimation |
	aSequentialAnimation := self test_3_1_sequential_step_halfDelay.
	aSequentialAnimation time wait: self exampleDelay / 2.0.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self
		assert: aSequentialAnimation startTime
		equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_3_3_baseAnimation_step_fullDuration [
	"in this example we see what exactly happens when the whole duration is passed"

	| aBaseAnimation loopDoneListener loopDoneCount |
	aBaseAnimation := self test_3_2_baseAnimation_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.

	loopDoneCount := 0.
	loopDoneListener :=
		BlEventHandler
			on: BlAnimationLoopDoneEvent
			do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	aBaseAnimation removeEventHandler: loopDoneListener.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_4_1_baseAnimation_secondLoop_step_halfDelay [

	| aBaseAnimation |
	aBaseAnimation := self test_3_3_baseAnimation_step_fullDuration.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDelay + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals:
			self exampleDate + self exampleDelay +
			self exampleDuration + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_4_1_sequential_first_step_halfOfDuration [

	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	aSequentialAnimation := self test_3_2_sequential_step_fullDelay.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress closeTo: 0.18181818181818182.
	self
		assert: aSequentialAnimation elapsedTime
		equals: self firstSequentialDuration / 2.0.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	aFirstAnimation := aSequentialAnimation animations first.

	self assert: aFirstAnimation progress equals: 0.5.
	self
		assert: aFirstAnimation elapsedTime
		equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self
		assert: aFirstAnimation startTime
		equals: self exampleDate + self exampleDelay.
	self
		assert: aFirstAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation loopCount equals: 0.
	self assert: aFirstAnimation delay equals: 0 seconds.

	aSecondAnimation := aSequentialAnimation animations second.

	self assert: aSecondAnimation progress equals: 0.

	self deny: aSecondAnimation isStarted.
	self deny: aSecondAnimation isRunning.

	self
		assert: aSecondAnimation loops
		equals: self secondSequentialLoops.
	self
		assert: aSecondAnimation delay
		equals: self secondSequentialDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_4_2_baseAnimation_secondLoop_step_fullDelay [

	| aBaseAnimation |
	aBaseAnimation := self test_4_1_baseAnimation_secondLoop_step_halfDelay.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDelay + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals:
			self exampleDate + self exampleDelay +
			self exampleDuration + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_4_2_sequential_first_step_fullDuration [

	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	aSequentialAnimation := self test_4_1_sequential_first_step_halfOfDuration.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress closeTo: 0.36363636363636365.
	self
		assert: aSequentialAnimation elapsedTime
		equals: self firstSequentialDuration.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self
		assert: aSequentialAnimation startTime
		equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	aFirstAnimation := aSequentialAnimation animations first.

	self assert: aFirstAnimation progress equals: 1.0.
	self
		assert: aFirstAnimation elapsedTime
		equals: self firstSequentialDuration.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self
		assert: aFirstAnimation startTime
		equals: self exampleDate + self exampleDelay.
	self
		assert: aFirstAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation delay equals: 0 seconds.

	aSecondAnimation := aSequentialAnimation animations second.

	self assert: aSecondAnimation progress equals: 0.

	self deny: aSecondAnimation isStarted.
	self deny: aSecondAnimation isRunning.

	self
		assert: aSecondAnimation loops
		equals: self secondSequentialLoops.
	self
		assert: aSecondAnimation delay
		equals: self secondSequentialDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_4_2_sequential_first_step_fullDurationAndHalf [
	"The animation state must be equal to _5_1_sequential_first_secondStep_halfDuration,
	because we move time by the same amount"

	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	aSequentialAnimation := self test_4_1_sequential_first_step_halfOfDuration.
	aSequentialAnimation time wait: self firstSequentialDuration.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.545454545).
	self
		assert: aSequentialAnimation elapsedTime
		equals: self firstSequentialDuration + (self firstSequentialDuration / 2.0).

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	aFirstAnimation := aSequentialAnimation animations first.

	self assert: aFirstAnimation progress equals: 0.5.
	self
		assert: aFirstAnimation elapsedTime
		equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self
		assert: aFirstAnimation startTime
		equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	self
		assert: aFirstAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay + self firstSequentialDuration.

	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation delay equals: 0 seconds.

	aSecondAnimation := aSequentialAnimation animations second.

	self assert: aSecondAnimation progress equals: 0.

	self deny: aSecondAnimation isStarted.
	self deny: aSecondAnimation isRunning.

	self
		assert: aSecondAnimation loops
		equals: self secondSequentialLoops.
	self
		assert: aSecondAnimation delay
		equals: self secondSequentialDelay.

	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_4_3_baseAnimation_secondLoop_step_quarterOfDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_4_2_baseAnimation_secondLoop_step_fullDelay.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.25.
	self
		assert: aBaseAnimation elapsedTime
		equals: self exampleDuration / 4.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDelay + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals:
			self exampleDate + self exampleDelay +
			self exampleDuration + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_4_4_baseAnimation_secondLoop_step_halfOfDuration [

	| aBaseAnimation |
	aBaseAnimation := self test_4_3_baseAnimation_secondLoop_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self
		assert: aBaseAnimation elapsedTime
		equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDelay + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals:
			self exampleDate + self exampleDelay +
			self exampleDuration + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamplesTest >> test_4_5_baseAnimation_secondLoop_step_fullDuration [

	| aBaseAnimation loopDoneCount loopDoneListener |
	aBaseAnimation := self test_4_4_baseAnimation_secondLoop_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.

	loopDoneCount := 0.
	loopDoneListener :=
		BlEventHandler
			on: BlAnimationLoopDoneEvent
			do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self
		assert: aBaseAnimation startTime
		equals: self exampleDate + self exampleDelay + self exampleDuration.
	self
		assert: aBaseAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay + self exampleDuration
			+ self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	aBaseAnimation removeEventHandler: loopDoneListener.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamplesTest >> test_5_1_sequential_first_secondStep_halfDuration [

	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	aSequentialAnimation := self test_4_2_sequential_first_step_fullDuration.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.545454545).
	self
		assert: aSequentialAnimation elapsedTime
		equals:
		self firstSequentialDuration + (self firstSequentialDuration / 2.0).

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self
		assert: aSequentialAnimation delayedStartTime
		equals: self exampleDate + self exampleDelay.

	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation delay equals: self exampleDelay.

	aFirstAnimation := aSequentialAnimation animations first.

	self assert: aFirstAnimation progress equals: 0.5.
	self
		assert: aFirstAnimation elapsedTime
		equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self
		assert: aFirstAnimation startTime
		equals:
		self exampleDate + self exampleDelay + self firstSequentialDuration.
	self
		assert: aFirstAnimation delayedStartTime
		equals:
		self exampleDate + self exampleDelay + self firstSequentialDuration.

	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation delay equals: 0 seconds.

	aSecondAnimation := aSequentialAnimation animations second.

	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.

	self
		assert: aSecondAnimation loops
		equals: self secondSequentialLoops.
	self
		assert: aSecondAnimation delay
		equals: self secondSequentialDelay.

	^ aSequentialAnimation
]
