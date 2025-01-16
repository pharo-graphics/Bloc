Extension { #name : #BlRoundedPolygonGeometry }

{ #category : #'*Bloc-Alexandrie' }
BlRoundedPolygonGeometry >> aeApplyTo: aeCanvas element: aBlElement [

	aeCanvas pathFactory: [ :cairoContext |
		| p1 p2 p3 |
		1 to: vertices size do: [ :i |
			p1 := vertices at: i.
			p2 := vertices atWrap: i + 1.
			p3 := vertices atWrap: i + 2.
			self
				aeApplyTo: cairoContext
				roundedCornerP1: p1
				p2: p2
				p3: p3 ].

		cairoContext closePath ]
]

{ #category : #'*Bloc-Alexandrie' }
BlRoundedPolygonGeometry >> aeApplyTo: cairoContext roundedCornerP1: p1 p2: p2 p3: p3 [
	"Based on `RSAthensRenderer>>#applyRadius:on:from:to:`, which is based on
	https://riptutorial.com/html5-canvas/example/18766/render-a-rounded-polygon-"

	| v1 len1 a1 v2 len2 a2 sinA sin90 angle radDir isClockwise halfAngle cRadius lenOut p a b |
	(p1 = p2 or: [ p2 = p3 ]) ifTrue: [ ^ self ].

	v1 := p1 - p2.
	len1 := v1 r.
	v1 := v1 / len1.
	a1 := v1 angle.

	v2 := p3 - p2.
	len2 := v2 r.
	v2 := v2 / len2.
	a2 := v2 angle.

	sinA := (v1 x * v2 y) - (v1 y * v2 x).
	sin90 := (v1 x * v2 x) - (v1 y * v2 y negated).
	angle := sinA arcSin.
	radDir := 1.
	isClockwise := true.

	sin90 < 0.0
		ifTrue: [
			angle < 0.0
				ifTrue: [ angle := angle + Float pi ]
				ifFalse: [
					angle := angle - Float pi.
					radDir := -1.
					isClockwise := false ] ]
		ifFalse: [
			angle >= 0.0 ifTrue: [
				radDir := -1.
				isClockwise := false ] ].

	halfAngle := angle / 2.0.
	sinA :=  halfAngle sin.
	lenOut := (sinA closeTo: 0.0)
		ifTrue: [ Float infinity ]
		ifFalse: [ (halfAngle cos * radius / sinA) abs ].
	cRadius := radius.
	lenOut > ((len1 / 2.0) min: (len2 / 2.0)) ifTrue: [
		lenOut := (len1 / 2.0) min: (len2 / 2.0).
		cRadius := (lenOut * halfAngle tan) abs ].

	p := p2 + (v2 * lenOut) + (v2 y negated @ v2 x * cRadius * radDir).
	a := a1 + (Float halfPi * radDir).
	b := a2 - (Float halfPi * radDir).
	(a closeTo: b) ifTrue: [ a := b ].

	cairoContext
		arcCenter: p
		radius: cRadius
		startAngle: a
		endAngle: b
		cw: isClockwise
]
