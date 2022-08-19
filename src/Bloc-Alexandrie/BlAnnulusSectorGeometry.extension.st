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
