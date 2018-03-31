scrolling
springBack: aStartPoint min: aMinPoint max: aMaxPoint
	| didSpringX didSpringY |

	didSpringX := scrollerX springback: aStartPoint x min: aMinPoint x max: aMaxPoint x.
	didSpringY := scrollerY springback: aStartPoint y min: aMinPoint y max: aMaxPoint y.
	
	^ didSpringX or: [ didSpringY ]