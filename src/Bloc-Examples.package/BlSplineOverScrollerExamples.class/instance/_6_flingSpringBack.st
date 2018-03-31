examples - overshot
_6_flingSpringBack
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