examples - fling down
_2_flingDownWithOvershoot500_flingDown500
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self _1_flingDownWithOvershoot500_first205ms.
	aScrollPane flingBy: (0@500).
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: 500).
	self assert: aScrollerY currentPosition equals: 0.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep ballistic.
	self assert: aScrollerY deceleration equals: -4489.
	self assert: aScrollerY duration equals: 149 milliSeconds.
	self assert: aScrollerY finalPosition equals: 50.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: 84.
	self assert: aScrollerY splineDuration equals: 0 milliSeconds.
	self assert: aScrollerY startPosition equals: 0.
	self assert: aScrollerY startTime equals: self simulatedDate + 120 milliSeconds.
	self assert: aScrollerY startVelocity equals: 670.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@50.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 295 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {41. 42. 43. 45. 46. 47. 47. 48. 49. 49. 50. 50. 50. 50. 50. 50. 49. 49. 48. 47. 47. 46. 44. 43. 42. 41. 39. 38. 37. 35. 33. 32. 30. 29. 27. 25. 23. 22. 20. 19. 17. 15. 14. 12. 11. 9. 8. 7. 6. 5. 4. 3. 2. 1. 1. 0. 0. 0. 0}.

	^ aScrollPane