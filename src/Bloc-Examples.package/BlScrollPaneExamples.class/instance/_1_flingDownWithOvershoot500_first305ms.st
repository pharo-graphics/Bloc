examples - fling down
_1_flingDownWithOvershoot500_first305ms
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 300 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. 2. 5. 7. 10. 12. 14. 16. 18. 20. 22. 24. 26. 27. 29. 30. 32. 33. 35. 36. 38. 39. 40. 41. 42. 43. 44. 45. 45. 46. 47. 47. 48. 48. 49. 49. 50. 50. 50. 50. 50. 50. 50. 49. 49. 48. 48. 47. 46. 45. 44. 42. 41. 40. 38. 37. 35. 34. 32. 31}.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: 73.3576).
	self assert: aScrollerY currentPosition equals: 31.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep cubic.
	self assert: aScrollerY deceleration equals: -2000.
	self assert: aScrollerY duration equals: 223 milliSeconds.
	self assert: aScrollerY finalPosition equals: 0.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: 84.
	self assert: aScrollerY splineDuration equals: 485 milliSeconds.
	self assert: aScrollerY startPosition equals: 50.
	self assert: aScrollerY startTime equals: self simulatedDate + 200 milliSeconds.
	self assert: aScrollerY startVelocity equals: -50.

	^ aScrollPane