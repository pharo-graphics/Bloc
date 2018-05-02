examples - fling down
flingDownWithOvershoot500Complete
	<gtExample>
	| aScrollPane theScrollPositions |
	
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
		during: 430 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: { 0. 2. 5. 7. 10. 12. 14. 16. 18. 20. 22. 24. 26. 27. 29. 30. 32. 33. 35. 36. 38. 39. 40. 41. 42. 43. 44. 45. 45. 46. 47. 47. 48. 48. 49. 49. 50. 50. 50. 50. 50. 50. 50. 49. 49. 48. 48. 47. 46. 45. 44. 42. 41. 40. 38. 37. 35. 34. 32. 31. 29. 27. 26. 24. 22. 20. 19. 17. 16. 14. 13. 11. 10. 8. 7. 6. 5. 4. 3. 2. 1. 1. 0. 0. 0. 0 }.

	^ aScrollPane