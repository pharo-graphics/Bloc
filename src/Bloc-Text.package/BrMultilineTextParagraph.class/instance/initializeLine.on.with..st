initialize-release
initializeLine: aLine on: aCanvas with: aContext
	| iterator |

	iterator := aLine iterator: 1 to: aLine size.
	[ iterator hasNext and: [ aContext availableHeight > 0 ] ] whileTrue: [ 
		| span |
		span := iterator nextSpan.
		self initializeSpan: span on: aCanvas with: aContext.
		aContext pushPosition: iterator position - 2 ].
	aContext pushLine