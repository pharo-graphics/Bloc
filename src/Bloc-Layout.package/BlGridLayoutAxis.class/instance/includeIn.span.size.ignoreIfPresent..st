computing arcs
includeIn: theArcs span: span size: size ignoreIfPresent: ignoreIfPresent
	"arcs is collection of BlGridLayoutArc.
	span is Interval
	size is BlMutableInteger
	ignoreIfPresent is Boolean"

	span size = 1
		ifTrue: [ ^ self ].
	
	(ignoreIfPresent
		and: [ theArcs anySatisfy: [ :arc | arc span = span ] ])
			ifTrue: [ ^ self ].
	
	theArcs add: ( BlGridLayoutArc span: span value: size )