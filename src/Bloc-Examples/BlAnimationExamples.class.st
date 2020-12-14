"
I contain examples of bloc's Animation framework.

DOES NOT WORK
"
Class {
	#name : #BlAnimationExamples,
	#superclass : #Object,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Bloc-Examples-Animation'
}

{ #category : #examples }
BlAnimationExamples class >> ballsAnim [
	<script: 'self ballsAnim'>
	|space els anims|
	anims := OrderedCollection new.
	els := OrderedCollection new.

	(1 to:100) do: [:i| |el tr alp ii| 
		ii := i % 25.
		el := (BlEllipseGeometry new extent: 30@30) asElement 
		background: (Color white alpha: 0);
		relocate: (ii*15)@10.
			
		tr := BlTransformAnimation new
			target: el;
			transformDo: [ :aBuilder | aBuilder translateBy: (ii*15) @(500 -(30*((i/25)ceiling) )) ];
			delay: 80 milliSeconds * i;
			duration: 500 milliSeconds;
			easing: BlEasing bounceOut.
			
		alp := BlColorTransition new
					from: (Color white alpha: 0);
					to: Color random;
					delay: 80 milliSeconds * i;
					duration: 100 milliSeconds;
					onStepDo: [ :c | el background: c].
		anims addAll: {tr.alp}.els add: el ].

	space := BlSpace new.
	space root addChildren: els.
	space show.

	space root addAnimation: (BlParallelAnimation new addAll: anims)
]

{ #category : #examples }
BlAnimationExamples class >> bouncingChicken [
	<script: 'self bouncingChicken'>
	
	self
		openInWindow: self new bouncingChicken
		named: 'Bouncing chicken'
		extent: 600@600
]

{ #category : #examples }
BlAnimationExamples class >> bouncingText [
	"Click on letters to start animation"
	<script: 'self bouncingText'>

	self
		openInWindow: self new bouncingText
		named: 'Bouncing text (Click on letters)'
		extent: 850 @ 520
]

{ #category : #examples }
BlAnimationExamples class >> sequential [
	<script: 'self sequential'>
	| space element translation scale sequential |
	
	translation := (BlTransformAnimation translate: 300 @ 300)
		easing: BlEasing bounceOut;
		duration: 2 seconds.

	scale := (BlTransformAnimation scale: 2 @ 2)
		easing: BlEasing bounceOut;
		duration: 2 seconds.

	sequential := BlSequentialAnimation new addAll: { translation. scale }.
	
	element := BlElement new
		background: Color blue;
		size: 100 @ 100;
		relocate: 100 @ 100.	
	element addAnimation: sequential.
	
	space := BlSpace new.
	space root addChild: element.
	space show
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _1_1_sequential_addFirstChild [
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := self sequentialAnimationWithDelayAndTwoLoops.
	aSequentialAnimation add: (BlAnimation new duration: self firstSequentialDuration; loops: self firstSequentialLoops).
	
	self assert: aSequentialAnimation duration equals: self firstSequentialDuration * self firstSequentialLoops.
	
	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _1_2_sequential_addSecondChild [
	<gtExample>
	| aSequentialAnimation aTotalDuration |

	aSequentialAnimation := self _1_1_sequential_addFirstChild.
	aSequentialAnimation add: (BlAnimation new
		duration: self secondSequentialDuration;
		loops: self secondSequentialLoops;
		delay: self secondSequentialDelay).
	
	aTotalDuration := self firstSequentialDuration * self firstSequentialLoops.
	aTotalDuration := aTotalDuration + ((self secondSequentialDuration + self secondSequentialDelay) * self secondSequentialLoops).
	
	self assert: aSequentialAnimation duration equals: aTotalDuration.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _1_baseAnimation_start [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self baseAnimationWithDelayAndDurationAndTwoLoops.	
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamples >> _1_massive_infiniteAnimation_start [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self baseAnimation.	
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
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamples >> _1_massive_oneLoopAnimation_start [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self baseAnimation.	
	aBaseAnimation duration: self exampleDuration.
	aBaseAnimation start.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamples >> _1_massive_twoLoopAnimation_start [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self baseAnimation.	
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
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _2_1_baseAnimation_step [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_baseAnimation_start.	
	"do a cycle without advancing the clock"
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamples >> _2_1_massive_infiniteAnimation_step_oneDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamples >> _2_1_massive_oneLoopAnimation_step_oneDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamples >> _2_1_massive_twoLoopAnimation_step_oneDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _2_1_sequential_step [
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := self _1_2_sequential_addSecondChild.
	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _2_2_baseAnimation_step_halfDelay [
	"in this example we see what exactly happens when half of delay elapsed"
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _2_1_baseAnimation_step.
	aBaseAnimation time wait: self exampleDelay / 2.0.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamples >> _2_2_massive_infiniteAnimation_step_twiceDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate + self exampleDuration.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDuration.
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamples >> _2_2_massive_oneLoopAnimation_step_twiceDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamples >> _2_2_massive_twoLoopAnimation_step_twiceDuration [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 2.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate + self exampleDuration.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _2_3_baseAnimation_step_fullDelay [
	"in this example we see what exactly happens when the whole delay elapsed"
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _2_2_baseAnimation_step_halfDelay.
	aBaseAnimation time wait: self exampleDelay / 2.0.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamples >> _2_3_massive_infiniteAnimation_step_trippleDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate + (self exampleDuration * 2).
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + (self exampleDuration * 2).
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 3.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - infinite' }
BlAnimationExamples >> _2_3_massive_infiniteAnimation_step_trippleDurationAndHalf [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_infiniteAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.5.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.
	self assert: aBaseAnimation isInfinite.

	self assert: aBaseAnimation startTime equals: self exampleDate + (self exampleDuration * 3).
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + (self exampleDuration * 3).
	
	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 3.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - one' }
BlAnimationExamples >> _2_3_massive_oneLoopAnimation_step_trippleDuration [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := self _1_massive_oneLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.
	
	aBaseAnimation run.
	
	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate.
	
	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - massive time delta - two' }
BlAnimationExamples >> _2_3_massive_twoLoopAnimation_step_trippleDuration [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _1_massive_twoLoopAnimation_start.
	aBaseAnimation time wait: self exampleDuration * 3.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.0.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: self exampleDate + self exampleDuration.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 2.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _3_1_baseAnimation_step_quarterOfDuration [
	"in this example we see what exactly happens when one quarter of duration is passed"
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _2_3_baseAnimation_step_fullDelay.
	aBaseAnimation time wait: self exampleDuration / 4.0.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.25.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 4.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	
	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _3_1_sequential_step_halfDelay [
	"in this example we see what exactly happens when a half of the delay elapsed"
	<gtExample>
	| aSequentialAnimation |
	
	aSequentialAnimation := self _2_1_sequential_step.
	aSequentialAnimation time wait: self exampleDelay / 2.0.

	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _3_2_baseAnimation_step_halfOfDuration [
	"in this example we see what exactly happens when half of the duration is passed"
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _3_1_baseAnimation_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	
	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _3_2_sequential_step_fullDelay [
	<gtExample>
	| aSequentialAnimation |
	
	aSequentialAnimation := self _3_1_sequential_step_halfDelay.
	aSequentialAnimation time wait: self exampleDelay / 2.0.

	aSequentialAnimation run.

	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation elapsedTime equals: 0 seconds.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _3_3_baseAnimation_step_fullDuration [
	"in this example we see what exactly happens when the whole duration is passed"
	<gtExample>
	| aBaseAnimation loopDoneListener loopDoneCount |

	aBaseAnimation := self _3_2_baseAnimation_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.

	loopDoneCount := 0.
	loopDoneListener := BlEventHandler on: BlAnimationLoopDoneEvent do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.

	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: self exampleDate.
	self assert: aBaseAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	aBaseAnimation removeEventHandler: loopDoneListener.
	
	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _4_1_baseAnimation_secondLoop_step_halfDelay [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _3_3_baseAnimation_step_fullDuration.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _4_1_sequential_first_step_halfOfDuration [
	<gtExample>
	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	
	aSequentialAnimation := self _3_2_sequential_step_fullDelay.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.1818181).
	self assert: aSequentialAnimation elapsedTime equals: self firstSequentialDuration / 2.0.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	aFirstAnimation := aSequentialAnimation animations first.
	
	self assert: aFirstAnimation progress equals: 0.5.
	self assert: aFirstAnimation elapsedTime equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self assert: aFirstAnimation startTime equals: self exampleDate + self exampleDelay.
	self assert: aFirstAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation repeats equals: 0.
	self assert: aFirstAnimation delay equals: 0 seconds.
	
	aSecondAnimation := aSequentialAnimation animations second.
	
	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.
	
	self assert: aSecondAnimation loops equals: self secondSequentialLoops.
	self assert: aSecondAnimation repeats equals: 0.
	self assert: aSecondAnimation delay equals: self secondSequentialDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _4_2_baseAnimation_secondLoop_step_fullDelay [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _4_1_baseAnimation_secondLoop_step_halfDelay.
	aBaseAnimation time wait: self exampleDelay / 2.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.0.
	self assert: aBaseAnimation elapsedTime equals: 0 seconds.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _4_2_sequential_first_step_fullDuration [
	<gtExample>
	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	
	aSequentialAnimation := self _4_1_sequential_first_step_halfOfDuration.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.363636).
	self assert: aSequentialAnimation elapsedTime equals: self firstSequentialDuration.

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	aFirstAnimation := aSequentialAnimation animations first.
	
	self assert: aFirstAnimation progress equals: 1.0.
	self assert: aFirstAnimation elapsedTime equals: self firstSequentialDuration.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self assert: aFirstAnimation startTime equals: self exampleDate + self exampleDelay.
	self assert: aFirstAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation repeats equals: 1.
	self assert: aFirstAnimation delay equals: 0 seconds.
	
	aSecondAnimation := aSequentialAnimation animations second.
	
	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.
	
	self assert: aSecondAnimation loops equals: self secondSequentialLoops.
	self assert: aSecondAnimation repeats equals: 0.
	self assert: aSecondAnimation delay equals: self secondSequentialDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _4_2_sequential_first_step_fullDurationAndHalf [
	"The animation state must be equal to _5_1_sequential_first_secondStep_halfDuration,
	because we move time by the same amount"
	<gtExample>
	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	
	aSequentialAnimation := self _4_1_sequential_first_step_halfOfDuration.
	aSequentialAnimation time wait: self firstSequentialDuration.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.545454545).
	self assert: aSequentialAnimation elapsedTime equals: self firstSequentialDuration + (self firstSequentialDuration / 2.0).

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	aFirstAnimation := aSequentialAnimation animations first.
	
	self assert: aFirstAnimation progress equals: 0.5.
	self assert: aFirstAnimation elapsedTime equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self assert: aFirstAnimation startTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	self assert: aFirstAnimation delayedStartTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	
	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation repeats equals: 1.
	self assert: aFirstAnimation delay equals: 0 seconds.
	
	aSecondAnimation := aSequentialAnimation animations second.
	
	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.
	
	self assert: aSecondAnimation loops equals: self secondSequentialLoops.
	self assert: aSecondAnimation repeats equals: 0.
	self assert: aSecondAnimation delay equals: self secondSequentialDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _4_3_baseAnimation_secondLoop_step_quarterOfDuration [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _4_2_baseAnimation_secondLoop_step_fullDelay.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.25.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 4.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _4_4_baseAnimation_secondLoop_step_halfOfDuration [
	<gtExample>
	| aBaseAnimation |

	aBaseAnimation := self _4_3_baseAnimation_secondLoop_step_quarterOfDuration.
	aBaseAnimation time wait: self exampleDuration / 4.0.
	aBaseAnimation run.

	self assert: aBaseAnimation progress equals: 0.5.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration / 2.0.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 1.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> _4_5_baseAnimation_secondLoop_step_fullDuration [
	<gtExample>
	| aBaseAnimation loopDoneCount loopDoneListener |

	aBaseAnimation := self _4_4_baseAnimation_secondLoop_step_halfOfDuration.
	aBaseAnimation time wait: self exampleDuration / 2.0.
	
	loopDoneCount := 0.
	loopDoneListener := BlEventHandler on: BlAnimationLoopDoneEvent do: [ :anEvent | loopDoneCount := loopDoneCount + 1 ].
	aBaseAnimation addEventHandler: loopDoneListener.
	
	aBaseAnimation run.	

	self assert: aBaseAnimation progress equals: 1.
	self assert: aBaseAnimation elapsedTime equals: self exampleDuration.
	self assert: loopDoneCount equals: 1.

	self assert: aBaseAnimation isStarted.
	self assert: aBaseAnimation isRunning not.

	self assert: aBaseAnimation startTime equals: (self exampleDate + self exampleDelay + self exampleDuration).
	self assert: aBaseAnimation delayedStartTime equals: (self exampleDate + self exampleDelay + self exampleDuration) + self exampleDelay.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 2.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	
	aBaseAnimation removeEventHandler: loopDoneListener.

	^ aBaseAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> _5_1_sequential_first_secondStep_halfDuration [
	<gtExample>
	| aSequentialAnimation aFirstAnimation aSecondAnimation |
	
	aSequentialAnimation := self _4_2_sequential_first_step_fullDuration.
	aSequentialAnimation time wait: self firstSequentialDuration / 2.0.

	aSequentialAnimation run.

	self assert: (aSequentialAnimation progress closeTo: 0.545454545).
	self assert: aSequentialAnimation elapsedTime equals: self firstSequentialDuration + (self firstSequentialDuration / 2.0).

	self assert: aSequentialAnimation isStarted.
	self assert: aSequentialAnimation isRunning.

	self assert: aSequentialAnimation startTime equals: self exampleDate.
	self assert: aSequentialAnimation delayedStartTime equals: self exampleDate + self exampleDelay.
	
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	
	aFirstAnimation := aSequentialAnimation animations first.
	
	self assert: aFirstAnimation progress equals: 0.5.
	self assert: aFirstAnimation elapsedTime equals: self firstSequentialDuration / 2.0.

	self assert: aFirstAnimation isStarted.
	self assert: aFirstAnimation isRunning.

	self assert: aFirstAnimation startTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	self assert: aFirstAnimation delayedStartTime equals: self exampleDate + self exampleDelay + self firstSequentialDuration.
	
	self assert: aFirstAnimation loops equals: self firstSequentialLoops.
	self assert: aFirstAnimation repeats equals: 1.
	self assert: aFirstAnimation delay equals: 0 seconds.
	
	aSecondAnimation := aSequentialAnimation animations second.
	
	self assert: aSecondAnimation progress equals: 0.

	self assert: aSecondAnimation isStarted not.
	self assert: aSecondAnimation isRunning not.
	
	self assert: aSecondAnimation loops equals: self secondSequentialLoops.
	self assert: aSecondAnimation repeats equals: 0.
	self assert: aSecondAnimation delay equals: self secondSequentialDelay.
	
	^ aSequentialAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> baseAnimation [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.
	self assert: aBaseAnimation isInfinite not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> baseAnimationWithDelay [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	aBaseAnimation delay: self exampleDelay.

	self assert: aBaseAnimation loops equals: 1.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> baseAnimationWithDelayAndDurationAndTwoLoops [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	aBaseAnimation delay: self exampleDelay.
	aBaseAnimation loops: 2.
	aBaseAnimation duration: self exampleDuration.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: self exampleDuration.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> baseAnimationWithDelayAndTwoLoops [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).

	aBaseAnimation delay: self exampleDelay.
	aBaseAnimation loops: 2.

	self assert: aBaseAnimation loops equals: 2.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: self exampleDelay.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.

	^ aBaseAnimation
]

{ #category : #accessing }
BlAnimationExamples >> blueAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians < (Float pi / 2.0)
		ifTrue: [ ^ 0 ].
	^ (radians - (Float pi / 2.0)) sin
]

{ #category : #examples }
BlAnimationExamples >> bouncingChicken [
	<gtExample>
	| element animation |
	element := BlChicken chicken.
	element relocate: 140@40.
	element transform
		scaleBy: 0.1@0.1;
		translateBy: (100@300) negated;
		rotateBy: -30;
		apply.
	animation := BlTransformAnimation new.
	animation transform
		scaleBy: 1@1;
		translateBy: 0@0;
		rotateBy: 0;
		apply.
	animation absolute.
	animation duration: 4 seconds.
	animation easing: BlEasing bounceIn.
	
	element addAnimation: animation.
	
	^ element
]

{ #category : #examples }
BlAnimationExamples >> bouncingText [
	"Click on letters to start animation!"
	| letters container animation clickHandler |
	<gtExample>

	letters := 'bloc beta0.1' collect: [ :aCharacter | self textElement: aCharacter ] as: Array.
	letters withIndexDo: [  :aTextElement :anIndex |
		"change text color according to index in color spectrum"
		aTextElement text: (aTextElement text foreground: (self colorAt: (anIndex / letters size) asFloat)) ].

	animation := BlParallelAnimation with: (letters withIndexCollect: [ :aChild :anIndex |
		| jiggle |
		jiggle := self jiggleAnimation.
		jiggle delay: 20 milliSeconds * (anIndex - 1).
		jiggle target: aChild.
		jiggle ]).

	container := self textContainer.
	container addChildren: letters.
	
	clickHandler := nil.
	clickHandler := BlEventHandler
		on: BlClickEvent
		do: [
			container removeEventHandler: clickHandler.
			container addAnimation: animation ].
	container addEventHandler: clickHandler.

	^ self frameContainer addChild: container
]

{ #category : #accessing }
BlAnimationExamples >> colorAt: anIndex [
	| normalizedIndex |
	"0.0 <= anIndex <= 1.0"
	
	normalizedIndex := anIndex.
	"Because of float errors"
	normalizedIndex > 1 ifTrue: [ normalizedIndex := 1 ].
	normalizedIndex < 0 ifTrue: [ normalizedIndex := 0 ].
	
	^ Color
		r: (self redAt: normalizedIndex)
		g: (self greenAt: normalizedIndex)
		b: (self blueAt: normalizedIndex)
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> exampleDate [
	^ DateAndTime year: 2018 month: 3 day: 31
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> exampleDelay [
	^ 0.5 seconds
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> exampleDuration [
	^ 2 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> firstSequentialDuration [
	^ 8 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> firstSequentialLoops [
	^ 2
]

{ #category : #'instance creation' }
BlAnimationExamples >> frameContainer [
	<gtExample>

	^ BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		clipChildren: false
]

{ #category : #accessing }
BlAnimationExamples >> greenAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians > Float pi
		ifTrue: [ ^ 0 ].
	^ radians sin
]

{ #category : #'examples - base animation' }
BlAnimationExamples >> infiniteAnimation [
	<gtExample>
	| aBaseAnimation |
	
	aBaseAnimation := BlAnimation new.
	aBaseAnimation time: (BlTime simulated date: self exampleDate).
	aBaseAnimation beInfinite.

	self assert: aBaseAnimation loops equals: Float infinity.
	self assert: aBaseAnimation repeats equals: 0.
	self assert: aBaseAnimation progress equals: 0.
	self assert: aBaseAnimation delay equals: 0 seconds.
	self assert: aBaseAnimation duration equals: 1 seconds.
	self assert: aBaseAnimation isStarted not.
	self assert: aBaseAnimation isRunning not.
	self assert: aBaseAnimation isInfinite.

	^ aBaseAnimation
]

{ #category : #'instance creation' }
BlAnimationExamples >> jiggleAnimation [
	| anAnimation |
	<gtExample>
	
	anAnimation := BlTransformAnimation new.
	anAnimation transform
		translateBy: 0 @ (50 + 20 atRandom) negated;
		rotateBy: (30 atRandom - 15);
		scaleBy: (1.3 + (20 atRandom / 100.0))@(1.3 + (20 atRandom / 100.0));
		apply.
	anAnimation absolute.
	anAnimation easing: (BlSineInterpolator new range: Float pi).	
	anAnimation loops: 3.
	anAnimation duration: 1 second.
	
	^ anAnimation
]

{ #category : #accessing }
BlAnimationExamples >> radiansAt: anIndex [
	"0.0 <= anIndex <= 1.0"
	self assert: [ anIndex between: 0.0 and: 1.0 ].
	
	^ anIndex * (Float pi * 3) / 2.0
]

{ #category : #accessing }
BlAnimationExamples >> redAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	(radians between: Float pi / 2.0 and: Float pi) 
		ifTrue: [ ^ 0 ].

	radians < (Float pi/ 2.0)
		ifTrue: [ ^ (radians + (Float pi / 2)) sin ].

	^ (radians + Float pi) sin
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> secondSequentialDelay [
	^ 2 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> secondSequentialDuration [
	^ 4 seconds
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> secondSequentialLoops [
	^ 1
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> sequentialAnimation [
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: (BlTime simulated date: self exampleDate).

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: 0 seconds.
	self assert: aSequentialAnimation loops equals: 1.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> sequentialAnimationWithDelay [
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: (BlTime simulated date: self exampleDate).
	
	aSequentialAnimation delay: self exampleDelay.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	self assert: aSequentialAnimation loops equals: 1.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'examples - sequential animation' }
BlAnimationExamples >> sequentialAnimationWithDelayAndTwoLoops [
	<gtExample>
	| aSequentialAnimation |

	aSequentialAnimation := BlSequentialAnimation new.
	aSequentialAnimation time: (BlTime simulated date: self exampleDate).

	aSequentialAnimation delay: self exampleDelay.
	aSequentialAnimation loops: 2.

	self assert: aSequentialAnimation duration equals: 0 seconds.
	self assert: aSequentialAnimation delay equals: self exampleDelay.
	self assert: aSequentialAnimation loops equals: 2.
	self assert: aSequentialAnimation repeats equals: 0.
	self assert: aSequentialAnimation progress equals: 0.
	self assert: aSequentialAnimation isStarted not.
	self assert: aSequentialAnimation isRunning not.

	^ aSequentialAnimation
]

{ #category : #'instance creation' }
BlAnimationExamples >> textContainer [
	<gtExample>

	^ BlElement new
		layout: (BlLinearLayout horizontal alignBottomCenter);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		clipChildren: false
]

{ #category : #accessing }
BlAnimationExamples >> textElement: aCharacter [
	| aText |
	
	aText := aCharacter asRopedText
		fontSize: 90;
		fontName: "'Bauhaus 93'" "'Curlz MT'" 'Phosphate'.
	
	^ BlTextElement new 
		text: aText;
		effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 0@0)
]
