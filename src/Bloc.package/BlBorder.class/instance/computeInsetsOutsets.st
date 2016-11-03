private
computeInsetsOutsets
	| innerTop innerRight innerBottom innerLeft outerTop outerRight outerBottom outerLeft |
	innerTop := innerRight := innerBottom := innerLeft := outerTop := outerRight := outerBottom := outerLeft := 0.
	stroke ifNotNil:[
			innerTop := innerTop max: stroke innerEdge top.
			innerRight := innerRight max: stroke innerEdge right.
			innerBottom := innerBottom max: stroke innerEdge bottom.
			innerLeft := innerLeft max: stroke innerEdge left.
			outerTop := innerTop max: stroke outerEdge top.
			outerRight := innerRight max: stroke outerEdge right.
			outerBottom := innerBottom max: stroke outerEdge bottom.
			outerLeft := innerLeft max: stroke outerEdge left ].
	image ifNotNil:[ 
			innerTop := innerTop max: image innerEdge top.
			innerRight := innerRight max: image innerEdge right.
			innerBottom := innerBottom max: image innerEdge bottom.
			innerLeft := innerLeft max: image innerEdge left.
			outerTop := innerTop max: image outerEdge top.
			outerRight := innerRight max: image outerEdge right.
			outerBottom := innerBottom max: image outerEdge bottom.
			outerLeft := innerLeft max: image outerEdge left ].
	outsets := BlInsets
		top: outerTop
		right: outerRight
		bottom: outerBottom
		left: outerLeft.
	insets := BlInsets
		top: innerTop
		right: innerRight
		bottom: innerBottom
		left: innerLeft