Class {
	#name : #BlLineShape,
	#superclass : #BlCurveShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #converting }
BlLineShape >> appendPathTo: aPathBuilder [
	(aPathBuilder currentPoint closeTo: self fromPoint point)
		ifFalse: [ aPathBuilder moveTo: self fromPoint point ].
	
	aPathBuilder lineTo: self toPoint point
]

{ #category : #converting }
BlLineShape >> asElement [
	^ BlLineElement new
		border: (BlBorder paint: Color gray width: 1)
]

{ #category : #converting }
BlLineShape >> asElementIn: aContainer [
	| aFromElement aToElement aLineElement |
	
	aFromElement := aContainer
		elementForShape: self fromPoint
		ifAbsentAdd: #asElement.

	aToElement := aContainer
		elementForShape: self toPoint
		ifAbsentAdd: #asElement.

	aLineElement := aContainer
		elementForShape: self
		ifAbsentAdd: #asElement.
		
	aLineElement
		fromAnchor: (BlElementCenterAnchor element: aFromElement);
		toAnchor: (BlElementCenterAnchor element: aToElement)
]

{ #category : #'api - transformations' }
BlLineShape >> injectLineAt: aFloat length: aLength [
	<return: #BlVectorShape>
	| aNewShape aLeftSplitPoint aRightSplitPoint aRightLine aLeftLine aCenterLine |
	
	"handle a potential zero divide"
	(self toPoint point closeTo: self fromPoint point)
		ifTrue: [
			aLeftSplitPoint := (BlConnectionPointShape new point: self toPoint point).
			aRightSplitPoint := (BlConnectionPointShape new point: self toPoint point) ]
		ifFalse: [
			| aLineVector aSplitPoint |
			aLineVector := self toPoint point - self fromPoint point.
			aSplitPoint := self fromPoint point + (aLineVector * aFloat).

			aLeftSplitPoint := (BlConnectionPointShape new point: aSplitPoint - (aLength * aLineVector normalized)).
			aRightSplitPoint := (BlConnectionPointShape new point: aSplitPoint + (aLength * aLineVector normalized)) ].

	aNewShape := BlThreeSegmentPolylineShape new.
	
	aLeftLine := BlLineShape new
		fromPoint: self fromPoint;
		toPoint: aLeftSplitPoint.
		
	aCenterLine := BlLineShape new
		fromPoint: aLeftSplitPoint;
		toPoint: aRightSplitPoint.
		
	aRightLine := BlLineShape new
		fromPoint: aRightSplitPoint;
		toPoint: self toPoint.

	(self fromPoint attributeAt: CurveFromPointAttribute) remove: self.
	(self toPoint attributeAt: CurveToPointAttribute) remove: self.

	aNewShape shapes: { aLeftLine . aCenterLine . aRightLine }.

	self parentDo: [ :aParentShape | aParentShape replaceShape: self with: aNewShape ].
	
	^ aNewShape
]

{ #category : #private }
BlLineShape >> moveBy: aDelta [
	self fromPoint moveBy: aDelta.
	self toPoint moveBy: aDelta
]

{ #category : #'api - transformations' }
BlLineShape >> splitAt: aFloat [
	<return: #BlVectorShape>
	| aNewShape aSplitPoint aLeftLine aRightLine |
	
	aSplitPoint := (BlConnectionPointShape new point: self fromPoint point + ((self toPoint point - self fromPoint point) * aFloat)).
	
	aNewShape := BlTwoSegmentPolylineShape new.
	aLeftLine := BlLineShape new
		fromPoint: self fromPoint;
		toPoint: aSplitPoint.
		
	aRightLine := BlLineShape new
		fromPoint: aSplitPoint;
		toPoint: self toPoint.

	(self fromPoint attributeAt: CurveFromPointAttribute) remove: self.
	(self toPoint attributeAt: CurveToPointAttribute) remove: self.
	
	aNewShape shapes: { aLeftLine . aRightLine }.
	
	self parentDo: [ :aParentShape | aParentShape replaceShape: self with: aNewShape ].
	
	^ aNewShape
]
