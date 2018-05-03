examples - fling up
_1_flingUp500_first205ms
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |

	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500) negated.
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	self assert: aScrollPane scrollFlinger scroller time equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500) negated asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 200 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. -2. -5. -7. -10. -12. -15. -17. -19. -21. -24. -26. -28. -30. -32. -34. -36. -38. -39. -41. -43. -44. -46. -47. -49. -50. -51. -53. -54. -55. -56. -58. -59. -60. -61. -62. -63. -64. -64. -65}.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: -167.16293).
	self assert: aScrollerY currentPosition equals: -65.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aScrollerY deceleration equals: 0.
	self assert: aScrollerY duration equals: 485 milliSeconds.
	self assert: aScrollerY finalPosition equals: -84.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: -84.
	self assert: aScrollerY splineDuration equals: 485 milliSeconds.
	self assert: aScrollerY startPosition equals: 0.
	self assert: aScrollerY startTime equals: self simulatedDate.
	self assert: aScrollerY startVelocity equals: -500.

	^ aScrollPane