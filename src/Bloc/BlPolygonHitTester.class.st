"
I determine if a point is included in a polygon.

I'm based on AthensPolygonTester.

See: https://wrfranklin.org/Research/Short_Notes/pnpoly.html

"
Class {
	#name : 'BlPolygonHitTester',
	#superclass : 'Object',
	#package : 'Bloc',
	#tag : 'Basic-Geometry'
}

{ #category : 'testing' }
BlPolygonHitTester class >> doPolygonBy: vertices include: aPoint [

	| inside testX testY i j size |
	inside := false.

	i := 1.
	size := vertices size.
	j := size.
	testX := aPoint x.
	testY := aPoint y.

	[ i <= size ] whileTrue: [ 
		| pi pj |
		pi := vertices at: i.
		pj := vertices at: j.

		(pi y > testY ~= (pj y > testY) and: [ 
			testX < ((((pj x - pi x) * (testY - pi y)) / (pj y - pi y)) + pi x) ]) 
				ifTrue: [ inside := inside not ].

		j := i.
		i := i + 1 ].

	^ inside
]
