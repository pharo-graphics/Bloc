"
I represent an abstract Bloc layout.

I define an api of a layout. Concrete implementations should focus on measure:with: and layout:in:

I am used by bloc elements.
"
Class {
	#name : #BlLayout,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'requestingLayout',
		'previousMeasurementSpec',
		'direction',
		'waitingLayout'
	],
	#category : 'Bloc-Layouts-Basic'
}

{ #category : #constraints }
BlLayout class >> constraints [
	^ self subclassResponsibility
]

{ #category : #'private - alignment' }
BlLayout >> align: anElement bounds: elementBounds in: theParentBounds with: aBlElementAlignment [
	"I don't additionally take element margin or parent padding"
	| aTranslation alignment |
	
	"a composite alignment"
	alignment := aBlElementAlignment directed: self direction.
	aTranslation := alignment translationOf: elementBounds in: theParentBounds.

	aTranslation x isZero
		ifTrue: [ aTranslation := theParentBounds left @ aTranslation y ].
	aTranslation y isZero
		ifTrue: [ aTranslation := aTranslation x @ theParentBounds top ].

	^ elementBounds translateBy: aTranslation
]

{ #category : #'api - alignment' }
BlLayout >> align: aChildElement horizontal: aBlAlignment [
	"I should be used to dispatch children alignment configuration through layout to provide higher level uniform alignment api.	
	Layouts that support children alignment should override me as follows:
	
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]

	"
]

{ #category : #'api - alignment' }
BlLayout >> align: aChildElement vertical: aBlAlignment [
	"I should be used to dispatch children alignment configuration through layout to provide higher level uniform alignment api.	
	Layouts that support children alignment should override me as follows:
	
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]

	"
]

{ #category : #initialization }
BlLayout >> defaultDirection [
	<return: #BlLayoutDirection>

	^ BlLayoutDirection leftToRight
]

{ #category : #direction }
BlLayout >> direction [
	^ direction
]

{ #category : #direction }
BlLayout >> direction: aBlLayoutDirection [
	direction := aBlLayoutDirection
]

{ #category : #initialization }
BlLayout >> initialize [
	super initialize.
	
	requestingLayout := true.
	waitingLayout := true.
	direction := self defaultDirection
]

{ #category : #enumeration }
BlLayout >> layeredChildren: anElement [
	"Return a collecton of the anElement's children that should be layered out by the layout"
	
	^ Array streamContents: [ :aStream |
		self layeredChildren: anElement do: [ :aChild | aStream nextPut: aChild ] ]
]

{ #category : #enumeration }
BlLayout >> layeredChildren: anElement do: aBlock [
	"Evaluate a given block with all children of anElement
	that should be layered out within anElement.
	By default only children that are not ignored by layout are layered"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout not ]
		thenDo: aBlock
]

{ #category : #layout }
BlLayout >> layout: anElement in: aRectangle [
]

{ #category : #layout }
BlLayout >> layoutIgnored: anElement [
	"Layout children ignored by layout so that their measured bounds
	become actual bounds in parent"
	| parentBounds |

	"when layering ignored childed we don't take parent padding into account"
	parentBounds := (0@0 extent: anElement extent).
	"reuse the same instance for children bounds"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
			| childBounds |
			"ask child for its measured bounds"
			childBounds := aChild measuredBounds bounds.
			"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
			childBounds := self
				align: aChild
				bounds: (aChild margin expand: childBounds)
				in: parentBounds
				with: aChild constraints ignored alignment.
			"and finally set new bounds"
			aChild applyLayoutIn: (aChild margin inset: childBounds) ]
]

{ #category : #direction }
BlLayout >> leftToRight [
	direction := BlLayoutDirection leftToRight
]

{ #category : #measure }
BlLayout >> measure: anElement with: anExtentSpec [
	"Default simple and naive implementation that does not support #fitContent resizing
	strategy of the anElement that uses a layout with this version of measurement"

	anElement measuredExtent: (anExtentSpec sizeFor: anElement extent).
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ]
]

{ #category : #'private - measurement' }
BlLayout >> measureChild: aChildElement parentSpec: anExtentSpec [
	"Measure a given child element allowing it to take as much space within parent
	as it want *does not* taking child's margin and parent's padding into account.
	Note: You are only allowed to use me in a context of BlLayout and not from outside"

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthUsed: 0
		heightUsed: 0
]

{ #category : #protected }
BlLayout >> measureChild: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	"Measure anElement based on provided parent's extent measurement specification and used width and height.
	used width and height can contain margin and/or padding.
	@see BlElement>>#measurementSpecFor:usedSize:resizing: for more info"

	anElement measure: (BlExtentMeasurementSpec new
		widthSpec: (self
			measurementSpecFor: parentSpec widthSpec
			usedSize: widthUsed
			resizer: anElement constraints horizontal resizer);
		heightSpec: (self
			measurementSpecFor: parentSpec heightSpec
			usedSize: heightUsed
			resizer: anElement constraints vertical resizer))
]

{ #category : #protected }
BlLayout >> measureChildWithMargins: anElement parentSpec: parentSpec [
	"Measure anElement based on provided parent's extent measurement specification
	taking element's margin and parent's padding into account"
	
	self
		measureChildWithMargins: anElement
		parentSpec: parentSpec
		widthUsed: 0
		heightUsed: 0
]

{ #category : #protected }
BlLayout >> measureChildWithMargins: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	"Measure anElement based on provided parent's extent measurement specification and used width and height
	taking element's margin and parent's padding into account"
	
	self
		measureChild: anElement
		parentSpec: parentSpec
		widthUsed: anElement parent insets width + anElement outsets width + widthUsed
		heightUsed: anElement parent insets height + anElement outsets height + heightUsed
]

{ #category : #'private - measurement' }
BlLayout >> measureIgnored: anElement with: anExtentSpec [
	"Measure ignore children of a given parent allowing them to take as much space as they want"

	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
			self
				measureChild: aChild
				parentSpec: anExtentSpec ]
]

{ #category : #enumeration }
BlLayout >> measuredChildren: anElement [
	"Return a collecton of the anElement's children that should be measures by the layout"
	
	^ Array streamContents: [ :aStream |
		self measuredChildren: anElement do: [ :aChild | aStream nextPut: aChild ] ]
]

{ #category : #enumeration }
BlLayout >> measuredChildren: anElement do: aBlock [
	"Evaluate a given block with all children of anElement
	that should be taken into account during measurement process.
	By default only children that are not ignored by layout are measured"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout not ]
		thenDo: aBlock
]

{ #category : #protected }
BlLayout >> measurementSpecFor: parentSpec usedSize: usedSize resizer: childResizer [
	"I determinate what measurement specification my child should have
	based on parent's measurement spec and child's resizer property.
	
	parentSpec may have the following modes:
	 - At Most: parent's size can be at most as provided value 
	 - Exactly: parent's size equals provided value
	 - Unspecified: parent still has no idea how big it should be
	
	usedSize is a number describing how much child's size differs from parent one
		defined in parentSpec. usedSize can consist out of child's margin and/or
		parent's padding. Custom layouts may introduce more parameters that influence
		on final size of child.
	
	childResizer may be:
	 - Parent Match: meaning that child wants to be as big as parent is. It may also proportionally
	   depend on parent
	 - Wrap Content: child tries to be big enough to fit contained subnodes
	 - Exactly: child knows exactly how big it wants to be
	"
	<return: #BlMeasurementSpec>

	| size |
   size := 0 max: ((parentSpec size ifNil: [ 0 ]) - usedSize).
	^ parentSpec mode measurement: childResizer with: size
]

{ #category : #'as yet unclassified' }
BlLayout >> onLayoutDone: anElement [
	"Is sent after layout is completely computed.
	All layout changes done within this hook will be performed during the next frame.
	Note: I am sent before the drawing process"
]

{ #category : #private }
BlLayout >> previousMeasurementSpec [
	^ previousMeasurementSpec
]

{ #category : #private }
BlLayout >> previousMeasurementSpec: anObject [
	previousMeasurementSpec := anObject
]

{ #category : #protected }
BlLayout >> requestingLayout [
	"Return true if element requested layout on next space pulse, false otherwise"
	<return: #Boolean>

	^ requestingLayout
]

{ #category : #protected }
BlLayout >> requestingLayout: aBoolean [
		
	aBoolean
		ifTrue: [ waitingLayout := true ]
		ifFalse: [ self waitingLayout
			ifTrue: [ ^ self ] ].

	requestingLayout := aBoolean
]

{ #category : #direction }
BlLayout >> rightToLeft [
	direction := BlLayoutDirection rightToLeft
]

{ #category : #protected }
BlLayout >> waitingLayout [
	"Return true if my owner element is still waiting for the start of layout pass, false otherwise"
	<return: #Boolean>

	^ waitingLayout
]

{ #category : #protected }
BlLayout >> waitingLayout: aBoolean [
	"Change my layout waiting state. If aBoolean is false it would mean that measurement and
	layout pass began, true means that I still have to wait"

	waitingLayout := aBoolean
]
