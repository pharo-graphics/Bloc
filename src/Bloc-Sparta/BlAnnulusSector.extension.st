Extension { #name : #BlAnnulusSector }

{ #category : #'*Bloc-Sparta' }
BlAnnulusSector >> buildPathOnSpartaCanvas: aCanvas [
	| aCenter anAbsoluteInnerRadius anAbsoluteOuterRadius aStartAngleInRadians anEndAngleInRadians aPathBuilder anInnerStartPoint anInnerEndPoint anOuterStartPoint anOuterEndPoint |
	
	aCenter := self center.
	anAbsoluteInnerRadius := self absoluteInnerRadius.
	anAbsoluteOuterRadius := self absoluteOuterRadius.
	aStartAngleInRadians := self startAngle degreesToRadians.
	anEndAngleInRadians := self endAngle degreesToRadians.
	
	anInnerStartPoint := self pointFromAngle: aStartAngleInRadians andRadius: anAbsoluteInnerRadius around: aCenter.
	anInnerEndPoint := self pointFromAngle: anEndAngleInRadians andRadius: anAbsoluteInnerRadius around: aCenter.
	anOuterStartPoint := self pointFromAngle: anEndAngleInRadians andRadius: anAbsoluteOuterRadius around: aCenter.
	anOuterEndPoint := self pointFromAngle: aStartAngleInRadians andRadius: anAbsoluteOuterRadius around: aCenter.
	
	aPathBuilder := aCanvas path absolute.

	aPathBuilder moveTo: anInnerStartPoint.
	
	"if annulus degrades to a circle we don't have to draw an inner circle"
	(self innerRadius closeTo: 0)
		ifFalse: [
			aPathBuilder
				arcAround: aCenter
				radius: anAbsoluteInnerRadius
				startAngle: aStartAngleInRadians
				endAngle: anEndAngleInRadians ].
	
	"not let's see how we transition from the inner circle to the outer"
	
	"if annulus degrates to a circle"
	(self innerRadius closeTo: 0)
		ifTrue: [
			"and the outer section is also a circle we just move"
			(anOuterStartPoint closeTo: anOuterEndPoint)
				ifTrue: [ aPathBuilder moveTo: anOuterStartPoint ]
				ifFalse: [ aPathBuilder lineTo: anOuterStartPoint ] ]
		ifFalse: [
			"in case a sector degrades to a full annulus we don't want to draw a line that connects inner and outer circles"
			(anInnerStartPoint closeTo: anInnerEndPoint)
				ifTrue: [ aPathBuilder moveTo: anOuterStartPoint ]
				ifFalse: [ aPathBuilder lineTo: anOuterStartPoint ] ].

	aPathBuilder
		arcAround: aCenter radius: anAbsoluteOuterRadius startAngle: anEndAngleInRadians endAngle: aStartAngleInRadians;
		close.
	
	^ aPathBuilder build
]
