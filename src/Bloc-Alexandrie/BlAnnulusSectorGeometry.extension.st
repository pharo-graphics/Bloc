Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext | 
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
