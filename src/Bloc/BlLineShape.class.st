Class {
	#name : #BlLineShape,
	#superclass : #BlCompositeShape,
	#classVars : [
		'LinePointAttribute'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'class initialization' }
BlLineShape class >> initialize [
	LinePointAttribute := #linePoint
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

{ #category : #accessing }
BlLineShape >> fromPoint [
	^ fromPoint
]

{ #category : #accessing }
BlLineShape >> fromPoint: aPointShape [
	aPointShape attributeAt: LinePointAttribute put: #from.
	
]

{ #category : #accessing }
BlLineShape >> splitAt: aFloat [
	<return: #BlVectorShape>
	| aNewShape aSplitPoint aLeftLine aRightLine |
	
	aSplitPoint := (BlConnectionPointShape new point: self fromPoint point + ((self toPoint point - self fromPoint point) * aFloat)).
	
	aNewShape := BlPolylineShape new.
	aLeftLine := BlLineShape new
		fromPoint: self fromPoint;
		toPoint: aSplitPoint.
		
	aRightLine := BlLineShape new
		fromPoint: aSplitPoint;
		toPoint: self toPoint.
		
	aNewShape shapes: { aLeftLine . aRightLine }.
	
	self parentDo: [ :aParentShape | aParentShape replaceShape: self with: aNewShape ].
	
	^ aNewShape
]

{ #category : #accessing }
BlLineShape >> toPoint [
	^ toPoint
]

{ #category : #accessing }
BlLineShape >> toPoint: anObject [
	toPoint := anObject
]
