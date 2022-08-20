Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext | 
		self innerRadius = 0.0
			ifTrue: [ 
				cairoContext
					circleSectorFrom: self startAngle degreesToRadians
					to: self endAngle degreesToRadians
					radius: self absoluteOuterRadius ]
			ifFalse: [ 
				cairoContext
					annulusSectorFrom: self startAngle degreesToRadians
					to: self endAngle degreesToRadians
					innerRadius: self absoluteInnerRadius
					outerRadius: self absoluteOuterRadius
				] ]
]

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSPieSlice>>#preciseIncludesPoint:"

	| i e invertedPoint d n a b |
	aPoint traceCr.
	
	i := self absoluteInnerRadius.
	e := self absoluteOuterRadius.
	invertedPoint := aPoint - self center.
	d := invertedPoint distanceTo: 0@0.
	(d between: i and: e)
		ifFalse: [ ^ false ].

	n := invertedPoint angle radiansToDegrees.
	a := self startAngle.
	b := self endAngle.
	n := (360 + (n % 360)) % 360.
	a := (3600000 + a) % 360.
	b := (3600000 + b) % 360.
	^ a < b
		ifTrue: [ n between: a and: b ]
		ifFalse: [ a <= n | (n <= b) ]
]
