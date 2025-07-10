"
# Bloc layout
I am the superclass for layouts in Bloc and I define the API that a concrete layout needs to implement.

I am attached to a bloc element and define the visual structure of that bloc element. Typically this includes the position of child elements within the parent, or the size of the parent element. 

## Layout constraints
I support a set of attributes (refered to as constraints in Bloc) which define the visual properties of the layout. A small set of constraints, like padding, margin or minimal and maximum dimensions, are common among all the layouts. Each layout has a dedicated constraint object, an instance of `BlLayoutCommonConstraints`, that contains these universal constraints. Each type of layout can further define its own specific constraints by creating a subclass of `BlLayoutConstraints`. 

TODO: constraints API

## Layout phase in a frame
Element layout is a phase executed by a space during each frame. 

Every frame, the space goes through several phases (`BlSpaceFrame>>#initializePhases`), which are modeled as subclasses of `BlSpaceFramePhase` and are executed once per frame. One of them, `BlSpaceFrameLayoutPhase`,  lays out the elements contained in the space. This is done after events and tasks have been executed, but before the drawing phase.

Layout should happen during a frame whenever various properties like width, height or position change for any element contained by the space. However, an important aspect in Bloc, is that when one of these properties changes, layout is not performed immediately. Instead, a layout request is issued by the element whose property changed via the `BlElement>>#requestLayout:` message. This has two advantages that improve performance:
1. If no element requests layout, this phase can be skipped.
2. It does not matter if layout is requested once or 1000 times during a frame; only one layout phase is performed. 

Hence, layout does not happen immediately after a property like the width of an element changes. Instead, once requested, you only know that layout will happen at some point during every frame. When needing to test layouts, however, it is necessary to apply a layout immediately, instead of waiting for a frame to end. This can be done using the `BlElement>>#forceLayout` message, but it should not be used outside of tests, as it bypasses the normal layout system.

In a space where all elements have no event handlers for layout events, elements are going to be laid out exactly once during the layout phase. However, often elements need to react and perform actions, for example when their position or extent changes. In these cases, they may request another layout. A typical example is dealing with edges. An edge can be laid out only after the position of the elements to which it connects is known. Hence, often the layout needs to be applied twice, or more, during the layout phase. However, spaces only allow a limited number of layout requests during each layout phase to avoid blocking rendering due to infinite recursions caused by layout requests, or avoid spending too much time on layouts in a frame. More technical details can be found in the method `BlSpace>>#doLayout`, the main entry point for executing the layout phase in a space.

## Performing a layout
The space starts the layout process on the root element of that space. Performing the layout on an element consists of executing three main steps:
1. Measure bounds: determine the bounds of the element according to its layout;
2. Apply the layout: determine the position of children within the element;
3. commit changes: raise layout events like position or extent changed.

TODO: why three separate steps?

### Measuring bounds
This is the first step when performing a layout of an element and consists in determining the measured bounds of that element. 

Each element can decide how it wants to be measured (`BlElement>>#onMeasure:`). By default, `BlElement` delegates measuring to its layout. Layouts should override `BlLayout>>#measure:with:` to implement the actual measuring. Normally, layouts follow a top-to-bottom approach: they measure the current element and then ask their children measure themselves.

Each element has real bounds (`BlElement>>#bounds`) and measured bounds (`BlElement>>#measuredBounds`). The real bounds contain the actual position and extent of an element that users of that element should rely on. The measured bounds are used during layout to hold the new extent of an element. The measuring phase changes only the extent in the measured bounds. After the entire layout phase is completed the real bounds and measured bounds will have the same value. The measured bounds act like a temporary cache for the new bounds of an element. They were introduced to avoid changing the real extent of element while layout of children is still being performed. 

(TODO: explain why position is sometime changed in the measured bounds)

### Applying the layout

### Commiting changes

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
	
## Layout events

TODO

## Layout API
I define an api of a layout. Concrete implementations should focus on `measure:with:` and `layout:in:`

## Available Layouts
There are many built-in layout strategies available:
```
BlLayout allSubclasses
```







	


"
Class {
	#name : #BlLayout,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
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

	^ elementBounds translateBy: aTranslation
]

{ #category : #'api - alignment' }
BlLayout >> align: aChildElement horizontal: aBlAlignment [
	"I should be used to dispatch children alignment configuration through layout to provide higher level uniform alignment api.	
	Layouts that support children alignment should override me as follows:
	
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]

	"
]

{ #category : #'private - alignment' }
BlLayout >> align: elementBounds in: theParentBounds with: aBlElementAlignment [
	"I don't additionally take element margin or parent padding"
	| aTranslation alignment |

	"a composite alignment"
	alignment := aBlElementAlignment directed: self direction.
	aTranslation := alignment translationOf: elementBounds in: theParentBounds.

	^ elementBounds translateBy: aTranslation
]

{ #category : #'api - alignment' }
BlLayout >> align: aChildElement vertical: aBlAlignment [
	"I should be used to dispatch children alignment configuration through layout to provide higher level uniform alignment api.	
	Layouts that support children alignment should override me as follows:
	
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]

	"
]

{ #category : #'api - direction' }
BlLayout >> defaultDirection [
	<return: #BlLayoutDirection>

	^ BlLayoutDirection leftToRight
]

{ #category : #'api - direction' }
BlLayout >> direction [
	^ self defaultDirection
]

{ #category : #geometry }
BlLayout >> findClosestChildOf: anElement to: aPoint [
	"Find and return the closest direct child of a given element to a provided point in the coordinate system of anElement"
	<return: #BlElement>
	
	^ anElement children first
]

{ #category : #protected }
BlLayout >> isInfluencedByTransformation [
	"Return true if the layout may be influenced by the element's transformation"

	^ false
]

{ #category : #testing }
BlLayout >> isOrientable [

	" can be vertical/horizontal ? "
	^ false
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
BlLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
]

{ #category : #layout }
BlLayout >> layoutIgnored: anElement context: aBlElementBoundsUpdateContext [
	"Layout children ignored by layout so that their measured bounds
	become actual bounds in parent"

	| parentBounds |
	"when layering ignored childed we don't take parent padding into account"
	parentBounds := 0 @ 0 extent: anElement extent.
	"reuse the same instance for children bounds"

	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild |
				| childBounds allowedBounds |
				"ask child for its measured bounds"
				childBounds := aChild measuredBounds bounds copy.
				allowedBounds := aChild margin inset: parentBounds copy.

				childBounds := aChild constraints anchors
					               positionInParent: anElement
					               forChild: aChild.
				"frame layout supports alignment, so we need to translate child's bounds accordingly to alignment"
				childBounds := self
					               align: childBounds
					               in: allowedBounds
					               with: aChild constraints ignored alignment.

				"and finally set new bounds"
				aChild
					applyLayoutIn: childBounds
					context: aBlElementBoundsUpdateContext ]
]

{ #category : #protected }
BlLayout >> mayInfluencePosition [
	"Return true if the layout may influence the position of the element with this layout"

	^ false
]

{ #category : #measure }
BlLayout >> measure: anElement with: anExtentSpec [
	"Default simple and naive implementation that does not support #fitContent resizing
	strategy of the anElement that uses a layout with this version of measurement"

	anElement measuredExtent: (anExtentSpec extentForWidth: 0.0 height: 0.0).
	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ]
]

{ #category : #'private - measurement' }
BlLayout >> measureChild: aChildElement parentSpec: anExtentSpec [
	"Measure a given child element allowing it to take as much space within parent
	without taking into account child's margin and parent's padding."

	self
		measureChild: aChildElement
		parentSpec: anExtentSpec
		widthUsed: 0.0
		heightUsed: 0.0
]

{ #category : #protected }
BlLayout >> measureChild: anElement parentSpec: parentSpec widthUsed: widthUsed heightUsed: heightUsed [
	"Measure anElement based on provided parent's extent measurement specification and used width and height.
	Used width and height can contain margin and/or padding."

	anElement measure:
		(BlExtentMeasurementSpec
			widthSpec: (self
				measurementSpecFor: parentSpec widthSpec
				usedSize: widthUsed
				resizer: anElement constraints horizontal resizer)
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
	taking into account element's margin and parent's padding."
	
	self
		measureChild: anElement
		parentSpec: parentSpec
		widthUsed: anElement parent padding width + anElement margin width + widthUsed
		heightUsed: anElement parent padding height + anElement margin height + heightUsed
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
				| aWidthSpec aHeightSpec boundsForChild prevBounds |
				aWidthSpec := anExtentSpec widthSpec.
				aHeightSpec := anExtentSpec heightSpec.
				prevBounds := aChild measuredBounds asRectangle.
				boundsForChild := aChild constraints anchors
					                  measureInParent: anElement
					                  forChild: aChild.

				aChild constraints horizontal resizer isMatchParent
					ifTrue: [
							aWidthSpec := BlMeasurementSpec exact:
								              anElement measuredBounds width
								              * aChild constraints ignored horizontal weight ]
					ifFalse: [
							boundsForChild width ~= prevBounds width ifTrue: [
									aWidthSpec := BlMeasurementSpec exact: boundsForChild width.
									aChild constraints horizontal exact: boundsForChild width ] ].

				aChild constraints vertical resizer isMatchParent
					ifTrue: [
							aHeightSpec := BlMeasurementSpec exact:
								               anElement measuredBounds height
								               * aChild constraints ignored vertical weight ]
					ifFalse: [
							boundsForChild height ~= prevBounds height ifTrue: [
									aHeightSpec := BlMeasurementSpec exact: boundsForChild height.
									aChild constraints vertical exact: boundsForChild height ] ].

				self measureChild: aChild parentSpec: aWidthSpec @ aHeightSpec ]
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
	"I determine what measurement specification (`BlMeasurementSpec`) my child
	should have based on parent's measurement spec and child's resizer property.
	
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

	| size |
   size := 0.0 max: (parentSpec size - usedSize).
	^ parentSpec mode measurement: childResizer with: size
]

{ #category : #'hooks - layout' }
BlLayout >> onCleanUp: anElement [
	"Is sent when the layout caches should be cleaned up.
	This happens for example when an element is removed from the scene"
]

{ #category : #'hooks - layout' }
BlLayout >> onLayoutDone: anElement [
	"Is sent after layout is completely computed.
	All layout changes done within this hook will be performed during the next frame.
	Note: I am sent before the drawing process"
]
