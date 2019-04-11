"
I contain examples of the spline overscroller
"
Class {
	#name : #BlOvershootingSplineBasedScrollerExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Scrolling'
}

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _1_flingWithOvershot [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 1000
		start: 150
		min: 100 max: 200
		over: 50.

	self assert: aSplineOverScroller currentVelocity equals: 1000.0.
	self assert: aSplineOverScroller currentPosition equals: 150.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 50 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 150.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 1000.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _2_flingMovingToTheEdge [
	<gtExample>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |

	aSplineOverScroller := self _1_flingWithOvershot.
	
	expectedPositions := { 150 . 155 . 160 . 165 . 170 . 175 . 180 . 185 . 190 . 194 . 199 }.
	expectedVelocities := { 1000.0 . 999.54034 . 997.88873 . 997.88873 . 992.5039 . 984.4191 . 984.4191 . 973.8018 . 973.8018 . 962.2275 . 947.04535 }.
	
	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.
	
	aSplineOverScroller time
			every: 5 milliSeconds
			while: [ aSplineOverScroller update ]
			do: [
				theActualPositions add: aSplineOverScroller currentPosition.
				theActualVelocities add: aSplineOverScroller currentVelocity ].
	self
		assert: theActualPositions asArray
		equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	self assert: (aSplineOverScroller currentVelocity closeTo: 947.04535).
	self assert: aSplineOverScroller currentPosition equals: 199.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 50 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 150.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 1000.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _3_flingContinueWhenReachedTheEdge [
	<gtExample>
	| aSplineOverScroller shouldContinue |

	aSplineOverScroller := self _2_flingMovingToTheEdge.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	"we should spring back, because velocity is very high and we overshot"
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 902.15955).
	self assert: aSplineOverScroller currentPosition equals: 205. "<- since we overshot position is greater than 200"
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: (aSplineOverScroller deceleration closeTo: -8968.09).
	self assert: aSplineOverScroller duration equals: 105 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 250.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 200. "<- we start springing back from our previous 'final' position"
	self assert: aSplineOverScroller startTime equals: self exampleDate + 50 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: 947.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _4_flingMovingToTheOvershotMax [
	<gtExample>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |

	aSplineOverScroller := self _3_flingContinueWhenReachedTheEdge.
	
	expectedPositions := { 205 . 209 . 213 . 217 . 221 . 224 . 228 . 231 . 234 . 236 . 239 . 241 . 243 . 244 . 246 . 247 . 248 . 249 . 249 . 250 . 250 }.
	expectedVelocities := { 902.15955 . 857.3191 . 812.47864 . 767.6382 . 722.7977 . 677.9573 . 633.1168 . 588.2764 . 543.4359 . 498.5955 . 453.75507 . 408.9146 . 364.07416 . 319.2337 . 274.39325 . 229.55286 . 184.71234 . 139.87189 . 95.031494 . 50.19098 . 5.350586 }.
	
	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.
	
	aSplineOverScroller time
			every: 5 milliSeconds
			while: [ aSplineOverScroller update ]
			do: [
				theActualPositions add: aSplineOverScroller currentPosition.
				theActualVelocities add: aSplineOverScroller currentVelocity ].
	self
		assert: theActualPositions asArray
		equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	self assert: (aSplineOverScroller currentVelocity closeTo: 5.350586).
	self assert: aSplineOverScroller currentPosition equals: 250. "<- we reached the max overshot position = 200 (final requested) + 50 (overshot distance)"
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: (aSplineOverScroller deceleration closeTo: -8968.09).
	self assert: aSplineOverScroller duration equals: 105 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 250.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 200. "<- we start springing back from our previous 'final' position"
	self assert: aSplineOverScroller startTime equals: self exampleDate + 50 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: 947.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _5_flingContinueWhenReachedTheOvershotMax [
	<gtExample>
	| aSplineOverScroller shouldContinue |

	aSplineOverScroller := self _4_flingMovingToTheOvershotMax.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	self assert: shouldContinue.

	self assert: (aSplineOverScroller currentVelocity closeTo: 6.5756397).
	self assert: aSplineOverScroller currentPosition equals: 250.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self assert: aSplineOverScroller startTime equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _6_flingSpringBack [
	<gtExample>
	| aSplineOverScroller expectedPositions expectedVelocities theActualPositions theActualVelocities |

	aSplineOverScroller := self _5_flingContinueWhenReachedTheOvershotMax.
	
	expectedPositions := { 250 . 250 . 249 . 249 . 248 . 248 . 247 . 246 . 245 . 244 . 242 . 241 . 240 . 238 . 237 . 235 . 234 . 232 . 231 . 229 . 227 . 226 . 224 . 222 . 220 . 219 . 217 . 216 . 214 . 213 . 211 . 210 . 208 . 207 . 206 . 205 . 204 . 203 . 202 . 201 . 201 . 200 . 200 . 200 }.
	expectedVelocities := {6.5756397. 12.849645. 18.822016. 24.49275. 29.86185. 34.929317. 39.69515. 44.159344. 48.321903. 52.18283. 55.742123. 58.99978. 61.9558. 64.61018. 66.96294. 69.01405. 70.76354. 72.21138. 73.3576. 74.20218. 74.74512. 74.98643. 74.926094. 74.56414. 73.90054. 72.93531. 71.668434. 70.099945. 68.22981. 66.05804. 63.584625. 60.809593. 57.73292. 54.354607. 50.674652. 46.693073. 42.409855. 37.825012. 32.93853. 27.75042. 22.260654. 16.469265. 10.376233. 3.9815784}.
	
	theActualPositions := OrderedCollection new.
	theActualVelocities := OrderedCollection new.
	
	aSplineOverScroller time
			every: 5 milliSeconds
			while: [ aSplineOverScroller update ]
			do: [
				theActualPositions add: aSplineOverScroller currentPosition.
				theActualVelocities add: aSplineOverScroller currentVelocity ].
	self
		assert: theActualPositions asArray
		equals: expectedPositions.

	theActualVelocities
		with: expectedVelocities
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	self assert: (aSplineOverScroller currentVelocity closeTo: 3.9815784).
	self assert: aSplineOverScroller currentPosition equals: 200.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self assert: aSplineOverScroller startTime equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _7_flingContinueAfterSpringBack [
	<gtExample>
	| aSplineOverScroller shouldContinue |

	aSplineOverScroller := self _6_flingSpringBack.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.

	shouldContinue := aSplineOverScroller continue.
	self assert: shouldContinue not.

	self assert: (aSplineOverScroller currentVelocity closeTo: 3.9815784).
	self assert: aSplineOverScroller currentPosition equals: 200.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self assert: aSplineOverScroller startTime equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - overshot' }
BlOvershootingSplineBasedScrollerExamples >> _8_flingFinish [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self _7_flingContinueAfterSpringBack.
	
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller update not.
	self assert: aSplineOverScroller continue not.
	
	aSplineOverScroller finish.

	self assert: aSplineOverScroller currentVelocity equals: 0.
	self assert: aSplineOverScroller currentPosition equals: 200.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: (aSplineOverScroller deceleration closeTo: -2000.0).
	self assert: aSplineOverScroller duration equals: 223 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 200.
	self assert: aSplineOverScroller isFinished.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 50.
	self assert: aSplineOverScroller splineDistance equals: 283.
	self assert: aSplineOverScroller splineDuration equals: 808 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 250.
	self assert: aSplineOverScroller startTime equals: self exampleDate + 155 milliSeconds.
	self assert: aSplineOverScroller startVelocity equals: -50.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> adjustDuration [
	<gtExample>
	| aSplineOverScroller aDjustedDuration |

	aSplineOverScroller := self splineOverScroller.

	aDjustedDuration := aSplineOverScroller
		adjustDuration: 808 milliSeconds
		start: 150 final: 200
		previousFinal: 433.

	self
		assert: aDjustedDuration
		equals: 50 milliSeconds.

	^ aDjustedDuration
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> decelerationRate [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller decelerationRate closeTo: 2.3582017).

	^ aSplineOverScroller decelerationRate
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> endTension [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller endTension closeTo: 1).

	^ aSplineOverScroller endTension
]

{ #category : #accessing }
BlOvershootingSplineBasedScrollerExamples >> exampleDate [
	^ DateAndTime year: 2018 month: 3 day: 31
]

{ #category : #'examples - finish' }
BlOvershootingSplineBasedScrollerExamples >> finishWithoutStarting [
	<gtExample>
	| aSplineOverScroller |
	
	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller finish.
	
	self assert: aSplineOverScroller currentPosition equals: 0.0.
	self assert: aSplineOverScroller currentVelocity equals: 0.0.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	
	self assert: aSplineOverScroller isFinished.
	
	self assert: aSplineOverScroller splineDistance equals: 0.0.
	self assert: aSplineOverScroller splineDuration isZero.
	
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	
	self assert: aSplineOverScroller ppi equals: 96.0.
	
	^ aSplineOverScroller
]

{ #category : #'examples - fling' }
BlOvershootingSplineBasedScrollerExamples >> flingVelocity100_from0_min0_max100_over0 [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	aSplineOverScroller time: (BlTime simulated date: self exampleDate).
	aSplineOverScroller
		fling: 100
		start: 0
		min: 0 max: 100
		over: 0.

	self assert: aSplineOverScroller currentVelocity equals: 100.0.
	self assert: aSplineOverScroller currentPosition equals: 0.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	self assert: aSplineOverScroller duration equals: 148 milliSeconds.
	self assert: aSplineOverScroller finalPosition equals: 5.
	self assert: aSplineOverScroller isFinished not.
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller overshotDistance equals: 0.
	self assert: aSplineOverScroller splineDistance equals: 5.
	self assert: aSplineOverScroller splineDuration equals: 148 milliSeconds.
	self assert: aSplineOverScroller startPosition equals: 0.
	self assert: aSplineOverScroller startTime equals: self exampleDate.
	self assert: aSplineOverScroller startVelocity equals: 100.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> friction [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller friction closeTo: 0.015).

	^ aSplineOverScroller friction
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> inflexion [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller inflexion closeTo: 0.35).

	^ aSplineOverScroller inflexion
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> nbSamples [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self
		assert: aSplineOverScroller nbSamples
		equals: 100.

	^ aSplineOverScroller nbSamples
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> physicalCoefficient [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.
	
	"physical coefficient depends on ppi"
	self assert: (aSplineOverScroller physicalCoefficient closeTo: 31134.12).

	^ aSplineOverScroller physicalCoefficient
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineDeceleration [
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.
	
	"spline deceleration depends on physical coefficient which depends on ppi"
	"velocity -> spline deceleration"
	aVelocityMapping := { 
		0 -> Float negativeInfinity.
		1 -> -7.196176620396506.
		2 -> -6.503029439836561.
		4 -> -5.809882259276615.
		8 -> -5.11673507871667.
		16 -> -4.4235878981567245.
		32 -> -3.7304407175967795.
		64 -> -3.037293537036834.
		128 -> -2.3441463564768887.
		256 -> -1.6509991759169433.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineDecelerationFor: anAssoc key) ].
	
	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].
		
	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineFlingDistance [
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.

	"velocity -> spline fling distance"
	aVelocityMapping := { 
		0 -> 0.0.
		1 -> 0.0017500093262010565.
		2 -> 0.005830543034945757.
		4 -> 0.01942574337940917.
		8 -> 0.06472115951823502.
		16 -> 0.2156328541756035.
		32 -> 0.718428534748616.
		64 -> 2.393603523518351.
		128 -> 7.974819415829869.
		256 -> 26.569874287958488.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDistanceFor: anAssoc key) ].
	
	anActualMapping
		with: aVelocityMapping
		do: [ :anActual :anExpected | self assert: (anActual value closeTo: anExpected value) ].
		
	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineFlingDuration [
	<gtExample>
	| aSplineOverScroller aVelocityMapping anActualMapping |
	
	aSplineOverScroller := self splineOverScroller.

	"velocity -> spline fling distance"
	aVelocityMapping := { 
		0 -> 0 milliSeconds.
		1 -> 5 milliSeconds.
		2 -> 8 milliSeconds.
		4 -> 13 milliSeconds.
		8 -> 23 milliSeconds.
		16 -> 38 milliSeconds.
		32 -> 64 milliSeconds.
		64 -> 106 milliSeconds.
		128 -> 178 milliSeconds.
		256 -> 296 milliSeconds.
	}.

	anActualMapping := aVelocityMapping collect: [ :anAssoc | anAssoc key -> (aSplineOverScroller splineFlingDurationFor: anAssoc key) ].
	
	self
		assert: anActualMapping
		equals: aVelocityMapping.
		
	^ anActualMapping asOrderedDictionary
]

{ #category : #'examples - instance creation' }
BlOvershootingSplineBasedScrollerExamples >> splineOverScroller [
	<gtExample>
	| aSplineOverScroller |
	
	aSplineOverScroller := BlOvershootingSplineBasedScroller new.
	
	self assert: aSplineOverScroller currentPosition equals: 0.0.
	self assert: aSplineOverScroller currentVelocity equals: 0.0.
	self assert: aSplineOverScroller currentStep equals: BlSplineOverScrollerStep spline.
	
	self assert: aSplineOverScroller splineDistance equals: 0.0.
	self assert: aSplineOverScroller splineDuration isZero.
	
	self assert: aSplineOverScroller friction equals: 0.015.
	self assert: aSplineOverScroller deceleration equals: 0.0.
	
	self assert: aSplineOverScroller ppi equals: 96.0.

	^ aSplineOverScroller
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> splineTime [
	<gtExample>
	| aSplineOverScroller anExpectedSplineTime |

	aSplineOverScroller := self splineOverScroller.
	
	anExpectedSplineTime := { 2.002716e-6 . 0.0035008886 . 0.0070031513 . 0.010507312 . 0.014013893 . 0.017523412 . 0.02104418 . 0.024568854 . 0.028097969 . 0.031639703 . 0.035194505 . 0.038755145 . 0.04233729 . 0.04592621 . 0.049529932 . 0.053156357 . 0.05679837 . 0.060456425 . 0.06413834 . 0.067844465 . 0.071567826 . 0.075316176 . 0.079097174 . 0.08290383 . 0.08673657 . 0.0905957 . 0.09448885 . 0.098416284 . 0.10238549 . 0.10638248 . 0.11042188 . 0.11449678 . 0.11861465 . 0.12278285 . 0.12698735 . 0.13124269 . 0.1355491 . 0.13989964 . 0.1443087 . 0.14877644 . 0.15329593 . 0.15788153 . 0.1625191 . 0.16722992 . 0.17200707 . 0.17685048 . 0.18176731 . 0.18675743 . 0.1918349 . 0.19699252 . 0.20223011 . 0.20755455 . 0.21297249 . 0.21849068 . 0.22410871 . 0.22983302 . 0.23565608 . 0.2415983 . 0.24765876 . 0.25383675 . 0.26014706 . 0.2665984 . 0.27317786 . 0.27991158 . 0.2868116 . 0.29384828 . 0.30107498 . 0.3084751 . 0.3160603 . 0.32383984 . 0.3318245 . 0.34003758 . 0.34848738 . 0.3571822 . 0.36612952 . 0.37534925 . 0.38488656 . 0.39473194 . 0.4049011 . 0.41544706 . 0.42638117 . 0.43773794 . 0.4495572 . 0.4618606 . 0.47472918 . 0.48817742 . 0.5023109 . 0.5171499 . 0.5328217 . 0.5494553 . 0.5671298 . 0.58606946 . 0.6064431 . 0.6285358 . 0.6527741 . 0.67973936 . 0.7102442 . 0.74580073 . 0.7892455 . 0.848082 . 1.0 }.
	
	aSplineOverScroller splineTime
		with: anExpectedSplineTime
		do: [ :anActual :anExpected | self assert: (anActual closeTo: anExpected) ].

	^ aSplineOverScroller splineTime
]

{ #category : #'examples - physics' }
BlOvershootingSplineBasedScrollerExamples >> startTension [
	<gtExample>
	| aSplineOverScroller |

	aSplineOverScroller := self splineOverScroller.

	self assert: (aSplineOverScroller startTension closeTo: 0.5).

	^ aSplineOverScroller startTension
]
