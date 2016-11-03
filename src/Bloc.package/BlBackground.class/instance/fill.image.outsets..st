private
fill: aPaint image: anImg outsets: anOutsets
	fill := aPaint ifNil: [ Color transparent asBlPaint ].
	image := anImg.
	outsets := anOutsets ifNil: [ BlInsets empty ]