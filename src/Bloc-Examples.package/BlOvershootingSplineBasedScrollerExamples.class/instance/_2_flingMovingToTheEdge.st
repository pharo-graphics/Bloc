examples - overshot
_2_flingMovingToTheEdge
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