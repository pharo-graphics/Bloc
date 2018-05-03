examples - fling consecutive
flingUpDownConsecutive
	<gtExample>
	| aScrollPane theScrollPositions theVelocities |
	
	aScrollPane := self scrollPaneWithContentInSpace.
	aScrollPane size: self largeScrollPaneExtent.
	aScrollPane contentElement size: self largeContentExtent.
	
	theScrollPositions := OrderedCollection new.
	theVelocities := OrderedCollection new.
	
	aScrollPane flingBy: (0@500).
	aScrollPane space time
		every: 1 milliSeconds
		during: 24 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
	
	aScrollPane flingBy: (0@500).
	aScrollPane space time
		every: 1 milliSeconds
		during: 131 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
		
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.
		
	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.
		
	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time wait: 1 milliSecond.
	aScrollPane flingBy: (0@500) negated.
	aScrollPane space pulse.

	theScrollPositions add: aScrollPane scrollPosition y.
	theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity.
	
	aScrollPane space time
		every: 1 milliSeconds
		during: 131 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y.
			theVelocities add: aScrollPane scrollFlinger scroller scrollerY currentVelocity ].
	
	^ aScrollPane