Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas drawClosedPathWith: [ :cairoContext | 

		self innerRadius = 0.0
			ifTrue: [ 
				cairoContext
					circleSectorCenter: self center
					from: startAngleInRadians
					to: endAngleInRadians
					radius: self absoluteOuterRadius ]
			ifFalse: [ 
				cairoContext
					annulusSectorCenter: self center
					from: startAngleInRadians
					to: endAngleInRadians
					innerRadius: self absoluteInnerRadius
					outerRadius: self absoluteOuterRadius
				] ]
]
