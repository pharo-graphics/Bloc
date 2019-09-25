Class {
	#name : #BlConnectionPointShape,
	#superclass : #BlPointShape,
	#instVars : [
		'connectedShapes'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'api - connections' }
BlConnectionPointShape >> addConnectedShape: aShape [
	connectedShapes add: aShape
]

{ #category : #'api - connections' }
BlConnectionPointShape >> connectedShapes [
	^ connectedShapes
]

{ #category : #'api - transformation' }
BlConnectionPointShape >> divide [
	| newFromPoint newToPoint aLine |
	
	newFromPoint := BlConnectionPointShape new point: self point.
	newToPoint := BlConnectionPointShape new point: self point.
	
	self connectedShapes do: [ :eachShape |
		eachShape replaceShape: self with: newFromPoint.
		eachShape replaceShape: self with: newToPoint ].
	
	self halt.
	
	aLine := BlLineShape new
		fromPoint: newFromPoint;
		toPoint:  newToPoint.
		
	self
		allParentsDetect: [ :eachParent | eachParent isCurve not ]
		ifFound: [ :aParentShape | aParentShape addShape: aLine ]
		ifNone: [ ].

	^ aLine
]

{ #category : #'api - connections' }
BlConnectionPointShape >> incomingLines [
	^ self attributeAt: CurveToPointAttribute ifAbsent: [ #() ]
]

{ #category : #initialization }
BlConnectionPointShape >> initialize [
	super initialize.
	
	connectedShapes := Set new
]

{ #category : #'api - connections' }
BlConnectionPointShape >> outgoingLines [
	^ self attributeAt: CurveFromPointAttribute ifAbsent: [ #() ]
]

{ #category : #'api - connections' }
BlConnectionPointShape >> removeConnectedShape: aShape [
	connectedShapes remove: aShape
]
