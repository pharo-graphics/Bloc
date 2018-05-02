examples - fling down
flingUp500Complete
	<gtExample>
	| aScrollPane theScrollPositions |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane flingBy: (0@500 negated).
	
	self assert: aScrollPane space taskQueue tasks equals: { aScrollPane scrollFlinger }.
	
	"make sure we are in sync with the space time"
	self
		assert: aScrollPane scrollFlinger scroller time
		equals: aScrollPane space time.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@0.
	self assert: aScrollPane scrollFlinger scroller velocity equals: (0@500 negated) asBlocVector.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 495 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {0. -2. -5. -7. -10. -12. -15. -17. -19. -21. -24. -26. -28. -30. -32. -34. -36. -38. -39. -41. -43. -44. -46. -47. -49. -50. -51. -53. -54. -55. -56. -58. -59. -60. -61. -62. -63. -64. -64. -65. -66. -67. -68. -68. -69. -70. -71. -71. -72. -72. -73. -74. -74. -75. -75. -76. -76. -77. -77. -77. -78. -78. -78. -79. -79. -80. -80. -80. -80. -81. -81. -81. -81. -82. -82. -82. -82. -82. -83. -83. -83. -83. -83. -83. -83. -83. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84. -84}.

	^ aScrollPane