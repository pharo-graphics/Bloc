"
!Bloc layout
I am the superclass for layouts in Bloc and I define the API that a concrete layout needs to implement.

I am attached to a bloc element and define the visual structure of that bloc element. Typically this includes the position of child elements within the parent, or the size of the parent element. 

!!Layout constraints
I support a set of attributes (refered to as constraints in Bloc) which define the visual properties of the layout. A small set of constraints, like padding, margin or minimal and maximum dimensions, are common among all the layouts. Each layout has a dedicated constraint objects, instance of ${class:BlLayoutCommonConstraints}$, that contain these common constraints. Each type of layout can further define its own specific constraints by creating a subclass of ${class:BlLayoutConstraints}$. 

TODO: constraints API

!!Layout phase in a frame
Layouting of elements is a phase executed by a space during every frame. 

Every frame, the space goes through several phases (${method:BlSpaceFrame>>#initializePhases}$). Phases are modeled as subclasses of ${class:BlSpaceFramePhase}$ and are executed once per frame. One of them, ${class:BlSpaceFrameLayoutPhase}$, consists in layouting the elements contained in the space. This is done after events and tasks have been executed, but before the drawing phase.

Layouting should be executed during a frame when various properties like, width, height or position change in any element contained by the space. However, an important aspect in Bloc, is that when one of these properties changes, layouting is not performed immediately. Instead, a layout request is issued by the element whose property changed using the message ${method:BlElement>>#requestLayout:}$. This has the advantage that if no element request layout, this phase can be skipped. Also it does not matter if layout is requested once or a 1000 times; only one layout phase is performed, improving performance. 

Hence, in Bloc layout is not executed immediately after a property like the width of an element changes. Instead layout is requested and performed, if needed, during every frame. When needing to test layouts, however, it is necessary to apply a layout immediately, instead of waiting for a frame to end. That can be done using the message ${method:BlElement>>#forceLayout}$; this should not be used outside of tests, as it bypasses the normal layouting system from Bloc.

In a space where all elements have no event handlers for layout events, elements are going to be layouted exactly once during the layouting phase. However, often elements need to reach and perform actions, when for example their position or extent changes. They can react by requesting another layout. A typical example is dealing with edges. An edge can be layouted only after the position of the elements that it connects to is known. Hence, often the layout needs to be applied twice, or more, during the layouting phase. The space only allows layout requests during the layouting phase a limited number of times (${method:BlSpace>>#computeLayout}$) to avoid blocking rendering due to infinite recursions caused by layout requests, or avoid spending too much time on layouts in a frame. More technical details can be found in the method ${method:BlSpace>>#doLayout}$, the main entry point for executing the layout phase in a space.

!!Performing a layout
The space starts the layouting process on the root element of that space. Performing the layout on an element consists of executing three main steps:
	- measuring bounds: determine the bounds of the element according to its layout;
	- applying the layout: determine the position of children within the element;
	- commiting changes: raise layout events like position or extent changed.

TODO: why three separate steps?

!!!Measuring bounds
This is the first step when performing a layout of an element and consists in determining the measured bounds of that element. 

Each element can decide how it wants to be measured (${method:BlElement>>#onMeasure:}$). By default ${class:BlElement}$ delegates the measuring to its layout. Layouts should override ${method:BlLayout>>#measure:with:}$ to implement the actual measuring. Normally layouts follow a top to bottom approach: they measure the current element and then ask their children to do the measuring.

Each element has real bounds (${BlElement>>#bounds}$) and measured bounds (${BlElement>>#measuredBounds}$). The real bounds contain the actual position and extent of an element that users of that element should rely on. The measured bounds are used during layouting to hold the new extent of an element. The measuring phase changes only the extent in the measured bounds. After the entire layout phase is completed the real bounds and measured bounds will have the same value. The measured bounds act like a temporary cache for the new bounds of an element. They were introduced to avoid changing the real extent of element while layouting of children is still being performed. 

(TODO: explain why position is sometime changed in the measured bounds)

!!!Applying the layout

!!!Commiting changes

TODO
	- Space starts the measurement process from the root element; after measurement it tells children to measure themselves, etc
	- measurement; top to bottom though all the composition of elements.
		- this step find the size of an element and sets measuredExtent (or position sometimes)
	- space starts the layout step
		- as we know the size of each child we compute the actual position for each child
		- changes the real extent to measured extent and the real position to the computed layout position
	- Elements announce events for position and extent changed
	
	Without event handlers the layout process is going to happen only once.
	For example when nodes change the position edges should be updated.
	
!!Layout events

TODO

!!Layout API
I define an api of a layout. Concrete implementations should focus on measure:with: and layout:in:






	

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
	#category : #'Bloc-Layouts-Basic'
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

{ #category : #geometry }
BlLayout >> findClosestChildOf: anElement to: aPoint [
	"Find and return the closest direct child of a given element to a provided point in the coordinate system of anElement"
	<return: #BlElement>
	
	^ anElement children first
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

	anElement measuredExtent: (anExtentSpec sizeFor: 0@0).
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
BlLayout >> measureChildren: aCollectionOfChildren [
	aCollectionOfChildren do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: BlExtentMeasurementSpec unspecified ]
]

{ #category : #'private - measurement' }
BlLayout >> measureIgnored: anElement with: anExtentSpec [
	"Measure ignore children of a given parent allowing them to take as much space as they want"

	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
			| aWidthSpec aHeightSpec |
			
			aWidthSpec := anExtentSpec widthSpec.
			aHeightSpec := anExtentSpec heightSpec.

			aChild constraints horizontal resizer isMatchParent
				ifTrue: [ aWidthSpec := BlMeasurementSpec exact: (anElement measuredBounds width * aChild constraints ignored horizontal weight) ].
			
			aChild constraints vertical resizer isMatchParent
				ifTrue: [ aHeightSpec := BlMeasurementSpec exact: (anElement measuredBounds height * aChild constraints ignored vertical weight) ].
			
			self
				measureChild: aChild
				parentSpec: aWidthSpec @ aHeightSpec ]
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

{ #category : #'hooks - layout' }
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
