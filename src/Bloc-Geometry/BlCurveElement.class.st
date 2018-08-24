"
I define basic functionality of a curve element.

I should be common for all line- and curve- based elements that should support arrow heads.
"
Class {
	#name : #BlCurveElement,
	#superclass : #BlGeometryElement,
	#instVars : [
		'fromAnchor',
		'toAnchor',
		'fromHead',
		'toHead'
	],
	#category : 'Bloc-Geometry-Curves'
}

{ #category : #'anchor - geometry' }
BlCurveElement >> decoratedAnchorPositions [
	<return: #SequenceableCollection of: #Point>
	
	^ {
		self decoratedFromPosition.
		self decoratedToPosition
	}
]

{ #category : #'anchor - geometry' }
BlCurveElement >> decoratedFromPosition [
	^ self fromPosition - ((self fromHeadLength - 1) * (self normalizeDirection: self fromDirection)) asPoint
]

{ #category : #'anchor - geometry' }
BlCurveElement >> decoratedToPosition [
	^ self toPosition - ((self toHeadLength - 1) * (self normalizeDirection: self toDirection)) asPoint
]

{ #category : #initialization }
BlCurveElement >> defaultFromAnchor [
	^ BlAbsolutePositionAnchor position: 0@0
]

{ #category : #initialization }
BlCurveElement >> defaultGeometry [
	<return: #BlGeometry>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlCurveElement >> defaultOutskirts [
	^ BlOutskirts centered
]

{ #category : #initialization }
BlCurveElement >> defaultToAnchor [
	^ BlAbsolutePositionAnchor position: 10@10
]

{ #category : #drawing }
BlCurveElement >> drawArrowHeadsOnSpartaCanvas: aCanvas [

	aCanvas
		compose: #composeSource
		during: [
			self hasFromHead
				ifTrue: [ self fromHead fullDrawOnSpartaCanvas: aCanvas ].
			self hasToHead
				ifTrue: [ self toHead fullDrawOnSpartaCanvas: aCanvas ] ]
]

{ #category : #drawing }
BlCurveElement >> drawChildrenOnSpartaCanvas: aCanvas [

	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas ]
		during: [ self children sortedByElevation
			do: [ :anElement |
				"we intentionally compare with direct reference;
				if fromHead does not exist (is nil) identity comparison will return false anyway"
				(anElement == fromHead or: [ anElement == toHead ])
					ifFalse: [ anElement fullDrawOnSpartaCanvas: aCanvas ] ] ]
]

{ #category : #drawing }
BlCurveElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
	| aFont |

	super drawDebugInfoOnSpartaCanvas: aCanvas.
	
	aFont := aCanvas font
		size: 9;
		build.
	
	self decoratedAnchorPositions withIndexDo: [ :aPoint :anIndex |
		| anAnchorPosition |
		anAnchorPosition := self parentPointToLocal: aPoint.
		aCanvas stroke
			path: (aCanvas shape circleAt: anAnchorPosition radius: 10);
			width: 1;
			paint: Color gray;
			draw.
		
		aCanvas text
			string: anIndex asString;
			font: aFont;
			baseline: anAnchorPosition;
			draw.
		 ]
]

{ #category : #drawing }
BlCurveElement >> drawOnSpartaCanvas: aCanvas [

	aCanvas layer
		when: [ self hasHeads ]
		during: [
			| aBorder |

			aBorder := self border.
			aCanvas stroke
				alpha: self border opacity;
				paint: aBorder paint;
				path: (self geometry pathOnSpartaCanvas: aCanvas);
				width: aBorder width;
				in: [ :aPainter | aBorder style applyOn: aPainter ];
				draw.
			self drawArrowHeadsOnSpartaCanvas: aCanvas ]
]

{ #category : #'anchor - accessing' }
BlCurveElement >> fromAnchor [
	<return: #BlGeometryAnchor>

	^ fromAnchor
]

{ #category : #'anchor - accessing' }
BlCurveElement >> fromAnchor: aBlGeometryAnchor [

	self unregisterAnchor: fromAnchor.
	fromAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor
]

{ #category : #'anchor - geometry' }
BlCurveElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"
	<return: #BlVector>
	
	^ self subclassResponsibility
]

{ #category : #'heads - accessing' }
BlCurveElement >> fromHead [
	<return: #BlElement>

	self
		assert: [ self hasFromHead ]
		description: [ 'Can only access arrowhead on the `from` side of the curve if it exists' ].
		
	^ fromHead
]

{ #category : #'heads - accessing' }
BlCurveElement >> fromHead: aBlElement [
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Arrowhead must not be nil' ].
		
	self hasFromHead
		ifTrue: [ self removeChild: self fromHead ].
		
	fromHead := aBlElement.
	fromHead constraintsDo: [ :c | c ignoreByLayout ].
	self addChild: fromHead
]

{ #category : #'heads - geometry' }
BlCurveElement >> fromHeadBreadth [
	"Return a measured breadth of arrowhead on 'from' side of the path"
	<return: #Number>

	^ self hasFromHead
		ifTrue: [ self fromHead measuredHeight ]
		ifFalse: [ 0.0 ]
]

{ #category : #'heads - geometry' }
BlCurveElement >> fromHeadLength [
	"Return a measured length of arrowhead on 'from' side of the path"
	<return: #Number>

	^ self hasFromHead
		ifTrue: [ self fromHead measuredWidth + self fromHead margin width ]
		ifFalse: [ 0.0 ]
]

{ #category : #'anchor - geometry' }
BlCurveElement >> fromPosition [
	"Return position of fromAnchor in parent coordinates.
	The actual path may not start from this position if there exist arrow heads"
	<return: #Point>

	^ self fromAnchor positionWithin: self
]

{ #category : #'heads - testing' }
BlCurveElement >> hasFromHead [
	<return: #Boolean>

	^ fromHead isNotNil
]

{ #category : #'heads - testing' }
BlCurveElement >> hasHeads [
	<return: #Boolean>
	
	^ self hasFromHead or: [ self hasToHead ]
]

{ #category : #'heads - testing' }
BlCurveElement >> hasToHead [
	<return: #Boolean>

	^ toHead isNotNil
]

{ #category : #initialization }
BlCurveElement >> initialize [
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.

	"by default there are no arrow heads.
	For memory and performance reasons we do not initialize 'null object' heads"
	fromHead := nil.
	toHead := nil.

	self clipChildren: false
]

{ #category : #layout }
BlCurveElement >> measureFromHead [

	self
		assert: [ self hasFromHead ]
		description: [ 'Can not measure an arrowhead if it does not exist' ].

	fromHead measuredBounds position: (self fromPosition - self layoutBounds origin) - (self fromHead margin right @ (self fromHeadBreadth / 2.0)).

	"now we need to rotate the head"
	fromHead transformDo: [ :aTransform |
		| anAngle |
		anAngle := (1@0) angleWith: (self normalizeDirection: self fromDirection) asPoint.
		
		aTransform
			origin: BlAffineTransformationLeftCenterOrigin new;
			translateBy: ((self fromHeadLength - self fromHead margin right) @ 0) negated;
			rotateBy: anAngle radiansToDegrees;
			translateBy: (self fromHead margin right @ 0) ]
]

{ #category : #layout }
BlCurveElement >> measureHeads [
	self hasFromHead
		ifTrue: [ self measureFromHead ].
		
	self hasToHead
		ifTrue: [ self measureToHead ]
]

{ #category : #layout }
BlCurveElement >> measureToHead [

	self
		assert: [ self hasToHead ]
		description: [ 'Can not measure an arrowhead if it does not exist' ].

	toHead measuredBounds position: (self toPosition - self layoutBounds origin) - ((self toHeadLength - self toHead margin right) @ (self toHeadBreadth / 2.0)).

	"now we need to rotate the head"
	toHead transformDo: [ :aTransform |
		| anAngle |

		anAngle := (1@0) angleWith: (self normalizeDirection: self toDirection) asPoint.
		aTransform
			origin: BlAffineTransformationRightCenterOrigin new;
			"we should take static margin into account in order to rotate arounded right center with offset"
			translateBy: (self toHead margin left @ 0) negated;
			rotateBy: anAngle radiansToDegrees;
			translateBy: (self toHead margin left @ 0) ]
]

{ #category : #private }
BlCurveElement >> normalizeDirection: aVector [
	<return: #BlVector>

	^ aVector length isZero
		ifTrue: [ BlVector x: 1 y: 0 ]
		ifFalse: [ aVector normalized ]
]

{ #category : #layout }
BlCurveElement >> onMeasure: anExtentMeasurementSpec. [
	self layout measureIgnored: self with: anExtentMeasurementSpec.
	super onMeasure: anExtentMeasurementSpec.
	self measureHeads
]

{ #category : #'heads - accessing' }
BlCurveElement >> removeFromHead [		
	self hasFromHead
		ifFalse: [ ^ self ].
		
	self removeChild: self fromHead.
	fromHead := nil
]

{ #category : #'heads - accessing' }
BlCurveElement >> removeToHead [		
	self hasToHead
		ifFalse: [ ^ self ].
		
	self removeChild: self toHead.
	toHead := nil
]

{ #category : #'anchor - accessing' }
BlCurveElement >> toAnchor [
	<return: #BlGeometryAnchor>

	^ toAnchor
]

{ #category : #'anchor - accessing' }
BlCurveElement >> toAnchor: aBlGeometryAnchor [

	self unregisterAnchor: toAnchor.
	toAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor
]

{ #category : #'anchor - geometry' }
BlCurveElement >> toDirection [
	"Return a vector representing a direction in which end of the curve is pointing"
	<return: #BlVector>
	
	^ self subclassResponsibility
]

{ #category : #'heads - accessing' }
BlCurveElement >> toHead [
	<return: #BlElement>

	self
		assert: [ self hasToHead ]
		description: [ 'Can only access arrowhead on the `to` side of the curve if it exists' ].
		
	^ toHead
]

{ #category : #'heads - accessing' }
BlCurveElement >> toHead: aBlElement [
	self
		assert: [ aBlElement isNotNil ]
		description: [ 'Arrowhead must not be nil' ].
		
	self hasToHead
		ifTrue: [ self removeChild: self toHead ].
		
	toHead := aBlElement.
	toHead constraintsDo: [ :c | c ignoreByLayout ].
	self addChild: toHead
]

{ #category : #'heads - geometry' }
BlCurveElement >> toHeadBreadth [
	"Return a measured breadth of arrowhead on 'to' side of the path"
	<return: #Number>

	^ self hasToHead
		ifTrue: [ self toHead measuredHeight ]
		ifFalse: [ 0.0 ]
]

{ #category : #'heads - geometry' }
BlCurveElement >> toHeadLength [
	"Return a measured length of arrowhead on 'to' side of the path"
	<return: #Number>

	^ self hasToHead
		ifTrue: [ self toHead measuredWidth + self toHead margin width ]
		ifFalse: [ 0.0 ]
]

{ #category : #'anchor - geometry' }
BlCurveElement >> toPosition [
	"Return position of toAnchor in parent coordinates.
	The actual path may not end at this position if there exist arrow heads"
	<return: #Point>

	^ self toAnchor positionWithin: self
]
