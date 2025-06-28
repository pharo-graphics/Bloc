Extension { #name : #BlStadiumGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlStadiumGeometry >> aeApplyCircleTo: aeCanvas [

	aeCanvas pathFactory: [ :cairoContext |
		| aRadius |
		aRadius := extent x / 2.0.
		cairoContext circleCenterX: aRadius y: aRadius radius: aRadius ]
]

{ #category : #'*Bloc-Alexandrie' }
BlStadiumGeometry >> aeApplyHorizontalStadiumTo: aeCanvas [

	aeCanvas pathFactory: [ :cairoContext |
		| aRadius x2 |
		aRadius := extent y / 2.0.
		x2 := extent x - aRadius.

		cairoContext
			arcCenterX: aRadius
				centerY: aRadius
				radius: aRadius
				startAngle: Float halfPi
				endAngle: Float halfPi negated;
			lineToX: x2 y: 0.0;
			arcCenterX: x2
				centerY: aRadius
				radius: aRadius
				startAngle: Float halfPi negated
				endAngle: Float halfPi;
			closePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlStadiumGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	extent x > extent y ifTrue: [
		^ self aeApplyHorizontalStadiumTo: aeCanvas ].

	extent x < extent y ifTrue: [
		^ self aeApplyVerticalStadiumTo: aeCanvas ].

	self aeApplyCircleTo: aeCanvas
]

{ #category : #'*Bloc-Alexandrie' }
BlStadiumGeometry >> aeApplyVerticalStadiumTo: aeCanvas [

	aeCanvas pathFactory: [ :cairoContext |
		| aRadius y2 |
		aRadius := extent x / 2.0.
		y2 := extent y - aRadius.

		cairoContext
			arcCenterX: aRadius
				centerY: aRadius
				radius: aRadius
				startAngle: Float pi
				endAngle: 0.0;
			lineToX: extent x y: y2;
			arcCenterX: aRadius
				centerY: y2
				radius: aRadius
				startAngle: 0.0
				endAngle: Float pi;
			closePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlStadiumGeometry >> aeSetUpGradientShadowOn: aBlGradientShadowEffect extent: aPoint [

	aBlGradientShadowEffect
		setUpRoundedRectangleExtent: aPoint
		radii: (BlCornerRadii radius: aPoint min / 2)
]
