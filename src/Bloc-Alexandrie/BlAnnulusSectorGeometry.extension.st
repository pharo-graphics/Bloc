Extension { #name : #BlAnnulusSectorGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		self isFullTurn
			ifTrue: [ self aeBuildFullTurnOn: cairoContext ]
			ifFalse: [
				self innerRadius isZero
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
							outerRadius: self absoluteOuterRadius ] ] ]
]

{ #category : #'*Bloc-Alexandrie' }
BlAnnulusSectorGeometry >> aeBuildFullTurnOn: cairoContext [
	"Build a whole ring (or a whole disk when there is no inner radius) as closed circles.
	 The sector path would join the arcs with straight segments, which a border draws as a radial line."

	| center |
	center := self center.
	cairoContext
		moveToX: center x + self absoluteOuterRadius y: center y;
		arcCenterX: center x
			centerY: center y
			radius: self absoluteOuterRadius
			startAngle: 0
			endAngle: Float twoPi;
		closePath.
	self absoluteInnerRadius > 0 ifFalse: [ ^ self ].
	cairoContext
		moveToX: center x + self absoluteInnerRadius y: center y;
		arcNegativeCenterX: center x
			centerY: center y
			radius: self absoluteInnerRadius
			startAngle: Float twoPi
			endAngle: 0;
		closePath
]
