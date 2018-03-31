examples - overshot
_4_flingMovingToTheOvershotMax
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