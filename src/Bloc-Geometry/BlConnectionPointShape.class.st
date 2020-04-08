Class {
	#name : #BlConnectionPointShape,
	#superclass : #BlPointShape,
	#category : #'Bloc-Geometry-Shaper'
}

{ #category : #'api - transformation' }
BlConnectionPointShape >> divide [
	| newFromPoint newToPoint aLine aParent |
	
	aParent := self
		allParentsDetect: [ :eachParent | eachParent isCurve not ]
		ifFound: [ :aParentShape | aParentShape ]
		ifNone: [ nil ].
	
	newFromPoint := BlConnectionPointShape new point: self point.
	newToPoint := BlConnectionPointShape new point: self point.
	
	self incomingCurves do: [ :eachCurve | eachCurve replaceShape: self with: newFromPoint ].
	self outgoingCurves do: [ :eachCurve | eachCurve replaceShape: self with: newToPoint ].
	
	newFromPoint attributes removeAll.
	newFromPoint incomingCurves: self incomingCurves.
	self incomingCurves: #().
	

	newToPoint attributes removeAll.
	newToPoint outgoingCurves: self outgoingCurves.
	self outgoingCurves: #().
	
	aLine := BlLineShape new
		fromPoint: newFromPoint;
		toPoint:  newToPoint.
		
	aLine attributes addAll: self attributes.
		
	aParent ifNotNil: [ aParent addShape: aLine ].

	^ aLine
]

{ #category : #'api - connections' }
BlConnectionPointShape >> incomingCurves [
	^ self attributeAt: CurveToPointAttribute ifAbsent: [ #() ]
]

{ #category : #'api - connections' }
BlConnectionPointShape >> incomingCurves: aCollectionOfCurves [
	aCollectionOfCurves
		ifEmpty: [ self removeAttributeAt: CurveToPointAttribute ]
		ifNotEmpty: [ self attributeAt: CurveToPointAttribute put: aCollectionOfCurves asOrderedCollection copy ]
]

{ #category : #initialization }
BlConnectionPointShape >> initialize [
	super initialize
]

{ #category : #'api - connections' }
BlConnectionPointShape >> outgoingCurves [
	^ self attributeAt: CurveFromPointAttribute ifAbsent: [ #() ]
]

{ #category : #'api - connections' }
BlConnectionPointShape >> outgoingCurves: aCollectionOfCurves [
	aCollectionOfCurves
		ifEmpty: [ self removeAttributeAt: CurveFromPointAttribute ]
		ifNotEmpty: [ self attributeAt: CurveFromPointAttribute put: aCollectionOfCurves asOrderedCollection copy ]
]
