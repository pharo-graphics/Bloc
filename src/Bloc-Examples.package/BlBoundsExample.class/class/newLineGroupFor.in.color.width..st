as yet unclassified
newLineGroupFor: aBounds in: aParent color: aColor width: aWidth
	| grp |
	grp := BlElement new
		background: Color transparent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	grp
		"addChild:
			(BlElement new
				position: aBounds origin;
				extent: aBounds extent;
				background: (aColor alpha: 0.1));"
		addChild:
			(self
				newLineFrom: aBounds origin x @ 0
				to: aBounds origin x @ aParent height
				color: aColor
				width: aWidth);
		addChild:
			(self
				newLineFrom: aBounds corner x @ 0
				to: aBounds corner x @ aParent height
				color: aColor
				width: aWidth);
		addChild:
			(self
				newLineFrom: 0 @ aBounds origin y
				to: aParent width @ aBounds origin y
				color: aColor
				width: aWidth);
		addChild:
			(self
				newLineFrom: 0 @ aBounds corner y
				to: aParent width @ aBounds corner y
				color: aColor
				width: aWidth).
	^ grp