Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext | 
		self innerRadius = 0.0
			ifTrue: [ 
				cairoContext
					circleSectorCenter: self center
					from: self startAngle degreesToRadians
					to: self endAngle degreesToRadians
					radius: self absoluteOuterRadius ]
			ifFalse: [ 
				cairoContext
					annulusSectorCenter: self center
					from: self startAngle degreesToRadians
					to: self endAngle degreesToRadians
					innerRadius: self absoluteInnerRadius
					outerRadius: self absoluteOuterRadius
				] ]
]

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeContainsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is contained by this geometry.

	Adapted from RSPieSlice>>#preciseIncludesPoint:"

	| p d n a b |
	
	"Check if distance is between right interval"
	p := aPoint - self center.
	d := p distanceTo: 0.0@0.0.
	(d between: self absoluteInnerRadius and: self absoluteOuterRadius)
		ifFalse: [ ^ false ].

	"Check the angle"
	n := p angle radiansToDegrees % 360.
	a := self startAngle % 360.
	b := self endAngle % 360.

	^ a < b
		ifTrue: [ n between: a and: b ]
		ifFalse: [ a <= n or: [ n <= b ] ]
]
