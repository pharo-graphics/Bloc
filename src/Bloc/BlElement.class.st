"
# Welcome to Bloc
I am the root class of all visual elements in Bloc and can be composed out of other elements that we will refer to as `children`. 
## Visual properties
Being a root class and a core element, I let users configure a few essential visual properties such as background, border, opacity, size and a few more. Let's go through each of them.
### Background
`BlBackground`describes how an element should be filled, e.g. its background.
`BlBackgroundExamples` gives a detailed insight in the world of bloc backgrounds.
### Border
`BlBorder` is a visual property that defines how the outline of the element should be rendered. It also influences `stroked bounds` of the element.
`BlBorderExamples` provides more detailed information about a border.
### Opacity
Opacity defines how transparent an element is. It does not influence event propagation.
`BlOpacityExamples` shows in details how opacity affects the element.
## Composition
To be in-line with Bloc design, we prefer composition over inheritance. Thus it is better to have tiny bloc elements - each with a small and simple API and clear responsibilities - that can later be composed into a more sophisticated graphical scene. In this paragraph we will learn the basic composition aspects and corresponding API.

The composition relation between parent and children is 1:N meaning that an element can have at most one parent. Therefore by design it is only possible to add an element to just one other element. Trying to add an element that is already a child to some other element results in `BlAlreadyAddedAsChildError` 

Bloc elements provide a set of methods to add and remove children.
### Adding children
There are four ways to add some given element as a direct child to another element.

The most commonly used way to add a child is to use `BlElement>>#addChild:` which adds a given element as the last child in the collection of children.
```
| parent child |
parent := BlElement new size: 100@100; background: Color veryVeryLightGray.
child := BlElement new size: 50@50; background: Color red lighter.
parent addChild: child
```

Users may also choose to add an element as the first child, for that purpose Bloc provides `BlElement>>#addChildFirst:`.
## Geometry and bounds
Every element is responsible for drawing itself. At the same time, every element has a `BlElementGeometry` that defines the bounds and the clipping. There are many types of geometry available:
```
BlElementGeometry allSubclasses
```

See `BlGeometryVisualAndLayoutBoundsExamples` for concrete details.
## Layout
There are many built-in `BlLayout` strategies available, or you can create your own.
## Tutorial
You can learn Bloc following a memory game tutorial: [00-memory-game.pillar](fileLocator://gtResource/feenkcom/Bloc/doc/tutorial-memory-game/00-memory-game.pillar).

"
Class {
	#name : #BlElement,
	#superclass : #Object,
	#traits : 'TBlTransformable + TBlEventTarget + TBlDebug',
	#classTraits : 'TBlTransformable classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'spaceReference',
		'parent',
		'children',
		'bounds',
		'measuredBounds',
		'boundsCache',
		'eventDispatcher',
		'constraints',
		'layout',
		'transformation',
		'taskQueue',
		'errorHandler',
		'userData',
		'visuals',
		'flags'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlElement class >> epsilon [
	^ 0.01
]

{ #category : #'instance creation' }
BlElement class >> id: aStringOrSymbol [

	^ self new id: aStringOrSymbol
]

{ #category : #'layout anchors' }
BlElement >> actionAnchor: aBlock [

	^ BlActionAnchor new
		  action: aBlock;
		  baseAnchor: self nilAnchor;
		  yourself
]

{ #category : #'api - animations' }
BlElement >> addAnimation: aBlBaseAnimation [
 
	aBlBaseAnimation target: self.
	self enqueueTask: aBlBaseAnimation
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement [
	"Add anElement as my last direct child and request layout update."

	self addChild: anElement at: self childrenCount + 1
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement after: anotherElement [
	"Add anElement as my direct child right after anotherElement.

	Signal an ${class:BlChildDoesNotExistError}$ if anotherElement is not my direct child.

	Precondition: anElement must not be a direct child of any other element."

	| anotherElementIndex |
	anotherElementIndex := self childIndexOf: anotherElement.
	anotherElementIndex isZero
		ifTrue: [
			(BlChildDoesNotExistError new
				parent: self;
				child: anotherElement) signal ].

	self addChild: anElement at: (anotherElementIndex + 1)
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement as: aBlElementId [
	"Add a given element to my children and make it a named container, so that
	we could add children in that container"
	| aChildId |
	
	aChildId := aBlElementId asBlocElementId.
	
	self
		assert: [ (self children
			detect: [ :aChild | aChild id = aChildId ]
			ifFound: [ true ]
			ifNone: [ false ]) not ]
		description: [ 'Child with id #', aBlElementId asString, ' already exists' ].
	
	anElement id: aChildId.
	self addChild: anElement
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement at: anIndex [
	"Add anElement at an index moving other children to the right.

	Preconditions:
		- anElement must not be a direct child of any other element!
		- anIndex must be greater or equal to 1 and less or equal than amount of existing children + 1"

	anElement hasParent
		ifTrue: [ (BlAlreadyAddedAsChildError element: anElement) signal ].	
	
	self
		assert: [ anElement hasParent not ]
		description: [ 'Can not add child that is already added to another element!' ].
	self
		assert: [ anIndex between: 1 and: self childrenCount + 1 ]
		description: [ 'anIndex must be within children array bounds' ].

	"update parent"
	anElement parent: self.

	"actually add child"
	self children add: anElement at: anIndex.

	"dispatch events/hooks after element has been added"
	self dispatchChildAdded: anElement.
	
	"only requesting layout is not enough, because if size or position does not change
	there will be no invalidated bounds and nothing will be rendered"
	anElement invalidate.
	
	"We should request layout from newly added element to mark it as dirty too"
	anElement requestLayout.
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement at: anIndex as: aContainerName [
	"Add a given element to my children at an index moving other children to the right and make it a named container,
	so that we could add children in that container"
	
	self
		assert: [ (self children
			detect: [ :aChild |
				aChild id
					ifNotNil: [ :aName | aName = aContainerName ]
					ifNil: [ false ] ]
			ifFound: [ true ]
			ifNone: [ false ]) not ]
		description: [ 'Child named #', aContainerName asString, ' already exists' ].
	
	anElement id: aContainerName.
	self addChild: anElement at: anIndex
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement before: anotherElement [
	"Add anElement as my direct child right before anotherElement.

	Signal an ${class:BlChildDoesNotExistError}$ if anotherElement is not my direct child.

	Precondition: anElement must not have a parent."

	| anotherElementIndex |
	anotherElementIndex := self childIndexOf: anotherElement.
	anotherElementIndex isZero
		ifTrue: [
			(BlChildDoesNotExistError new
				parent: self;
				child: anotherElement) signal ].

	self addChild: anElement at: anotherElementIndex
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement in: aContainerName [
	"Add a given element to a named container that must already exist"

	self
		childWithId: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement. ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement in: aContainerName as: aChildContainerName [
	"Add a given element to a named container that must already exist
	and mark the added child as container too"

	self
		childWithId: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement as: aChildContainerName ]
		ifNone: [ self error: 'Container named #', aContainerName asString, ' does not exist' ]
]

{ #category : #'children add/remove' }
BlElement >> addChildFirst: anElement [
	"Add anElement as my first direct child and request layout update."

	self addChild: anElement at: 1
]

{ #category : #'children add/remove' }
BlElement >> addChildFirst: anElement as: aContainerId [
	"Add a given element as my first child and make it a named container, so that
	we could add children in that container"

	anElement id: aContainerId.
	self addChildFirst: anElement
]

{ #category : #'children add/remove' }
BlElement >> addChildren: aListOfElements [
	"Add elements from aListOfElements as my rearmost(last) direct children and
	request layout update.

	Precondition: 
		all elements from aListOfElements must not be added to any other element

	@see BlElement>>#addChild: for more documentation"

	self
		assert: [ aListOfElements allSatisfy: [ :anElement | anElement parent isNil ] ]
		description: [ 'All elements must not have parent' ].

	"fast exit if there are no elements to add"
	aListOfElements
		ifEmpty: [ ^ self ].
	"update parents"
	aListOfElements do: [ :anElement | anElement parent: self ].
	"actually add children"
	self children addAll: aListOfElements.
	"send hook after elements have been added"
	aListOfElements do: [ :anElement | self dispatchChildAdded: anElement ].
	"We should request layout from newly added elements to mark them as dirty too"
	aListOfElements do: [ :anElement | anElement requestLayout ]
]

{ #category : #'children add/remove' }
BlElement >> addChildren: aListOfElements in: aContainerName [
	"Add given elements to a named container that must already exist"

	self
		childWithId: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChildren: aListOfElements. ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstDetect: aBlock ifFound: ifFoundBlock [
	^ self 
		allChildrenBreadthFirstDetect: aBlock 
		ifFound: ifFoundBlock 
		ifNone: [ nil ]
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	self allChildrenBreadthFirstDo: [ :aChild |
		(aBlock value: aChild)
			ifTrue: [ ^ ifFoundBlock value: aChild ] ].
	^ ifNoneBlock value
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstDo: aBlock [ 
	self childrenDo: aBlock.
	self childrenDo: [ :each | each allChildrenBreadthFirstDo: aBlock ]
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstDo: elementAndDepthBlock withDepth: aDepth [

	" same as allChildrenBreadthFirstDo: except that 
	aDepth supplies the second argument to the block"
	
	self childrenDo: [:child | elementAndDepthBlock value: child value: aDepth].
	self childrenDo: [ :each | each allChildrenBreadthFirstDo: elementAndDepthBlock withDepth: aDepth + 1]
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstSelect: aBlock [ 
	| selectedChildren |
	selectedChildren := OrderedCollection new.
	self allChildrenBreadthFirstDo: [:each | 
		(aBlock value: each) ifTrue: [ selectedChildren add: each ] ].
	^ selectedChildren
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenBreadthFirstWithDepthDo: elementAndDepthBlock [

	" same as allChildrenBreadthFirstDo: except that 
	the children depth supplies the second argument to the block"
	
	self allChildrenBreadthFirstDo: elementAndDepthBlock withDepth: 1
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenCount [

	| count |
	count := 0.
	self allChildrenDepthFirstDo: [ :_ | count := count + 1 ].
	^ count
]

{ #category : #'api - children enumeration' }
BlElement >> allChildrenDepthFirstDo: aBlock [
	self childrenDo: [ :each | each allChildrenDepthFirstDo: aBlock ].
	self childrenDo: aBlock
]

{ #category : #'children accessing' }
BlElement >> allParents [
	"Return a collection of all parents starting with my parent and ending with the top most parent"

	^ Array streamContents: [ :aStream |
		self allParentsDo: [ :eachParent | aStream nextPut: eachParent ] ]
]

{ #category : #'children accessing' }
BlElement >> allParentsDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	self allParentsDo: [ :aParent | 
		(aBlock value: aParent)
			ifTrue: [ ^ ifFoundBlock value: aParent ] ].
	^ ifNoneBlock value
]

{ #category : #'children accessing' }
BlElement >> allParentsDo: aBlock [
	"Evaluate a block with my every parent as an argument starting from my direct parent
	up to the top most parent (excluding myself).
	If I don't have a parent - does nothing"

	| current |
	current := self.
	[ current := current parent ] whileNotNil: [ aBlock value: current ]
]

{ #category : #'children testing' }
BlElement >> allParentsInclude: anElement [
	"Return true if I have a given element in my parent chain, false otherwise"

	self allParentsDo: [ :aParentElement |
		aParentElement = anElement ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'children accessing' }
BlElement >> allParentsReverseDo: aBlock [
	"Evaluate a block with my every parent as an argument starting from my top most parent up to my direct parent (excluding myself).
	If no parent, then ignore."
	
	self hasParent ifFalse: [ ^ self ].
	self parent withAllParentsReverseDo: aBlock
]

{ #category : #'children accessing' }
BlElement >> allParentsTo: aParentElement do: aBlock [
	"Evaluate a block with each of my parents as an argument starting from my direct parent
	up to the given parent element (excluding myself).
	If I don't have a parent - does nothing"

	self
		deprecated: 'Please use #allParentsUpTo:do: instead'
		transformWith: 
			'`@receiver allParentsTo: `@arg1 do: `@arg2' -> 
			'`@receiver allParentsUpTo: `@arg1 do: `@arg2'.
		
	self allParentsUpTo: aParentElement do: aBlock
]

{ #category : #'children accessing' }
BlElement >> allParentsUpTo: aParentElement do: aBlock [
	"Evaluate a block with each of my parents as an argument starting from my direct parent
	up to the given parent element (excluding myself).
	If I don't have a parent - does nothing"

	self allParentsDo: [ :eachParent |
		aBlock value: eachParent.
		eachParent = aParentElement ifTrue: [ ^ self ] ]
]

{ #category : #'event handling' }
BlElement >> allowChildrenMouseEvents [
	"Allow my children to receive mouse events"

	flags addShouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> allowMeAndChildrenMouseEvents [
	"Allow me and my children to receive mouse events"

	flags addShouldHandleMouseEvents.
	flags addShouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> allowMouseEvents [
	"Allow *me* to handle mouse events.
	It does not influence the ability of the children to handle events, hence I am a local property"

	flags addShouldHandleMouseEvents.
]

{ #category : #layout }
BlElement >> applyLayoutIn: aBlBounds [
	
]

{ #category : #layout }
BlElement >> applyLayoutIn: aBlBounds context: aBlElementBoundsUpdateContext [

	self errorHandler
		with: self
		do: [
				self
					applyLayoutSafelyIn: aBlBounds
					context: aBlElementBoundsUpdateContext ]
		failed: [
				self
					applyLayoutThatFailedIn: aBlBounds
					context: aBlElementBoundsUpdateContext ]
]

{ #category : #'private - layout' }
BlElement >> applyLayoutSafelyIn: aRectangle context: aBlElementBoundsUpdateContext [
	"Layout me and my children within aRectangle in my local coordinates.
	Note: aRectangle may be a temporary or mutable rectangle, so you must not
	store or refer to it without making a copy!
	Note: subclasses should not override me, instead override onLayout: for concrete implementation.
	aRectangle must not be nil"
	| oldExtent newExtent newPosition extentChanged |

	oldExtent := self extent.
	newPosition := aRectangle origin.
	newExtent := aRectangle extent.
	extentChanged := newExtent ~= oldExtent.

	"Fast exit if I or any of my children did not request layout update
	and if my current bounds are the same as aRectangle"
	(self isLayoutRequested or: [
		self layout mayInfluencePosition not or: [
			extentChanged or: [ newPosition ~= self position ] ] ])
		ifFalse: [ ^ self ].

	"! actually change my position and extent !"
	self
		position: newPosition
		extent: newExtent
		context: aBlElementBoundsUpdateContext.

	"if my extent did not change and if I or any of my children did not
	request layout we do nothing"
	(extentChanged or: [
		self isLayoutRequested or: [
			self layout mayInfluencePosition ] ])
		ifTrue: [
			self
				onLayout: aRectangle
				context: aBlElementBoundsUpdateContext ].

	"we are done, mark that there are no layout requests pending"
	self privateRequestingLayout: false
]

{ #category : #'private - layout' }
BlElement >> applyLayoutThatFailedIn: aRectangle context: aBlElementBoundsUpdater [
	"Perform fallback safe action when layout computation failed"
	NonInteractiveTranscript stdout nextPutAll: 'Layout failed in ', self class name; cr.

	self position: aRectangle origin extent: aRectangle extent context: aBlElementBoundsUpdater.
	"we are done, mark that there are no layout requests pending"
	self privateRequestingLayout: false
]

{ #category : #converting }
BlElement >> asBlocResolvedElementsFrom: anElement [
	^ { self }
]

{ #category : #converting }
BlElement >> asElement [
	^ self 
]

{ #category : #converting }
BlElement >> asForm [

	^ BlHostRenderer preferableClass newFormFrom: self
]

{ #category : #'children add/remove' }
BlElement >> attachChild: anElement [
	"Attaches previously detached element as my last direct child.
	@see #attachChild:at: for more info"

	self attachChild: anElement at: self childrenCount + 1
]

{ #category : #'children add/remove' }
BlElement >> attachChild: anElement at: anIndex [
	"Attach an element making it my direct child. Attaching an element assigns me as the parent
	and puts an element in the list of children so that it can be retrieved by `children at:`.
   I am intended to be lightweight and make no assumptions about whether the parent or child should be redrawn.
	Proper use includes also making any appropriate #requestLayout or #changed message sends.
   I should only be used for elements which were detached from me as their previous parent.

	Preconditions:
	- anElement must not be my direct child.
	- anIndex must be within my childrens' array"

	self assert: anElement hasParent not.
	self assert: anIndex > 0.
	self assert: anIndex <= (self children size + 1).

	anElement parent: self.
	self children add: anElement at: anIndex.
	
	"if it is not attached to the scene graph we do not need to attach children"
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	anElement withAllChildrenBreadthFirstDo: [ :eachElement |
		eachElement isDetachedFromSceneGraph
			ifTrue: [ eachElement attachSpace ]
			ifFalse: [
				eachElement isRemovedFromSceneGraph
					ifTrue: [
						eachElement attachSpace.
						eachElement onAddedToSceneGraph ] ] ]
]

{ #category : #'api - space' }
BlElement >> attachSpace [
	spaceReference := BlAttachedSpaceReference uniqueInstance.
	
	"It is possible that an element requested focus while being temporarily
	detached from the space. We have to requestFocus again, otherwise the focus
	request will never reach the space.
	(https://github.com/feenkcom/gtoolkit/issues/1457)"
	self isFocused
		ifTrue: [ self requestFocus: self ]
		ifFalse: [
			self space focusOwner == self focusHolder
				ifTrue: [ self loseFocus: self ] ].

	self taskQueue isEmpty
		ifFalse: [ self space enqueueTasksFrom: self taskQueue ].

	"It is possible that an element requested itself to repaint while
	being temporarily detached from the space. If we do not resume
	propagation of the repainting request, elements wanting a composition layer
	will not be repainted (https://github.com/feenkcom/gtoolkit/issues/1459)"
	self needsPaint
		ifTrue: [ self markNeedsPaintFrom: self ]
]

{ #category : #'api - look' }
BlElement >> background [
	"Return my current background.
	Background can not be nil"
	<return: #BlBackground>

	^ visuals background
]

{ #category : #'api - look' }
BlElement >> background: aBlBackground [
	"Change my background to a given one.
	Color and Form can be used as background - they will be converted to an appropriate background object.
	It is also possible to create a more complicated composite background with the help of BlBackgroundBuilder.
	Raises BlElementBackgroundChangedEvent.
	aBlBackground must not be nil. "
	<event: #BlElementBackgroundChangedEvent>
		
	| aNewBackground |	
	aNewBackground := aBlBackground asBlBackground.
	self background = aNewBackground
		ifTrue: [ ^ self ].

	visuals := visuals background: aNewBackground.
	self updateBackground.
	self eventDispatcher dispatchBackgroundChanged.
	self invalidate
]

{ #category : #layout }
BlElement >> baselineOffset [
	"Return the offset of the element's text baseline from the element's top boundary.
	If I don't not support baseline alignment, BlElement>>#supportsBaseline return false"
	<return: #Number>

	^ 0
]

{ #category : #'api - compositing' }
BlElement >> beInSeparateCompositionLayer [
	"Make me that I want to be rendered in a separate compositing layer"

	self compositingMode: BlCompositingSeparateLayerMode uniqueInstance
]

{ #category : #'api - compositing' }
BlElement >> beInSingleCompositionLayer [
	"Make me and my children be rendered in a single compositing layer"

	self compositingMode: BlCompositingSingleLayerMode uniqueInstance
]

{ #category : #accessing }
BlElement >> beOutskirtsCentered [

	self outskirts: BlOutskirts centered
]

{ #category : #accessing }
BlElement >> beOutskirtsInside [

	self outskirts: BlOutskirts inside
]

{ #category : #accessing }
BlElement >> beOutskirtsOutside [

	self outskirts: BlOutskirts outside
]

{ #category : #'api - compositing' }
BlElement >> beWithoutCompositionLayer [
	"Make me and my children be rendered without compositing layer"

	self compositingMode: BlCompositingWithoutLayerMode uniqueInstance
]

{ #category : #'api - look' }
BlElement >> border [
	<return: #BlBorder>

	^ visuals border
]

{ #category : #'api - look' }
BlElement >> border: aBlBorder [
	"Change my border and invalidate me. aBlBorder can be created using BlBorderBuilder. Raises BlElementBorderChangedEvent"
	
	<event: #BlElementBorderChangedEvent>

	| newBorder |
	newBorder := aBlBorder asBlBorder.
	self border = newBorder
		ifTrue: [ ^ self ].
	visuals := visuals border: newBorder.
	self geometry releaseStrokedBoundsCache.
	self eventDispatcher dispatchBorderChanged.
	self invalidate
]

{ #category : #'layout anchors' }
BlElement >> bottomAnchor [

	^ BlElementBottomAnchor new
		  element: self;
		  yourself
]

{ #category : #'layout anchors' }
BlElement >> bottomLeftAnchor [

	^ BlElementBottomLeftAnchor new
		  element: self;
		  yourself
]

{ #category : #'layout anchors' }
BlElement >> bottomRightAnchor [

	^ BlElementBottomRightAnchor new
		  element: self;
		  yourself
]

{ #category : #'geometry bounds' }
BlElement >> bounds [
	<return: #BlElementBounds>

	^ bounds
]

{ #category : #accessing }
BlElement >> bounds: aBounds [

	self position: aBounds position.
	self size: aBounds extent
]

{ #category : #'private - accessing' }
BlElement >> boundsCache [
	^ boundsCache
]

{ #category : #'geometry bounds' }
BlElement >> boundsInLocal [

	^ boundsCache boundsInLocal
]

{ #category : #'geometry bounds' }
BlElement >> boundsInLocal: aBounds [
	"Load my local bounds in the given mutable bounds and return it.
	I do not rely on cache and always provide actual bounds.
	Local Bounds is nothing else than the bounds with origin point set to 0@0
	and with extent equal to my pure extent.
	Local Bounds property does not take effect or border into account.
	I am a part of internal api, use me with caution"

	^ self bounds boundsInLocal: aBounds
]

{ #category : #'geometry bounds' }
BlElement >> boundsInSpace [
	^ boundsCache boundsInSpace
]

{ #category : #'geometry bounds' }
BlElement >> boundsInWindow [
	^ self isAttachedToSceneGraph
		ifTrue: [ boundsCache boundsInSpace scaleBy: self space windowScale ]
		ifFalse: [ boundsCache boundsInSpace ]
]

{ #category : #'layout anchors' }
BlElement >> centerAnchor [

	^ BlElementCenterAnchor new
		  element: self;
		  yourself
]

{ #category : #updating }
BlElement >> changed [
	self error: 'Never use me, instead invalidate only what is needed'
]

{ #category : #'children accessing' }
BlElement >> childAt: anIndex [
	<return: #BlElement>
	
	^ self children at: anIndex
]

{ #category : #'children accessing' }
BlElement >> childIndexOf: anElement [
	"Answer the index of the first occurrence of anElement within the  
	receiver. If the receiver does not contain anElement, answer 0."
	<return: #Number>

	^ self children indexOf: anElement
]

{ #category : #'children accessing' }
BlElement >> childWithId: aBlElementId [
	<return: #BlElement>

	self
		childWithId: aBlElementId
		ifFound: [ :anElement | ^ anElement ]
		ifNone: [ self error: 'Children with id ', aBlElementId asString, ' does not exist' ]
]

{ #category : #'children accessing' }
BlElement >> childWithId: aBlElementId ifFound: ifFoundBlock [
	"Find (deeply) the first child element with a given id and evaluate a ifFoundBlock if such
	child exists and return the result of the evaluation. Return nil otherwise."
	<return: #BlElement>

	^ self
		childWithId: aBlElementId
		ifFound: ifFoundBlock
		ifNone: [ nil ]
]

{ #category : #'children accessing' }
BlElement >> childWithId: aStringOrSymbol ifFound: ifFoundBlock ifNone: ifNoneBlock [
	<return: #BlElement>
	| targetId |
	
	targetId := aStringOrSymbol.

	self allChildrenBreadthFirstDo: [ :aChild |
		aChild id = targetId
			ifTrue: [ ^ ifFoundBlock cull: aChild ] ].

	^ ifNoneBlock value
]

{ #category : #'children accessing' }
BlElement >> childWithId: aBlElementId ifNone: ifNoneBlock [
	"Find (deeply) the first child element with a given id and evaluate a ifNoneBlock if such
	child does not exists and return the result of the evaluation. Return nil otherwise."
	<return: #BlElement>

	^ self
		childWithId: aBlElementId
		ifFound: [ :anElement | ^ anElement ]
		ifNone: ifNoneBlock
]

{ #category : #'children accessing' }
BlElement >> children [
	"Return an array of all my direct children.
	children can not be nil"
	<return: #BlChildrenCollection>

	^ children
]

{ #category : #'api - children enumeration' }
BlElement >> childrenAt: aPoint do: aBlock [
	"Evaluate a given Block with my directs children under a given point provided
	in *my* local coordinates sorted in the order they are displayed (children reversed + elevation based).
	Return true if aBlock was evaluated, false otherwise"
	<return: #Boolean>
	| isPointInsideMe anyChildFound |

	isPointInsideMe := self containsPoint: aPoint.
	
	"if point is not inside of me and I clip children, it literally
	means that there neither me nor my children are visible at a given point"
	(isPointInsideMe not and: [ self clipChildren ])
		ifTrue: [ ^ false ].

	anyChildFound := false.
	
	self children sortedByElevation reverseDo: [ :eachChildElement |
		| aPointInChildCoordinates |
		aPointInChildCoordinates := eachChildElement parentPointToLocal: aPoint.

		(eachChildElement containsPoint: aPointInChildCoordinates)
			ifTrue: [
				aBlock value: eachChildElement.
				anyChildFound := true ] ].

	^ anyChildFound
]

{ #category : #'children accessing' }
BlElement >> childrenCount [
	"Return amount of my direct children"
	<return: #Number>

	^ self children size
]

{ #category : #'api - children enumeration' }
BlElement >> childrenDo: aBlock [
	"Evaluate aBlock with each of my direct children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"
	
	self children do: aBlock
]

{ #category : #'geometry position convertion' }
BlElement >> childrenPointToLocal: aPoint [
	"Transform and return a given point from the local coordinates of my children to my local coordinates."

	^ aPoint
]

{ #category : #'api - look' }
BlElement >> clipChildren [
	"Return whether the receiver clips children"

	^ visuals clipChildren
]

{ #category : #'api - look' }
BlElement >> clipChildren: aBoolean [
	self clipChildren = aBoolean
		ifTrue: [ ^ self ].

	visuals := visuals clipChildren: aBoolean.
	self invalidateChildren.
]

{ #category : #'api - compositing' }
BlElement >> compositingMode [
	<return: #BlCompositingMode>

	^ visuals compositingMode
]

{ #category : #'api - compositing' }
BlElement >> compositingMode: aBlCompositingMode [
	"Establish the compositing mode, and invalidate myself except if it's not a change."

	visuals compositingMode = aBlCompositingMode ifTrue: [ 
		^ self ].

	visuals := visuals compositingMode: aBlCompositingMode.
	self invalidate.
]

{ #category : #'api - compositing' }
BlElement >> compositionDepth [

	| aDepth |
	aDepth := 1.
	self allParentsDo: [ :eachParent | aDepth := aDepth + 1 ].
	^ aDepth
]

{ #category : #'api - painting' }
BlElement >> compositionLayer [
	"Return my composition layer if I have one or nil otherwise"
	
	^ self userData
		at: #compositionLayer
		ifAbsent: [ nil ]
]

{ #category : #'api - painting' }
BlElement >> compositionLayer: aCompositionLayer [
	"Assign a given composition layer to me"
	
	self userData
		at: #compositionLayer
		put: aCompositionLayer
]

{ #category : #'geometry bounds' }
BlElement >> computeEffectBoundsInto: aBlBounds [

	^ self effect computeEffectBoundsInto: aBlBounds
]

{ #category : #'geometry bounds' }
BlElement >> computeInvalidationBoundsInto: aBounds [
	"Compute the bounds of self, including my children recursively, in my local
	coordinates that would be invalidated if #invalidate would be sent to me."

	self computeVisualBoundsInto: aBounds.
	self computeEffectBoundsInto: aBounds.
	
	aBounds merge: self boundsInLocal.

	(self clipChildren not and: [ self hasChildren ]) ifTrue: [ 
		| aChildBounds |
		aChildBounds := BlBounds new.
		self children do: [ :anElement |
			anElement computeInvalidationBoundsInto: aChildBounds.
			anElement localBoundsToParent: aChildBounds.
			aBounds merge: aChildBounds ] ].

	^ aBounds
]

{ #category : #'private - layout' }
BlElement >> computeLayout [
	"Private! Never use me outside of #forceLayout"
	| relayoutCounter maxRelayoutCount aBlElementBoundsUpdateContext |

	relayoutCounter := 0.
	maxRelayoutCount := 100.
	[ self isLayoutRequested
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			| widthSpec heightSpec maxExtent |			
			maxExtent := self isAttachedToSceneGraph
				ifTrue: [ self space extent ]
				ifFalse: [ 800.0 @ 600.0 ].
			
			widthSpec := BlMeasurementSpec exact: maxExtent x.
			heightSpec := BlMeasurementSpec exact: maxExtent y.

			self measure: (BlExtentMeasurementSpec
				widthSpec: (self layout
					measurementSpecFor: widthSpec
					usedSize:  0.0
					resizer: self constraints horizontal resizer)
				heightSpec: (self layout
					measurementSpecFor: heightSpec
					usedSize:  0.0
					resizer: self constraints vertical resizer)).
			
			"...then we layout in measured on previous step bounds"
			aBlElementBoundsUpdateContext := BlElementBoundsUpdater new.
			self applyLayoutIn: self measuredBounds asRectangle context: aBlElementBoundsUpdateContext.
			aBlElementBoundsUpdateContext commitChanges.
			
			relayoutCounter := relayoutCounter + 1 ].
		
	relayoutCounter isZero
		ifFalse: [ self dispatchLayoutDone ]
]

{ #category : #'geometry bounds' }
BlElement >> computeVisualBoundsInto: aBounds [

	self geometry strokedBounds: aBounds of: self
]

{ #category : #'private - accessing' }
BlElement >> constraints [
	"Return layout constraints object which is used by the layout strategy.
	constraints can not be nil.
	@see BlElement>>#constraintsDo: for more convenient method to update constraints,
	as it requests layout update."
	<return: #BlLayoutConstraints>

	^ constraints
]

{ #category : #'private - accessing' }
BlElement >> constraints: aLayoutConstraints [
	"Set new layout constraints and request layout update.
	aLayoutConstraints must not be nil"

	constraints := aLayoutConstraints.
	self requestLayout
]

{ #category : #'api - layout' }
BlElement >> constraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument"
	
	aBlock value: self constraints.
	self requestLayout
]

{ #category : #'geometry testing' }
BlElement >> containsGlobalPoint: aPoint [
	(self geometryBoundsInSpace containsPoint: aPoint)
		ifFalse: [ ^ false ].
	^ self containsPoint: (self globalPointToLocal: aPoint)
]

{ #category : #'geometry testing' }
BlElement >> containsPoint: aPoint [
	"Return true if a given point provided in local coordinates is inside of my geometry, false otherwise."

	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].

	^ self geometry
		containsPoint: aPoint
		alreadyInGeometryBoundsOf: self
]

{ #category : #copying }
BlElement >> copy [
	"Visual elements can not be copied.
	The reason for that is the unpredictable amount of conflicting copying behaviours.
	For example, what should happen if a copied element is added to the parent?
	Should we create a new element without the parent or add a copied one to the parent of
	the original element? What should we do with View Models? How to deal with event handlers? ...
	
	Thus, we decided that the most consistent behaviour is to forbid all kind of copying
	and let users instantiate elements by themselves in the way they want it"

	self shouldNotImplement
]

{ #category : #'geometry bounds' }
BlElement >> damagedBoundsInSpace [

	^ boundsCache damagedBoundsInSpace
]

{ #category : #copying }
BlElement >> deepCopy [
	"See method comment of #copy"

	self shouldNotImplement
]

{ #category : #'focus accessing' }
BlElement >> deepestFocusedChild [
	"Return a child that is focused, if any.
	I may return nil of there is no such child"
	<return: #BlElement or: nil>

	self isFocused
		ifTrue: [ ^ self ].

	self children do: [ :eachChildElement | 
		eachChildElement deepestFocusedChild
			ifNotNil: [ :aFocusedChild | ^ aFocusedChild ] ].
	
	^ nil
]

{ #category : #initialization }
BlElement >> defaultBackground [
	"Return an object that should be used as element's background by default.
	Note: it may be any object that implements #asBlBackground"
	<return: #BlBackground>

	^ BlBackground transparent
]

{ #category : #initialization }
BlElement >> defaultBorder [
	"Return an instance of BlBorder that should be my default border"
	<return: #BlBorder>

	^ BlBorder empty
]

{ #category : #initialization }
BlElement >> defaultElevation [
	<return: #BlElevation>

	^ BlRelativeElevation zero
]

{ #category : #initialization }
BlElement >> defaultErrorHandler [
	^ BlCompositeErrorHandler withAll: { 
		BlDrawingErrorHandler new.
		BlLayoutErrorHandler new
	}
]

{ #category : #initialization }
BlElement >> defaultEventDispatcherClass [

	^ BlElementEventDispatcher
]

{ #category : #initialization }
BlElement >> defaultFocusability [
	<return: #BlFocusability>

	^ BlFocusability before
]

{ #category : #initialization }
BlElement >> defaultGeometry [
	^ BlRectangleGeometry new
]

{ #category : #initialization }
BlElement >> defaultLayout [
	^ BlBasicLayout uniqueInstance
]

{ #category : #initialization }
BlElement >> defaultLayoutCommonConstraints [

	^ BlLayoutCommonConstraints new
]

{ #category : #initialization }
BlElement >> defaultOutskirts [
	^ BlOutskirts inside
]

{ #category : #initialization }
BlElement >> defaultVisibility [
	<return: #BlVisibility>

	^ BlVisibility visible
]

{ #category : #'api - tasks' }
BlElement >> dequeueTask: aBlTask [

	self isAttachedToSceneGraph
		ifTrue: [ self space dequeueTask: aBlTask ]
		ifFalse: [ self taskQueue dequeue: aBlTask ]
]

{ #category : #'children add/remove' }
BlElement >> detachChild: anElement [
	"Detaches anElement from myself. Detaching an element should be followed either by attachChild: or removeDetachedChild:
	Detachment should only be temporary; reattachment or removal should happen within the same drawing cycle as detachment.
	When an element is detached, its parent is nil and cannot be retrieved using `children at:`
	I must not be used within removeChild: because I have completely different intent; I am meant to be temporary, while
	removeChild: is permanent.
	I don't clean focus in order to be able to preserve it in case child is attached back.
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement parent == self.

	anElement parent: nil.
	self children remove: anElement.

	anElement withAllChildrenBreadthFirstDo: [ :eachElement |
		eachElement isAttachedToSceneGraph
			ifTrue: [ eachElement detachSpace ] ].
]

{ #category : #'api - painting' }
BlElement >> detachCompositionLayer [
	"Detach my composition layer if any"

	self compositionLayer ifNotNil: [ :aLayer |
		aLayer removeFromParent.
		self compositionLayer: nil ]
]

{ #category : #'children add/remove' }
BlElement >> detachFromParentPreservingElevationWhile: aBlock [
	"Detach myself from a parent while evaluating a given block.
	I attach myself at the same position as before.
	Directly evaluate a block if I don't have a parent"
	
	self hasParent
		ifFalse: [ aBlock value ]
		ifTrue: [
			| aParentElement aChildIndex |
			
			aParentElement := self parent.
			aChildIndex := aParentElement childIndexOf: self.
			aParentElement detachChild: self.
			[ aBlock value ] ensure: [ aParentElement attachChild: self at: aChildIndex ] ]
]

{ #category : #'children add/remove' }
BlElement >> detachFromParentWhile: aBlock [
	"Detach myself from a parent while evaluating a given block.
	Directly evaluate a block if I don't have a parent"
	
	self hasParent
		ifFalse: [ aBlock value ]
		ifTrue: [
			| aParentElement |			
			aParentElement := self parent.
			aParentElement detachChild: self.
			[ aBlock value ] ensure: [ aParentElement attachChild: self] ]
]

{ #category : #'api - space' }
BlElement >> detachSpace [
	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'Can not detach space when not attached' ].

	spaceReference := BlDetachedSpaceReference uniqueInstance
]

{ #category : #'children accessing' }
BlElement >> directChildWithId: aStringOrSymbol ifFound: ifFoundBlock ifNone: ifNoneBlock [
	<return: #Object>

	self childrenDo: [ :aChild |
		aChild id ifNotNil: [ :id |
			(id = aStringOrSymbol)
				ifTrue: [ ^ ifFoundBlock cull: aChild ] ] ].
	^ ifNoneBlock value
]

{ #category : #'event handling' }
BlElement >> disableEventType: anEventClass while: aBlock [

	self eventDispatcher disableEventType: anEventClass while: aBlock
	
]

{ #category : #'children dispatching' }
BlElement >> dispatchAddedToParent [
	"Sent after I was added to another element as direct child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onAddedToParent.
	self eventDispatcher dispatchAddedToParent
]

{ #category : #'children dispatching' }
BlElement >> dispatchAddedToSceneGraph [
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must already be attached to the scene graph' ].

	self onAddedToSceneGraph.
	self childrenDo: [ :anElement |

		anElement isAttachedToSceneGraph
			ifFalse: [ anElement attachSpace ].
		
		anElement dispatchAddedToSceneGraph ]
]

{ #category : #'children dispatching' }
BlElement >> dispatchChildAdded: anElement [
	"First send hook to myself"

	self onChildAdded: anElement.

	"If and only if I am attached to scene graph we let child know
	that it is a part of the scene graph now"
	self isAttachedToSceneGraph ifTrue: [
		anElement attachSpace.
		anElement dispatchAddedToSceneGraph ].

	"Let child dispatch necessary events and hooks"
	anElement dispatchAddedToParent
]

{ #category : #'children dispatching' }
BlElement >> dispatchChildRemoved: anElement [

	"First send hook to myself"
	self onChildRemoved: anElement.
	"Let child dispatch necessary events and hooks"
	anElement dispatchRemovedFromParent: self.
	
	"If and only if I am attached to scene graph or I am detached from the scene graph
	we let child know that it is not a part of the scene graph anymore.
	
	We need to also handle the detached case here, as when detaching the 
	parent element this event is not triggered (this event will not be triggred at 
	all in case the parent is reattached)."
	(self isAttachedToSceneGraph or: [ self isDetachedFromSceneGraph ])
		ifTrue: [ anElement dispatchRemovedFromSceneGraph ]
]

{ #category : #layout }
BlElement >> dispatchLayoutDone [
	"Is sent when layout is done.
	Normally I am triggered by the space as soon as layout process is completed.
	I am recursively dispatched top-down through the scene graph and the whole composition tree of the elements.
	Layout done hook is essential for the implementation of so called `layout-once` layouts such as graph or visualisation layouts"

	self onLayoutDone.
	self layout onLayoutDone: self.
	self children do: [ :aChildElement | aChildElement dispatchLayoutDone ]
]

{ #category : #'children dispatching' }
BlElement >> dispatchRemovedFromParent: aParentElement [
	"Sent after I was removed from my parent and is not longer its direct child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onRemovedFromParent: aParentElement.
	self eventDispatcher dispatchRemovedFromParent
]

{ #category : #'children dispatching' }
BlElement >> dispatchRemovedFromSceneGraph [
	"Sent after any of my parents or I was removed from scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onRemovedFromSceneGraph.
	self eventDispatcher dispatchRemovedFromSceneGraph.
	self childrenDo: [ :anElement | anElement dispatchRemovedFromSceneGraph ]
]

{ #category : #'geometry bounds' }
BlElement >> distanceTo: aPoint [
	"Compute the euclidian distance from my closest edge to a provided point both given in my parent coordinates"
	<return: #Number>
	| aClampedPoint theBoundsInParent |
	
	theBoundsInParent := self bounds inParent.
	aClampedPoint := (aPoint min: theBoundsInParent bottomRight) max: theBoundsInParent topLeft.
	
	^ aClampedPoint distanceTo: aPoint
]

{ #category : #'geometry bounds' }
BlElement >> distanceToX: aPoint [
	"Compute the horizontal distance from my closest edge to a provided x coordinate of a point both given in my parent coordinates"
	<return: #Number>
	| aClampedCoordinate theBoundsInParent |
	
	theBoundsInParent := self bounds inParent.
	aClampedCoordinate := (aPoint x min: theBoundsInParent right) max: theBoundsInParent left.
	
	^ (aClampedCoordinate - aPoint x) abs
]

{ #category : #'geometry bounds' }
BlElement >> distanceToY: aPoint [
	"Compute the vertical distance from my closest edge to a provided y coordinate of a point both given in my parent coordinates"
	<return: #Number>
	| aClampedCoordinate theBoundsInParent |
	
	theBoundsInParent := self bounds inParent.
	aClampedCoordinate := (aPoint y min: theBoundsInParent bottom) max: theBoundsInParent top.
	
	^ (aClampedCoordinate - aPoint y) abs
]

{ #category : #accessing }
BlElement >> effect [
	"Return currently applied effect.
	Note: I return an instance of BlNullEffect when there is no effect applied.
	effect can not be nil"
	<return: #BlElementEffect>

	^ visuals effect
]

{ #category : #accessing }
BlElement >> effect: aBlEffect [
	"Change my effect to a given one requesting draw area invalidations.
	anEffect must not be nil but an instance of subclasses of BlEffect."

	visuals := visuals effect: aBlEffect.

	boundsCache invalidateLocalBounds.
	self invalidate.
]

{ #category : #'geometry bounds' }
BlElement >> effectBounds [

	| aBounds |
	aBounds := BlBounds new.
	self computeVisualBoundsInto: aBounds.
	self computeEffectBoundsInto: aBounds.

	^ aBounds "asRectangle"
]

{ #category : #'private - accessing' }
BlElement >> elementId [

	<return: #BlElementId>
	^ self userData at: #elementId ifAbsent: [ BlElementId noId ]
]

{ #category : #'private - accessing' }
BlElement >> elementId: aBlElementId [

	self userData at: #elementId put: aBlElementId
]

{ #category : #'api - look' }
BlElement >> elevation [
	<return: #BlElevation>

	^ visuals elevation
]

{ #category : #'api - look' }
BlElement >> elevation: aBlElevation [

	visuals := visuals elevation: aBlElevation.

	"when elevation changes, it is enough to just notify our parent, since
	my rendering state does not change, only the order in which parent paints its children"
	self hasParent
		ifTrue: [ 
			self parent children elevationChanged.
			self parent invalidate ]
]

{ #category : #'api - tasks' }
BlElement >> enqueueTask: aBlTask [
	"Queue the supplied task to be executed in the next frame.
	If you want the task executed in the UI process as soon as possible, use #inUIProcessDo:.
	Note that the task is not guaranteed to be executed (if the element is never attached to a scene)."

	aBlTask onEnqueuedInElement: self.
	self isAttachedToSceneGraph
		ifTrue: [ self space enqueueTask: aBlTask ]
		ifFalse: [ self taskQueue enqueue: aBlTask ]
]

{ #category : #accessing }
BlElement >> errorHandler [

	^ errorHandler
]

{ #category : #'event management accessing' }
BlElement >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'api - bounds' }
BlElement >> extent [
	"Return my extent as it was computed during previous layout pass.
	Extent is a point with `x` component representing my width
	and y component representing my height accordingly"

	<return: #Point>
	self
		flag:
			'TODO as extent: is deprecated, should this be as well in favor of size?'.
	^ self bounds extent
]

{ #category : #'geometry extent' }
BlElement >> extent: aPoint [ 
	self 
		deprecated: 'Use size: instead'
		on: 	'1 October 2017' 
		in: 'Pharo-7.0-alpha.build.132.sha.4ea2f39a9f43185d31b844be5ad33b677f43bf17'.
	^ self size: aPoint 
]

{ #category : #'layout anchors' }
BlElement >> extentAnchor [

	^ BlElementExtentAnchor new
		  element: self;
		  yourself
]

{ #category : #'event handling' }
BlElement >> findMouseEventTargetAt: aPoint [
	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child is found and if I can not be event target either"
	<return: #BlElement or: nil>
	| doWantEvent |
	
	"fast exit if I am not visible, since it implies that 
	neither I receive mouse events nor my (clipped or unclipped) children"
	self isVisible ifFalse: [ ^ nil ].
	
	doWantEvent := self wantsMouseEventAt: aPoint.

	"fast exit if my children are not allowed to handle mouse events
	or if there are no children"
	(self shouldChildrenHandleMouseEvents not or: [ self hasChildren not ])
		ifTrue: [ ^ (doWantEvent and: [ self shouldHandleMouseEvents ])
			ifTrue: [ self ]
			ifFalse: [ nil ] ].
	
	"fast return if I clip children and if I don't want the event"
	(self clipChildren and: [ doWantEvent not ])
		ifTrue: [ ^ nil ].

	self children sortedByElevation reverseDo: [ :eachChild |
			(eachChild findMouseEventTargetAt: aPoint)
				ifNotNil: [ :aTargetElement | ^ aTargetElement ] ].
	
	^ (doWantEvent and: [ self shouldHandleMouseEvents ])
		ifTrue: [ self ]
		ifFalse: [ nil ]
]

{ #category : #'children accessing' }
BlElement >> firstChild [
	"return the first child "
	self hasChildren ifFalse: [ ^ self error: 'Must have at least one child' ].
	^ self children first
]

{ #category : #'children accessing' }
BlElement >> firstCommonParent: anElement ifFound: aFoundBlock ifNone: aNoneBlock [
	"Find the first common parent of a receiver and a given element.
	Evaluate aFoundBlock with that parent if there is one and aNoneBlock otherwise"
	
	(self hasParent
		and: [ anElement hasParent
			and: [ self parent == anElement parent ] ])
		ifTrue: [ ^ aFoundBlock value: self parent ].
	
	self withAllParentsDo: [ :myParent |
		anElement withAllParentsDo: [ :otherParent |
			myParent == otherParent
				ifTrue: [ ^ aFoundBlock value: myParent ] ] ].
	
	^ aNoneBlock value
]

{ #category : #'focus requesting' }
BlElement >> focusHolder [
	"Answer the element that will be actually focused when #requestFocus is sent."

	^ self
]

{ #category : #accessing }
BlElement >> focusability [
	<return: #BlFocusability>

	^ visuals focusability
]

{ #category : #accessing }
BlElement >> focusability: aFocusability [
	self focusability = aFocusability
		ifTrue: [ ^ self ].

	visuals := visuals focusability: aFocusability
]

{ #category : #'focus accessing' }
BlElement >> focusables: aBlFocusFinderCandidates along: aBlFocusSearchDirection [
	"Add focusable elements that are descendants of this element (possibly including me) to anOrderedCollection
	depending on my focusability strategy"

	self focusability
		focusables: aBlFocusFinderCandidates
		along: aBlFocusSearchDirection
		of: self
]

{ #category : #'private - accessing' }
BlElement >> focused [

	^ visuals isFocused
]

{ #category : #'private - accessing' }
BlElement >> focused: aBoolean [
	visuals := visuals focused: aBoolean
]

{ #category : #'geometry bounds' }
BlElement >> focusedBounds [

	^ (self focusedBounds: BlBounds new) asRectangle
]

{ #category : #'geometry bounds' }
BlElement >> focusedBounds: aBlBounds [
	"Store my focused area in the given bounds and return it. Focused area
	is used to search next focusable element. By default focused bounds property
	is just local bounds. Override me to return more specific area, for example
	cursor bounds or selected cell in the table"
	
	^ self boundsInLocal: aBlBounds
]

{ #category : #'focus accessing' }
BlElement >> focusedChild [
	"Return my direct child that is focused or contains a focused child, if any. The child may have or contain focus.
	I may return nil of there is no such child"
	<return: #BlElement or: nil>

	^ self children
		detect: [ :anElement | anElement hasFocus ]
		ifNone: [ nil ]
]

{ #category : #'layout utilities' }
BlElement >> forceLayout [
	"Do not use me, I am a private / debug utility method to force layout computation.
	The main usage of this method is for testing purposes where we want to update layout
	without the need to create a separate space and add an element to it in order to test bounds or position.
	Note: because layout measurement may depend on other element it is mandatory to compute
	layout going down from the top most parent, otherwise layout will not be valid"

	self requestLayout.
	self topMostParent computeLayout
]

{ #category : #'layout utilities' }
BlElement >> forceLocalLayout [
	"Use me with care only if you know what you are doing. See #forceLayout comment to understand the context and why I can be problematic."

	self requestLayout.
	self computeLayout
]

{ #category : #'api - look' }
BlElement >> geometry [
	"Return my geometry used to clip/fill/stroke me and to clip my children during rendering.
	geometry can not be nil."
	<return: #BlElementGeometry>

	^ visuals geometry
]

{ #category : #'api - look' }
BlElement >> geometry: aBlGeometry [
	
	"clean the cache of the old geometry"
	self geometry releaseCache.
	visuals := visuals geometry: aBlGeometry.

	"clear path cache after updating geometry path"
	self geometry releaseCache.
	boundsCache invalidateLocalBounds.

	"extent might not change, so we need to update geometry manually"
	self updateGeometry.

	"invalidate with new geometry"
	self invalidate.

	self requestLayout
]

{ #category : #'geometry bounds' }
BlElement >> geometryBounds [

	^ boundsCache geometryBounds
]

{ #category : #'geometry bounds' }
BlElement >> geometryBounds: aBlBounds [
	"I load my geometry bounds in a given mutable rectangle and return provided one.
	By default it is nothing else than a rectangle with origin point set to
	geometry's position and with extent equal to my geometry's extent.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT
	I am a part of internal api, use me with caution"

	^ self geometry geometryBounds: aBlBounds of: self
]

{ #category : #'geometry bounds' }
BlElement >> geometryBoundsInSpace [
	"Return bounds of my geometry in space coordinates.
	Note, that geometry bounds may differ from #boundsInSpace for the case of non-trivial geometry.
	Geometry bounds in space is used to find out if a mouse event position is within the element.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT"

	^ boundsCache geometryBoundsInSpace
]

{ #category : #'geometry bounds convertion' }
BlElement >> globalBoundsToLocal: aBounds [
	"In-place transform bounds from global space coordinates to local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	"First delegate transformation to my parent if I have one"
	self hasParent ifTrue: [ self parent globalBoundsToLocal: aBounds ].

	"and then transform provided bounds from parent coordinates to my local ones"
	self parentBoundsToLocal: aBounds.

	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> globalBoundsToMine: aBlBounds fromParent: aParentElement [
	"In-place transform provided bounds from coordinate system of a given parent
	to my local coordinates and return a result"

	| theParents |
	aParentElement == self ifTrue: [ ^ aBlBounds ].

	theParents := Array streamContents: [ :aStream |
		              | eachParent |
		              aStream nextPut: self.
		              eachParent := self parent.
		              [ eachParent == aParentElement ] whileFalse: [
			              aStream nextPut: eachParent.
			              eachParent := eachParent parent ] ].

	theParents reverseDo: [ :eachParent |
		eachParent parentBoundsToLocal: aBlBounds ].

	^ aBlBounds
]

{ #category : #'geometry position convertion' }
BlElement >> globalPointToChildren: aPoint [
	"Transform a given point from the coordinates of my top most parent to my children coordinates"
	<return: #Point>

	^ self localPointToChildren: (self globalPointToLocal: aPoint)
]

{ #category : #'geometry position convertion' }
BlElement >> globalPointToLocal: aPoint [
	"Transform a given point from the coordinates of my root most parent to my local coordinates"
	<return: #Point>
	| pt |

	pt := self hasParent
		ifTrue: [ self parent globalPointToLocal: aPoint ]
		ifFalse: [ aPoint ].

	^ self parentPointToLocal: pt
]

{ #category : #'geometry position convertion' }
BlElement >> globalPointToParent: aPoint [
	"Transform and return a given point from the coordinates of my root most parent to my parent's coordinates"
	
	^ self hasParent
		ifTrue: [ self parent globalPointToLocal: aPoint ]
		ifFalse: [ aPoint ]
]

{ #category : #'geometry position convertion' }
BlElement >> globalPointToParentChildren: aPoint [
	"Transform a given point from the coordinates of my top most parent to my parent's children coordinates"
	<return: #Point>
	| pt |
	
	pt := self globalPointToParent: aPoint.
	self hasParent
		ifTrue: [ pt := self parent localPointToChildren: pt ].

	^ pt
]

{ #category : #'geometry transform' }
BlElement >> globalScale [
	"Return a scale factor from "
	<return: #Number>
	| anOrigin aCorner aGlobalOrigin aGlobalCorner |
	
	anOrigin := 0@0.
	aCorner := 1@0.

	aGlobalOrigin := self localPointToGlobal: anOrigin.
	aGlobalCorner := self localPointToGlobal: aCorner.
	
	^ (aGlobalOrigin distanceTo: aGlobalCorner) / (anOrigin distanceTo: aCorner)
]

{ #category : #'children testing' }
BlElement >> hasAnyInParentChain: aCollection [
	"Return true if any one in the given collection in my parent chain (including myself) "

	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/715'.

	^ aCollection anySatisfy: [ :e | self hasInParentChain: e ]
]

{ #category : #'children testing' }
BlElement >> hasChild: anElement [
	
	^ anElement parent == self
]

{ #category : #'children testing' }
BlElement >> hasChildren [
	"Return true if I have at least one direct child,
	false otherwise"
	<return: #Boolean>
	
	^ self children notEmpty
]

{ #category : #'api - compositing' }
BlElement >> hasCompositionLayer [

	^ self compositionLayer isNotNil and: [ self compositionLayer isValid ]
]

{ #category : #'focus testing' }
BlElement >> hasFocus [
	"Return true if an element is focused or contains a focused element, false otherwise"

	^ self isFocused or: [
		self children anySatisfy: [ :anElement | anElement hasFocus ] ]
]

{ #category : #'focus testing' }
BlElement >> hasFocusable [
	"Returns true if I am focusable or if I contain a reachable child for which #hasFocusable returns true,
	false otherwise"

	^ self isFocusable or: [
		self children anySatisfy: [ :anElement | anElement hasFocusable ] ]
]

{ #category : #'children testing' }
BlElement >> hasInParentChain: anElement [
	"Return true if I have a given element in my parent chain, or if I am anElement "

	self
		deprecated: 'Please use #withAllParentsInclude: instead.'
		transformWith:
			'`@receiver hasInParentChain: `@arg' ->
			'`@receiver withAllParentsInclude: `@arg'.

	^ self withAllParentsInclude: anElement
]

{ #category : #'event management accessing' }
BlElement >> hasNextEventTarget [
	"Return true if this event target has a logical successor within a dispatch chain.
	For example, in case of visual components next event target is a parent, meaning
	that first event is handled by child and then dispatched to the parent if that event
	was not consumed"
	<return: #Boolean>

	^ self hasParent
]

{ #category : #'children testing' }
BlElement >> hasOwner [

	self
		deprecated: 'Use hasParent instead of current one'
		transformWith: '`@receiver hasOwner' -> '`@receiver hasParent'.

	^ self hasParent
]

{ #category : #'children testing' }
BlElement >> hasParent [
	"Return true if I have a parent, otherwise false.
	Being added as direct child to other element does not necessary
	mean that I am in the space scene graph"

	^ self parent isNotNil
]

{ #category : #'children testing' }
BlElement >> hasParent: anElement [
	"Return true if I have a given element in my parent chain, false otherwise"

	self
		deprecated: 'Use allParentsInclude: instead'
		transformWith: '`@rcvr hasParent: `@arg' -> '`@rcvr allParentsInclude: `@arg'.

	^ self allParentsInclude: anElement
]

{ #category : #'api - bounds' }
BlElement >> height [
	^ self extent y
]

{ #category : #'api - bounds' }
BlElement >> height: aNumber [
	<event: #BlElementExtentChangedEvent>
	| aLayoutConstraints |

	aLayoutConstraints := self constraints.
	(aLayoutConstraints vertical resizer isExact and: [ 
		aLayoutConstraints vertical resizer size = aNumber ])
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c |
		c vertical exact: aNumber ]
]

{ #category : #'layout anchors' }
BlElement >> heightAnchor [

	^ BlElementHeightAnchor new
		  element: self;
		  yourself
]

{ #category : #'layout anchors' }
BlElement >> horizontalCenterAnchor [

	^ BlElementHorizontalCenterAnchor new
		  element: self;
		  yourself
]

{ #category : #accessing }
BlElement >> id [
	"Return an id of this element if it was defined"

	<return: #Symbol>
	^ self elementId asSymbol
]

{ #category : #accessing }
BlElement >> id: aStringOrSymbol [
	"Give this element an id which can be used to query this element"
	
	self elementId: aStringOrSymbol asBlocElementId
]

{ #category : #layout }
BlElement >> ignoreRequestLayoutDuring: aBlock [
	| wasIgnored |

	wasIgnored := flags hasShouldIgnoreLayoutRequests.
	flags addShouldIgnoreLayoutRequests.
	aBlock ensure: [
		wasIgnored
			ifTrue: [ flags addShouldIgnoreLayoutRequests ]
			ifFalse: [ flags clearShouldIgnoreLayoutRequests ] ]
]

{ #category : #'api - space' }
BlElement >> inSpace [
	"Add self to a new BlSpace. Answer such space."
	| sp |
	sp := BlSpace new.
	sp root addChild: self.
	^ sp

]

{ #category : #processing }
BlElement >> inUIProcessDo: aBlock [
	"Run the supplied block in the UI process.
	If the active process is already the UI process, evaluate immediately. 
	Otherwise, queue up for the next frame."

	| uiProcess |
	self isAttachedToSceneGraph ifTrue: [ 
		self space host uiProcessDo: [ :uiProc | uiProcess := uiProc ] ].

	uiProcess = Processor activeProcess
		ifTrue: [ aBlock value ]
		ifFalse: [ 
			self enqueueTask: (BlTaskAction new
					 action: aBlock;
					 yourself) ]
]

{ #category : #initialization }
BlElement >> initialize [

	super initialize.

	spaceReference := BlNullSpaceReference uniqueInstance.
	visuals := BlDefaultVisuals uniqueInstance.

	boundsCache := BlBoundsCache on: self.
	bounds :=
		BlElementLocalBounds new
			referenceElement: self;
			yourself.
	measuredBounds :=
		BlElementLocalBounds new
			referenceElement: self;
			yourself.

	self initializeEventDispatcher.
	
	constraints := self defaultLayoutCommonConstraints.
	self resetChildrenArray.

	transformation := BlElementCachedIdentityTransformation uniqueInstance.

	layout := self defaultLayout.

	flags := BlElementFlags new.
	flags addShouldHandleMouseEvents.
	flags addShouldChildrenHandleMouseEvents.
	flags addNeedsLayout.
	flags addWaitingLayout.

	taskQueue := BlTaskQueue new.
	errorHandler := self defaultErrorHandler
]

{ #category : #initialization }
BlElement >> initializeEventDispatcher [
 
	eventDispatcher := self newEventDispatcher
]

{ #category : #'geometry bounds' }
BlElement >> insets [

	self
		deprecated: 'Use #padding instead of current one'
		transformWith: '`@receiver insets' -> '`@receiver padding'.

	^ self padding
]

{ #category : #'change reporting' }
BlElement >> invalidate [
	"I mark my bounds as damaged area that should be redrawn on next rendering pass.
	Note, that #invalidate might be sent frequently, so keep implementation simple and performant.
	Try to avoid unnecessary object creation to not load garbage collector with much work.
	You should clearly understand consequences of sending #invalidate. For example if element
	just changes its position the content does not change so you should send invalidation to the
	parent (also providing invalidated bounds in parent coordinates) because only its content changes and not my own.
	Please, don't forget that elements or rendering backends may implement a rendering cache that
	is also invalidated on every #invalidate message sent, so use me wisely."

	self markNeedsPaintFrom: self
]

{ #category : #'change reporting' }
BlElement >> invalidateAfterRelocateFrom: aPreviousPosition to: aNewPosition [
	"Invalidate due to relocation by a given offset"

	(self wantsSeparateCompositingLayer and: [
		self hasCompositionLayer and: [
			self isAttachedToSceneGraph ] ]) ifTrue: [
				^ self space markNeedsCompositionPaint: self from: self ].

	self hasParent ifTrue: [ self parent invalidate ]
]

{ #category : #'api - look' }
BlElement >> invalidateChildren [

	self childrenDo: [ :each | each invalidate ]
]

{ #category : #'geometry bounds' }
BlElement >> invalidationBounds [

	^ self invalidationBounds: BlBounds new
]

{ #category : #'geometry bounds' }
BlElement >> invalidationBounds: aBounds [
	"Compute the bounds of self, including my children recursively, in my local
	coordinates that would be invalidated if #invalidate would be sent to me."

	| anInvalidationBounds |
	
	self computeVisualBoundsInto: aBounds.
	anInvalidationBounds := (self computeEffectBoundsInto: aBounds) merge: self boundsInLocal.

	(self clipChildren not and: [ self hasChildren ]) ifTrue: [ 
		| aChildBounds |
		aChildBounds := BlBounds new.
		self children do: [ :anElement |
			anElement invalidationBounds: aChildBounds.
			anElement localBoundsToParent: aChildBounds.
			anInvalidationBounds merge: aChildBounds ] ].

	^ anInvalidationBounds
]

{ #category : #'geometry bounds' }
BlElement >> invalidationBoundsInParent [

	| result |
	result := BlBounds new.
	self invalidationBounds: result.
	self localBoundsToParent: result.
	^ result
]

{ #category : #'geometry bounds' }
BlElement >> invalidationBoundsInSpace [

	^ boundsCache invalidationBoundsInSpace
]

{ #category : #'api - space' }
BlElement >> isAttachedToSceneGraph [
	"Return true if I am inside of a scene graph, e.g. I have a space's root element
	as my top-most parent, false otherwise"

	^ spaceReference isAttachedToSceneGraph
]

{ #category : #'api - space' }
BlElement >> isDetachedFromSceneGraph [
	"Return true if I am detached from the scene graph"
	<return: #Boolean>

	^ spaceReference isDetachedFromSceneGraph
]

{ #category : #'children accessing' }
BlElement >> isFirstChild [
	"return true if the receiver is the first child of its parent"
	self hasParent ifFalse: [ ^ self error: 'Must have a parent' ].
	^ (self parent childIndexOf: self) = 1
]

{ #category : #'focus testing' }
BlElement >> isFocusable [
	"Return true if I am able to take focus, false otherwise"
	<return: #Boolean>

	^ self isVisible
		and: [ self shouldHandleMouseEvents
			and: [ self focusability ~= BlFocusability none
				and: [ self focusability ~= BlFocusability ignore ] ] ]
]

{ #category : #'private - accessing' }
BlElement >> isFocused [
	"Returns true if I am focused, false otherwise.
	Note: It is possible that an element has focus but is not focused by itself."

	^ self focusHolder = self
		  ifTrue: [ visuals isFocused ]
		  ifFalse: [ self focusHolder isFocused ]
]

{ #category : #testing }
BlElement >> isFullyVisibleInSpace [
	"Return true if I am in fully visible in the area of a space (window), false otherwise.
	Note, that this visibility is computed only based on bounds. 
	It may happend that I am not visible because of another element."

	| myBounds intersection |
	self assert: self isAttachedToSceneGraph.

	myBounds := self bounds asRectangle.
	intersection := self bounds inSpace bounds intersect: (0@0 extent: self space extent) ifNone: [ ^ false ].
	^ intersection asRectangle = myBounds
]

{ #category : #'children accessing' }
BlElement >> isLastChild [
	"return true if the receiver is the first child of its parent"
	self hasParent ifFalse: [ ^ self error: 'Must have a parent' ].
	^ (self parent childIndexOf: self) = self parent children size
]

{ #category : #layout }
BlElement >> isLayoutBoundary [
	"Return true if I am a layout boundary, e.g. the layout recomputation requests should not be propagated up in the hierarchy.
	Imagine an element matches parent in both directions or has a fixed size, in this case even if my children request layout update
	I do not have to propagate it further because it will not have any influence on the parent"
	<return: #Boolean>
	
	^ (self constraints horizontal resizer isExact or: [ self constraints horizontal resizer isMatchParent ])
		and: [ self constraints vertical resizer isExact or: [ self constraints vertical resizer isMatchParent ] ]
]

{ #category : #layout }
BlElement >> isLayoutRequested [
	"Indicates whether or not this elements's layout will be requested during the next hierarchy layout pass.
	Return true if the layout will be forced during next layout pass, false otherwise"

	^ flags hasNeedsLayout
]

{ #category : #testing }
BlElement >> isOpaque [
	"Return true if I am completely opaque (my opacity is 1)"

	^ self opacity = 1.0
]

{ #category : #'api - space' }
BlElement >> isRemovedFromSceneGraph [
	"Return true if I am not in the scene graph"
	<return: #Boolean>

	^ spaceReference isNull
]

{ #category : #testing }
BlElement >> isRoot [
	"Return true if I am a root element of a space, false otherwise"
	<return: #Boolean>

	^ self isAttachedToSceneGraph and: [ self space root = self ]
]

{ #category : #testing }
BlElement >> isTextElement [ 

	^ false
]

{ #category : #testing }
BlElement >> isTranslucent [
	"Return true if I am semi-transparent (opacity is 0 < opacity < 1)"

	^ self opacity > 0 and: [ self opacity < 1 ]
]

{ #category : #testing }
BlElement >> isTransparent [
	"Return true if I am completely transparent (my opacity is 0)"
	<return: #Boolean>

	^ self opacity isZero
]

{ #category : #testing }
BlElement >> isVisible [
	"Return true if I should be visible, false otherwise.
	Note, that I am not the same as isTransparent/isOpaque, those
	just influence rendering and not behaviour or interaction.
	If element is invisible it does not receive events such as mouse clicks"
	<return: #Boolean>

	^ self visibility isVisible
]

{ #category : #testing }
BlElement >> isVisibleInSpace [
	"Return true if I am in a visible area of a space (window), false otherwise.
	Note, that this visibility is computed only based on bounds. 
	It may happend that I am not visible because of another element."

	^ self isAttachedToSceneGraph and: [ 
		self isVisible and: [
			self bounds inSpace bounds intersects: (0@0 extent: self space extent) ] ].
]

{ #category : #accessing }
BlElement >> labeled: aString [
	self id: aString asSymbol
]

{ #category : #'children accessing' }
BlElement >> lastChild [
	"Return the last child, or signal error if it does not exist."
  
	self hasChildren ifFalse: [ ^ self error: 'Must have at least one child' ].
	^ self children last
]

{ #category : #'api - layout' }
BlElement >> layout [

	^ layout
]

{ #category : #'api - layout' }
BlElement >> layout: aBlLayout [
	"Change my current layout to a given one, instance of subclasses of BlLayout.
	After the layout change I request the layout recomputation.
	aBlLayout must not be nil. Raises BlElementLayoutChangedEvent"

	<event: #BlElementLayoutChangedEvent>

	layout = aBlLayout
		ifTrue: [ ^ self ].

	layout := aBlLayout.

	self eventDispatcher dispatchLayoutChanged.
	self requestLayout
]

{ #category : #'api - layout' }
BlElement >> layoutDo: aBlock [
	"Perform aBlock with my layout as argument.
	Note: After evaluation I request a layout update.
	aBlock must not be nil.
	aBlock must accept exactly one argument"

	aBlock value: self layout.
	self requestLayout
]

{ #category : #'layout anchors' }
BlElement >> leftAnchor [

	^ BlElementLeftAnchor new
		  element: self;
		  yourself
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToChildren: aBounds [
	"In-place transform bounds from my local coordinates to my childrens' coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	
	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToGlobal: aBounds [
	"In-place transform bounds from local coordinates to global space coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToParent: aBounds.

	"and then delegate transformation to my parent if I have one"
	self hasParent ifTrue: [ self parent localBoundsToGlobal: aBounds ].

	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToMine: aBounds fromChild: anElement [
	"In-place transform provided bounds from coordinate system of a given descendant element
	to my local coordinates and return a result"

	| aParentElement |
	anElement == self ifTrue: [ ^ aBounds ].
		
	aParentElement := anElement.
	[
		aParentElement localBoundsToParent: aBounds.
		aParentElement := aParentElement parent
	] doWhileFalse: [ aParentElement == self ].
			
	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToParent: aBounds [
	"In-place transform bounds from local coordinates to my parent's coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	"first apply transformation if we have one"
	self transformation transformBounds: aBounds.

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aBounds translateBy: self position.
		
	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToWindow: aBounds [
	"In-place transform bounds from local coordinates to device window coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	
	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToGlobal: aBounds.

	"and then delegate transformation to my parent if I have one"
	self isAttachedToSceneGraph
		ifTrue: [ aBounds scaleBy: self space windowScale ].

	^ aBounds
]

{ #category : #'geometry position convertion' }
BlElement >> localPointToChildren: aPoint [
	"Transform a given point from my local coordinates to the local coordinates of my children."
	<return: #Point>

	^ aPoint
]

{ #category : #'geometry position convertion' }
BlElement >> localPointToGlobal: aPoint [
	"Transform a given point from my local coordinates to the coordinates of the root most parent"
	<return: #Point>
	| pt |

	pt := self localPointToParent: aPoint.

	^ self hasParent
		ifTrue: [ self parent localPointToGlobal: pt ]
		ifFalse: [ pt ]
]

{ #category : #'geometry bounds convertion' }
BlElement >> localPointToMine: aPoint fromChild: anElement [
	"compute a point from provided point from coordinate system of a given descendant element
	to my local coordinates"

	| aParentElement result |
	anElement == self ifTrue: [ ^ aPoint ].

	result := aPoint.
	aParentElement := anElement.

	[	result := aParentElement localPointToParent: result.
		aParentElement := aParentElement parent ]
			doWhileFalse: [ aParentElement == self ].

	^ result
]

{ #category : #'geometry position convertion' }
BlElement >> localPointToParent: aPoint [
	"Transform a given point from my local coordinates to local coordinates of my parent.
	Since this transfortmation does not actually involve my parent, it can be performed
	regardless of if I have one"
	<return: #Point>
	| pt |
	"first we should apply my transformation, since it is the only factor
	effecting local nature of a coordinate"
	pt := self transformation transformPoint: aPoint.
	"next we should translate it to be within my parent's local coordinates"
	pt := pt translateBy: self position.
	
	self hasParent
		ifTrue: [ pt := self parent childrenPointToLocal: pt ].
		
	^ pt
]

{ #category : #'focus requesting' }
BlElement >> loseFocus [
	| anElementToLooseFocus |

	anElementToLooseFocus := self isFocused
		ifTrue: [ self focusHolder ]
		ifFalse: [ self deepestFocusedChild
			ifNil: [ self focusHolder ] ].

	anElementToLooseFocus isFocused
		ifFalse: [ ^ self ].

	anElementToLooseFocus isAttachedToSceneGraph
		ifTrue: [ anElementToLooseFocus loseFocus: anElementToLooseFocus ]
		ifFalse: [ anElementToLooseFocus focused: false ]
]

{ #category : #'focus requesting' }
BlElement >> loseFocus: aChildElement [
	"Propagate focus loss up in the scene graph with an original
	element that looses focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].
		
	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent loseFocus: aChildElement ]
		ifFalse: [ self space loseFocusFor: aChildElement ]
]

{ #category : #'api - layout' }
BlElement >> margin [
	"Return my current margin - a space outside around my bounds.
	Layouts that support margin may want to expand children such that there is a space gap around them"
	<return: #BlInsets>

	^ self constraints margin
]

{ #category : #'api - layout' }
BlElement >> margin: aBlInsets [

	self margin = aBlInsets
		ifTrue: [ ^ self ].
	self constraintsDo: [ :c | c margin: aBlInsets ]
]

{ #category : #'api - painting' }
BlElement >> markDoesNotNeedPaint [

	flags clearNeedsPaint
]

{ #category : #'api - painting' }
BlElement >> markNeedsPaintFrom: anElement [
	"Make me as dirty and request renderer to re-paint me.
	anElement is the element from which the re-painting request originates"

	flags addNeedsPaint.

	self wantsSeparateCompositingLayer
		ifTrue: [
			self isAttachedToSceneGraph ifFalse: [ ^self ].
			self hasCompositionLayer
				ifTrue: [ self space markNeedsPaint: self from: anElement ]
				ifFalse: [
					self hasParent
						ifTrue: [ self parent markNeedsPaintFrom: anElement ]
						ifFalse: [ self space markNeedsPaint: self from: anElement ] ] ]
		ifFalse: [
			self hasParent
				ifTrue: [ self parent markNeedsPaintFrom: anElement ]
				ifFalse: [
					self isAttachedToSceneGraph ifFalse: [ ^self ].
					self space markNeedsPaint: self from: anElement ] ]
]

{ #category : #'view - configuration' }
BlElement >> maxHeight [

	"get maxHeight in constraints"
	^ self constraints maxHeight
]

{ #category : #'view - configuration' }
BlElement >> maxHeight: aNumber [

	"set maxHeight in constraints"
	self constraintsDo: [ :c | c maxHeight: aNumber ]
]

{ #category : #'view - configuration' }
BlElement >> maxSize [

	"get maxSize in constraints"
	^ self maxWidth @ self maxHeight
]

{ #category : #'view - configuration' }
BlElement >> maxSize: aPoint [

	self constraintsDo: [ :c |
		c maxWidth: aPoint x.
		c maxHeight: aPoint y ]
]

{ #category : #'view - configuration' }
BlElement >> maxWidth [

	^ self constraints maxWidth
]

{ #category : #'view - configuration' }
BlElement >> maxWidth: aNumber [

	self constraintsDo: [ :c | c maxWidth: aNumber ]
]

{ #category : #layout }
BlElement >> measure: anExtentMeasurementSpec [
	<return: #Point>

	self errorHandler
		with: self
		do: [ self measureSafely: anExtentMeasurementSpec ]
		failed: [ self measureThatFailed: anExtentMeasurementSpec ].

	^ self measuredExtent
]

{ #category : #'private - layout' }
BlElement >> measureSafely: anExtentMeasurementSpec [
	"Measure my extent based on extent specifications represented by anExtentMeasurementSpec.
	Subclasses should not override me, instead override onMeasure:
	for concrete implementation.
	anExtentMeasurementSpec must not be nil"

	"Fast exit if I or any of my children did not request layout update
	and my previous measurement specification equals to new one"
	(self isLayoutRequested not
		and: [ self privatePreviousMeasurementSpec = anExtentMeasurementSpec ])
			ifTrue: [ ^ self ].

	"we have to eat layout request first marking it as false in order
	to do a second or third layout pass if needed.
	It works as follows: if during measurement or layout an element
	requests a layout (because of event for example) #waitingLayout
	is put back to true and we will do another layout pass as result"
	flags clearWaitingLayout.

	"Store extent specification to be used for checking next time measure: is sent"
	self privatePreviousMeasurementSpec: anExtentMeasurementSpec.

	"Perform measuring algorithm"
	self onMeasure: anExtentMeasurementSpec
]

{ #category : #'private - layout' }
BlElement >> measureThatFailed: anExtentMeasurementSpec [
	
	flags clearWaitingLayout.
	self privatePreviousMeasurementSpec: anExtentMeasurementSpec
]

{ #category : #layout }
BlElement >> measuredBounds [
	"Return my measured bounds (`BlElementBounds`) where origin is
	my current position and extent is measured extent.
	See BlElement>>#measuredExtent for more information."
	
	^ measuredBounds
]

{ #category : #layout }
BlElement >> measuredExtent [
	"Return my measured extent (as a `Point`) used during layout by layout strategies.
	It is being computed during measuring step.
	See BlElement>>onMeasure:"
	
	^ self measuredBounds extent
]

{ #category : #layout }
BlElement >> measuredExtent: anExtentPoint [
	"Set newly measured extent (should respect #isBlocFiniteFloatPoint and #isBlocPositivePoint).
	@see `BlElement>>#measuredExtent` for more info
	anExtent must not be nil"
	
	self measuredBounds extent: anExtentPoint
]

{ #category : #layout }
BlElement >> measuredHeight [
	"Return my measured height.
	@see BlElement>>#measuredExtent for more info"
	<return: #Number>
	
	^ self measuredBounds height
]

{ #category : #layout }
BlElement >> measuredPosition [
	"Return my measured position (a Point) used during layout by layout strategies.
	It is being computed during measuring step.
	@see BlElement>>onMeasure:
	measuredPosition can not be nil"
	
	^ self measuredBounds position
]

{ #category : #layout }
BlElement >> measuredWidth [
	"Return my measured width.
	@see BlElement>>#measuredExtent for more info"
	<return: #Number>
	
	^ self measuredBounds width
]

{ #category : #'view - configuration' }
BlElement >> minHeight [

	"get minHeight in constraints"
	^ self constraints minHeight
]

{ #category : #'view - configuration' }
BlElement >> minHeight: aNumber [

	self constraintsDo: [ :c | c minHeight: aNumber ]
]

{ #category : #'view - configuration' }
BlElement >> minSize [

	"get maxSize in constraints"
	^ self minWidth @ self minHeight
]

{ #category : #'view - configuration' }
BlElement >> minSize: aPoint [

	self constraintsDo: [ :c |
		c minWidth: aPoint x.
		c minHeight: aPoint y ]
]

{ #category : #'view - configuration' }
BlElement >> minWidth [

	"get from constraints"
	^ self constraints minWidth
]

{ #category : #'view - configuration' }
BlElement >> minWidth: aNumber [

	self constraintsDo: [ :c | c minWidth: aNumber ]
]

{ #category : #accessing }
BlElement >> mouseCursor [
	^ visuals mouseCursor 
]

{ #category : #accessing }
BlElement >> mouseCursor: aCursor [

	visuals := visuals mouseCursor: aCursor
]

{ #category : #'api - painting' }
BlElement >> needsPaint [
	"Return true if I am marked as dirty and am waiting to be re-painted"

	^ flags hasNeedsPaint
]

{ #category : #'layout anchors' }
BlElement >> neutralAnchor: aNeutralValue [

	^ BlNeutralAnchor new
		  element: self;
		neutralValue: aNeutralValue;
		  yourself
]

{ #category : #initialization }
BlElement >> newEventDispatcher [

	^ self defaultEventDispatcherClass on: self
]

{ #category : #'event management accessing' }
BlElement >> nextEventTarget [
	"Return next event target that should be contained in dispatch chain.
	Bloc elements build a composition tree, so we want my parent plays a role of the next
	event target within a dispatch chain"
	<return: #TBlEventTarget>

	^ self parent
]

{ #category : #'children accessing' }
BlElement >> nextSiblingDo: aBlock [
	"Evaluate aBlock with the next child in my parent after me if there is one"
	^ self
		nextSiblingSuchThat: [ :eachSibling | true ]
		do: aBlock
]

{ #category : #'children accessing' }
BlElement >> nextSiblingSuchThat: aSelectionBlock do: aBlock [
	"Evaluate aBlock with the next child in my parent that satisfies aSelectionBlock after me if there is one"
	
	self hasParent
		ifFalse: [ ^ self ].
	
	"I am the last and have no next siblings"
	self parent children last == self
		ifTrue: [ ^ self ].
		
	(self parent childIndexOf: self) + 1 to: self parent childrenCount do: [ :eachIndex |
		| aSiblingChild |
		
		aSiblingChild := self parent childAt: eachIndex.
		(aSelectionBlock value: aSiblingChild)
			ifTrue: [ ^ aBlock value: aSiblingChild ] ]
]

{ #category : #'layout anchors' }
BlElement >> nilAnchor [

	^ BlNeutralAnchor new
		  element: self;
		  yourself
]

{ #category : #'geometry hooks' }
BlElement >> notifyExtentChanged [
	"Notify element event listeners that my extent changed.
	Custom event handlers should subscribe to BlElementExtentChangedEvent"

	self eventDispatcher dispatchExtentChanged
]

{ #category : #'geometry hooks' }
BlElement >> notifyPositionChanged [
	"Notify element event listeners that my position within a parent changed.
	Custom event handlers should subscribe to BlElementPositionChangedEvent"
	
	self eventDispatcher dispatchPositionChanged
]

{ #category : #'geometry hooks' }
BlElement >> notifyPositionInSpaceChanged [
	"Notify element event listeners that my position in space coordinates changed.
	Custom event handlers should subscribe to BlElementPositionInSpaceChangedEvent"
	
	self eventDispatcher dispatchPositionInSpaceChanged
]

{ #category : #'hooks - children' }
BlElement >> onAddedToParent [
	"I am sent after I am added to other element which is my direct parent now.
	You can access my parent by sending #parent to myself.
	Note: Always send onAddedToParent to super class if you override me!"
]

{ #category : #'hooks - children' }
BlElement >> onAddedToSceneGraph [
	"Sent after one of my parents or I was added to scene graph, e.g. root element.
	At this point #isAttachedToSceneGraph results in true.
	Note: Always send onAddedToSceneGraph to superclass if you override me!"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must already be attached to the scene graph' ].

	self eventDispatcher dispatchAddedToSceneGraph
]

{ #category : #'hooks - children' }
BlElement >> onChildAdded: anElement [
	"I am sent after anElement was added to me as my direct child.
	Note: Always send onChildAdded: to superclass if you override me!"
]

{ #category : #'hooks - children' }
BlElement >> onChildRemoved: anElement [
	"I am sent after anElement was ramoved from me and is no longer my direct child.
	Note: Always send onChildRemoved: to superclass if you override me!"
]

{ #category : #'children dispatching' }
BlElement >> onChildToBeRemoved: anElement [

	| aPreviousFocusOwner |
	(self isAttachedToSceneGraph and: [ self space hasFocus: anElement ])
		ifFalse: [ ^ self ].

	aPreviousFocusOwner := self space focusOwner.
	self requestFocusDueToRemoval: true.
	"we should make sure that the removed element that previously had focus keeps the focused flag in order to get focus back next time it is added to the scene"
	aPreviousFocusOwner focused: true
]

{ #category : #'hooks - geometry' }
BlElement >> onExtentChanged [
	"Is sent when my extent changed"

	"extent changed => invalidate cached local bounds"
	boundsCache invalidateLocalBounds.
	"extent changed => path also"
	self updateGeometry.
	"background might want to resize itself"
	self updateBackground.
	"clear path cache after updating geometry path"
	self geometry releaseCache.
	
	self updateTransformationBounds.

	self invalidate.
	self notifyExtentChanged
]

{ #category : #layout }
BlElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	"I am sent then and only then when my extent changed as the result of a layout"
	"By default let layout strategy do the layouting job.
	If needed override this method to do some additional actions.
	See `BlLayoutStrategy>>#layout: self in: aBounds` - override if custom layout strategy is needed"

	self layout layout: self in: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'hooks - layout' }
BlElement >> onLayoutDone [
	"Is sent after layout is completely computed.
	All layout changes done within this hook will be performed during the next frame.
	Note: I am sent before the drawing process"
	
	self eventDispatcher dispatchLayoutComputed
]

{ #category : #layout }
BlElement >> onMeasure: anExtentMeasurementSpec [
	"By default let layout strategy do the measuring job.
	If needed override this method to do some additional
	actions or just implement custom layout strategy"
	
	self layout measure: self with: anExtentMeasurementSpec
]

{ #category : #'hooks - geometry' }
BlElement >> onPositionChanged [
	"Is sent when my position changed within a parent"

	self notifyPositionChanged
]

{ #category : #'hooks - geometry' }
BlElement >> onPositionChangedFrom: aPreviousPosition to: aNewPosition [
	"Is sent when my position changed within a parent"
	
	self invalidateAfterRelocateFrom: aPreviousPosition to: aNewPosition.
	self onPositionChanged
]

{ #category : #'hooks - geometry' }
BlElement >> onPositionInSpaceChanged [
	"Is sent when my position in space changed because I or any of my parents moved.
	Override me to perform additional actions, always send #onPositionInSpaceChanged super.
	aSourceElement is an element that was originally moved within its local bounds"

	self notifyPositionInSpaceChanged
]

{ #category : #'hooks - children' }
BlElement >> onRemovedFromParent: aParentElement [
	"I am sent after I was removed from my parent.
	At this point sending #parent to myself will result in nil.
	Note: Always send onRemovedFromParent to super class if you override me!"
]

{ #category : #'hooks - children' }
BlElement >> onRemovedFromSceneGraph [
	"Sent after one of my parents or I was removed from scene graph, e.g. root element.
	At this point #isAttachedToSceneGraph results in false.
	Note: Always send onRemovedFromSceneGraph to super class if you override me!"

	spaceReference := BlNullSpaceReference uniqueInstance.
	self detachCompositionLayer.
	self layout onCleanUp: self
]

{ #category : #'hooks - session' }
BlElement >> onSessionChanged: aNewSession [
	"Is sent when a Session is changed, for example if the program is closed and re-opened.
	When this happens the external heap memory (FFI Objects) is no longer valid.
	If an element relies on an external memory it is a good place to trigger an update here"

	self childrenDo: [ :eachChild | eachChild onSessionChanged: aNewSession ]
]

{ #category : #'hooks - geometry' }
BlElement >> onTransformationChanged [
	"Is sent when my transformation changed"
	
	self eventDispatcher dispatchTransformationChanged.
	self onTransformationInSpaceChanged
]

{ #category : #'hooks - geometry' }
BlElement >> onTransformationInSpaceChanged [
	"Is sent when my transformation in space changed, it may be that my own transformation changed or of my parent"
	
	self eventDispatcher dispatchTransformationInSpaceChanged.
	self children do: [ :eachChild | eachChild onTransformationInSpaceChanged ]
]

{ #category : #accessing }
BlElement >> opacity [
	"Return my transparency degree.
	@see BlElement>>#opacity: for more information"
	<return: #Number>

	^ visuals opacity
]

{ #category : #accessing }
BlElement >> opacity: aNumber [
	"Set my opacity and request invalidation. Opacity is a visual property independent
	from visibility, which also influences layout and event handling. Transparent elements
	with opacity set to 0 still can receive and handle events.

	If you want to make element invisible and prevent it from handle events, change its
	visibility to ==element visibility: BlVisibility hidden==.
	
	Opacity is represented by a number within range [0...1] and should be a float.
	Note: a given number will be clamped to be within defined range,
	so if aNumber is -1 opacity will be 0 and the same way if opacity
	is requested to be 2 it will infact become 1.
	aNumber must not be nil"

	| aNewOpacity |
	aNewOpacity := (aNumber asFloat max: 0.0) min: 1.0.
	
	"If opacity is very close to zero, element actually should be completely
	transparent, and the other way around, if opacity is almost 1
	we can treat element as completely opaque.
	Implementation detail: #reduce has too high precision for our needs"
	(aNewOpacity closeTo: 0.0 epsilon: 0.001) ifTrue: [ aNewOpacity := 0.0 ].
	(aNewOpacity closeTo: 1.0 epsilon: 0.001) ifTrue: [ aNewOpacity := 1.0 ].
	
	visuals := visuals opacity: aNewOpacity.

	self invalidate
]

{ #category : #convenience }
BlElement >> openInNewSpace [
	"Add self to a new BlSpace and show it. Answer such space."
	
	| aSpace |
	aSpace := BlSpace new.
	aSpace root addChild: self.
	aSpace show.
	^ aSpace
]

{ #category : #convenience }
BlElement >> openInSpace [
	"Add self to a new BlSpace and show it. Answer such space."
	| sp |
	sp := self inSpace.
	sp show.
	^ sp

]

{ #category : #'geometry bounds' }
BlElement >> outsets [

	self
		deprecated: 'Use #margin instead of current one'
		transformWith: '`@receiver outsets' -> '`@receiver margin'.

	^ self margin
]

{ #category : #accessing }
BlElement >> outskirts [
	<return: #BlOutskirts>

	^ visuals outskirts
]

{ #category : #accessing }
BlElement >> outskirts: aBlOutskirts [
	"Change my outskirts - the way the border is interpreted.
	See BlOutskirts for more information"

	aBlOutskirts = self outskirts
		ifTrue: [ ^ self ].

	visuals := visuals outskirts: aBlOutskirts.
	self geometry releaseStrokedBoundsCache.
	self invalidate
]

{ #category : #'children accessing' }
BlElement >> owner [

	self
		deprecated: 'Use parent instead of current one'
		transformWith: '`@receiver owner' -> '`@receiver parent'.

	^ self parent
]

{ #category : #'api - layout' }
BlElement >> padding [
	"Return my current padding - a space inside of me around my content.
	Layouts that support padding may want to offset children such that they are within my bounds inset by padding"
	<return: #BlInsets>

	^ self constraints padding
]

{ #category : #'api - layout' }
BlElement >> padding: aBlInsets [

	self padding = aBlInsets
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c | c padding: aBlInsets ]
]

{ #category : #accessing }
BlElement >> parent [
	"Answer an element or nil (if there is no parent)"

	^ parent
]

{ #category : #accessing }
BlElement >> parent: anElement [
	parent := anElement
]

{ #category : #'geometry bounds convertion' }
BlElement >> parentBoundsToLocal: aBounds [
	"In-place transform bounds from my parent's coordinates to local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."

	self hasParent ifTrue: [ self parent localBoundsToChildren: aBounds ].

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aBounds translateBy: self position negated.

	"first apply inverted transformation if we have one"
	transformation inverseTransformBounds: aBounds.

	^ aBounds
]

{ #category : #'children accessing' }
BlElement >> parentDo: aBlock [
	"Evaluate a block with my direct parent as an argument 
	If I don't have a parent - does nothing"
	
	self hasParent ifFalse: [ ^ self ].
	^ aBlock value: self parent
]

{ #category : #'geometry position convertion' }
BlElement >> parentPointToLocal: aPoint [
	"Transform a given point from parent to my local coordinates"
	<return: #Point>
	| aLocalPoint |

	aLocalPoint := self hasParent
		ifTrue: [ self parent localPointToChildren: aPoint ]
		ifFalse: [ aPoint ].

	aLocalPoint := aLocalPoint translateBy: self position negated.
	aLocalPoint := self transformation inverseTransformPoint: aLocalPoint.
	^ aLocalPoint
]

{ #category : #'layout anchors' }
BlElement >> perimeterAnchor [

	^ BlElementPerimeterAnchor new
		  element: self;
		  yourself
]

{ #category : #'layout anchors' }
BlElement >> pointAnchor [ 

	^ BlElementPointAnchor new
		  element: self;
		  yourself
]

{ #category : #'geometry position' }
BlElement >> position [
	<return: #Point>

	^ self bounds position
]

{ #category : #'api - bounds' }
BlElement >> position: aPoint [
	"Request position change in parent coordinates that will happen on the next frame or next layout pass triggered by #forceLayout.

	Note: I do not invalidate drawing bounds nor change actual position.
	I only register an update request and ask my parent (if there is one) to recompute
	layout. Do nothing if previous #relocate request was performed with the same coordinates.
	Note: We can not guarantee that new element's position will be equal to requested one,
	since it depends on the applied layout.
	Raises `BlElementPositionChangedEvent` and `BlElementPositionInSpaceChangedEvent`
	aPoint must not be nil"

	self measuredBounds position = aPoint
		ifTrue: [ ^ self ].

	self constraints position: aPoint.
	self measuredBounds position: aPoint.
	self requestParentLayout
]

{ #category : #accessing }
BlElement >> position: aPosition extent: anExtent context: aBlElementBoundsUpdater [

	"I do the hard work of changing my position and extent.
	This action must be very optimized in the sense of invalidation.
	For example if element becomes smaller in both axis (horizontal and vertical)
	it is enough to invalidate damaged area only once within old bounds,
	the same applies to homogeneous growing: we invalidate once after applying changes.
	Note, I do not request layout update and do not send invalidate to myself if only
	position changes, instead I send invalidate with my effect bounds in parent coordinates
	to my parent. It allows developers to implement drawing cache"
	
	| isPositionChanged isExtentChanged aPreviousExtent aPreviousPosition |

	aPreviousPosition := self position.
	aPreviousExtent := self extent.
	isPositionChanged := (aPreviousPosition
		                      closeTo: aPosition
		                      epsilon: self class epsilon) not.
	isExtentChanged := (aPreviousExtent
		                    closeTo: anExtent
		                    epsilon: self class epsilon) not.

	(isPositionChanged or: [ isExtentChanged ]) ifFalse: [ ^ self ].
	
	isPositionChanged ifTrue: [
		self bounds position: aPosition.
		aBlElementBoundsUpdater
			changePositionFrom: aPreviousPosition
			to: aPosition
			of: self.
		isExtentChanged ifFalse: [ boundsCache invalidateParentBounds ] ].

	isExtentChanged ifFalse: [ ^ self ].
	self bounds extent: anExtent.
	aBlElementBoundsUpdater
		changeExtentFrom: aPreviousExtent
		to: anExtent
		of: self.
	boundsCache invalidateLocalBounds
]

{ #category : #'geometry position' }
BlElement >> positionInSpace [
	"Return my position in space coordinates.
	Note: If I don't have a parent I return position that was previously set by #relocate:"
	<return: #Point>

	^ self localPointToGlobal: 0@0
]

{ #category : #'event handling' }
BlElement >> preventChildrenMouseEvents [
	"Prevent my children from receiving mouse events"

	flags clearShouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> preventMeAndChildrenMouseEvents [
	"Prevent me and my children from receiving mouse events"

	flags clearShouldHandleMouseEvents.
	flags clearShouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> preventMouseEvents [
	"Prevent *me* from handling mouse events.
	It does not influence the ability of the children to handle events, hence I am a local property"
	
	flags clearShouldHandleMouseEvents.
]

{ #category : #'children accessing' }
BlElement >> previousSiblingDo: aBlock [
	"Evaluate aBlock with the previous child in my parent before me if there is one"

	^ self
		previousSiblingSuchThat: [ :eachSibling | true ]
		do: aBlock
]

{ #category : #'children accessing' }
BlElement >> previousSiblingSuchThat: aSelectionBlock do: aBlock [
	"Evaluate aBlock with the previous child in my parent that satisfies aSelectionBlock after me if there is one"
	
	self hasParent
		ifFalse: [ ^ self ].
	
	"I am the first and have no previous siblings"
	self parent children first == self
		ifTrue: [ ^ self ].
		
	(self parent childIndexOf: self) - 1 to: 1 by: -1 do: [ :eachIndex |
		| aSiblingChild |

		aSiblingChild := self parent childAt: eachIndex.
		(aSelectionBlock value: aSiblingChild)
			ifTrue: [ ^ aBlock value: aSiblingChild ] ]
]

{ #category : #printing }
BlElement >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' @ ';
		print: self identityHash.
		
	self elementId isNoId ifTrue: [ ^self ].

	aStream
		space;
		nextPut: $(;
		print: self id;
		nextPut: $)
]

{ #category : #'private - layout' }
BlElement >> privatePreviousMeasurementSpec [
	^ self userData
		at: #blocPreviousMeasurementSpec
		ifAbsent: [ nil ]
]

{ #category : #'private - layout' }
BlElement >> privatePreviousMeasurementSpec: anObject [
	self userData
		at: #blocPreviousMeasurementSpec
		put: anObject
]

{ #category : #'private - layout' }
BlElement >> privateRequestingLayout: aBoolean [
	aBoolean
		ifTrue: [ flags addWaitingLayout ]
		ifFalse: [
			"If hasWaitingLayout is false it means that measurement and layout passes began,
			true means that I still have to wait"
			flags hasWaitingLayout
				ifTrue: [ ^ self ] ].

	aBoolean
		ifTrue: [ flags addNeedsLayout ]
		ifFalse: [ flags clearNeedsLayout ]
]

{ #category : #'children add/remove' }
BlElement >> removeChild: anElement [
	"Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	self assert: [ anElement parent == self ].
	
	self onChildToBeRemoved: anElement.

	anElement parent: nil.
	self children remove: anElement.
	self dispatchChildRemoved: anElement.
	
	"First of all, we have to damage area occupied by removed element"
	self invalidate.

	"then we request layout update while element is not yet removed"
	self requestLayout.
]

{ #category : #'children add/remove' }
BlElement >> removeChild: anElement in: aContainerName [

	self
		childWithId: aContainerName
		ifFound: [ :aContainerElement | aContainerElement removeChild: anElement ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]
]

{ #category : #'children add/remove' }
BlElement >> removeChildAt: anIndex [
	"Remove my direct child at a specified index.
	Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anIndex must be within children array bounds"
	| anElement |
	self
		assert: [ anIndex between: 1 and: self children size ]
		description: [ 'anIndex must be within children array bounds' ].
	
	anElement := self children at: anIndex.
	
	self onChildToBeRemoved: anElement.
	anElement parent: nil.

	self children removeAt: anIndex.
	self dispatchChildRemoved: anElement.
	
	"First of all, we have to damage area occupied by removed element"
	self invalidate.
	"then we request layout update while element is not yet removed"
	self requestLayout
]

{ #category : #'children add/remove' }
BlElement >> removeChildWithId: aStringOrSymbol [

	self
		childWithId: aStringOrSymbol
		ifFound: [ :aContainerElement | aContainerElement removeFromParent ]
		ifNone: [ "do nothing, no need to raise an exception" ]
]

{ #category : #'children add/remove' }
BlElement >> removeChildren [
	| oldChildren |
	"Remove all my direct children, request layout update and redraw."
	
	"fast exit if I have no children"
	self hasChildren
		ifFalse: [ ^ self ].
	
	"first update element's parent to nil"
	oldChildren := self children.
	
	oldChildren do: [ :anElement | self onChildToBeRemoved: anElement ].
	oldChildren do: [ :anElement | anElement parent: nil ].

	"actually remove children"
	self resetChildrenArray.
	"send hook after elements have been removed"
	oldChildren do: [ :anElement | self dispatchChildRemoved: anElement ].
	
	"First of all, we have to damage area occupied by removed elements"
	self invalidate.
	
	"then we request layout update while elements are not yet removed"
	self requestLayout
]

{ #category : #'children add/remove' }
BlElement >> removeChildren: aListOfElements [
	"Remove all elements listed in aListOfElements from my direct children.
	All elements must be my direct children (i.e., anElement parent == self).
	Use `BlElement>>#removeChildren` if you want to remove all my children.
	See `BlElement>>#removeChild:` for more info
	aListOfElements must not be nil."
	
	aListOfElements do: [ :anElement | self onChildToBeRemoved: anElement ].
	aListOfElements do: [ :anElement | anElement parent: nil ].
	self children removeAll: aListOfElements.
	aListOfElements do: [ :anElement | self dispatchChildRemoved: anElement ].
	
	"First of all, we have to damage area occupied by removed elements"
	self invalidate.
	
	"then we request layout update while elements are not yet removed"
	self requestLayout
]

{ #category : #'children add/remove' }
BlElement >> removeChildrenIn: aContainerName [

	self
		childWithId: aContainerName
		ifFound: [ :aContainerElement | aContainerElement removeChildren ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]
]

{ #category : #'children add/remove' }
BlElement >> removeDetachedChild: anElement [
	"Finish the removal of a detached child. I will dispatch the remove event and notify the hierarchy changes.
	I am intended to be lightweight and make no assumptions about whether the parent or child should be redrawn.
	Proper use of me will include also making any appropriate #requestLayout or #changed message sends.
	I must not be used within removeChild: because I have completely different intent; I am used to balance temporary
	child detaching, while removeChild: is permanent."

	self onChildToBeRemoved: anElement.
	"send hook to the element that it was removed"
	self dispatchChildRemoved: anElement
]

{ #category : #'children add/remove' }
BlElement >> removeFromParent [
	"Remove me from parent if I have one"

	self hasParent
		ifFalse: [ ^ self ].

	self parent removeChild: self
]

{ #category : #'children add/remove' }
BlElement >> replaceChild: aChildElement with: anotherElement [
	"Replace a given child element with another element preserving the children order.
	Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	| aChildIndex |

	self assert: [ aChildElement isNotNil ].
	self assert: [ aChildElement parent == self ].
	self assert: [ anotherElement isNotNil ].
	
	aChildIndex := self childIndexOf: aChildElement.
	self removeChildAt: aChildIndex.
	
	aChildElement id
		ifNotNil: [ :aName | self addChild: anotherElement at: aChildIndex as: aName ]
		ifNil: [ self addChild: anotherElement at: aChildIndex ]
]

{ #category : #'children add/remove' }
BlElement >> replaceChild: aChildElement with: anotherElement as: aSymbol [
	"Replace a given child element with another element preserving the children order.
	Request layout and redraw an area occupied by aChildElement.
	As result aChildElement sends BlElementRemovedEvent.
	aChildElement must be my direct child."

	| aChildIndex |
	self assert: aChildElement parent == self.
	
	aChildIndex := self childIndexOf: aChildElement.
	self removeChildAt: aChildIndex.
	self addChild: anotherElement at: aChildIndex as: aSymbol
]

{ #category : #'focus requesting' }
BlElement >> requestFocus [
	"Request a focus for this element.
	If I am not added to the scene graph mark me as focused in order to re-try focus
	request as soon I am added to the scene graph"

	self requestFocusDueToRemoval: false
]

{ #category : #'focus requesting' }
BlElement >> requestFocus: aChildElement [
	"Propagate focus request up in the scene graph with an original
	element that requested focus"

	self requestFocus: aChildElement dueToRemoval: false
]

{ #category : #'focus requesting' }
BlElement >> requestFocus: aChildElement dueToRemoval: aBoolean [
	"Propagate focus request up in the scene graph with an original
	element that requested focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].

	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent requestFocus: aChildElement dueToRemoval: aBoolean ]
		ifFalse: [ self space requestFocusFor: aChildElement dueToRemoval: aBoolean ]
]

{ #category : #'focus requesting' }
BlElement >> requestFocusDueToRemoval: aBoolean [
	"Request a focus for this element.
	If I am not added to the scene graph mark me as focused in order to re-try focus
	request as soon I am added to the scene graph"

	self isFocused ifTrue: [ ^ self ].

	self isAttachedToSceneGraph
		ifTrue: [ self requestFocus: self dueToRemoval: aBoolean ]
		ifFalse: [ self focusHolder focused: true ]
]

{ #category : #layout }
BlElement >> requestLayout [
	"Request invalidation of layout on next space pulse
	@see #requestLayout: for more information"

	self requestLayout: self
]

{ #category : #layout }
BlElement >> requestLayout: aSourceElement [
	"Request invalidation of layout on next space pulse originally
	emitted by a given element.
	Note: there should be no ===self isLayoutRequested ifTrue: [ ^ self ]===
	check since there can be a case when I am requesting layout, but my parent
	still does not"

	flags hasShouldIgnoreLayoutRequests
		ifTrue: [ ^ self ].

	self privateRequestingLayout: true.

	(self ~~ aSourceElement and: [
		self isAttachedToSceneGraph and: [
			self privatePreviousMeasurementSpec notNil and: [
				self isLayoutBoundary and: [
					self hasParent and: [
						self parent isLayoutRequested not ] ] ] ] ])
		ifTrue: [
			self space requestLayout: self.
			^ self ].
	
	"checking for parent to be not nil is faster when inlined instead
	of using hasParent. It is critical because this method is being
	sent quite often and should be performant"
	self parent
		ifNotNil: [ :aParent | aParent requestLayout: aSourceElement ]
		"There is no parent, probably I am a root element, let's check Space"
		ifNil: [ self space
			"If my parent is nil, but I am added to space, we need to let it know that we requested a layout by asking for a next pulse"
			ifNotNil: [ :aSpace | aSpace requestNextPulse ] ]
]

{ #category : #layout }
BlElement >> requestParentLayout [
	"Request invalidation of my parent's (if I have one) layout on next space pulse"
	
	"do nothing if I don't have a parent"
	self hasParent
		ifFalse: [ ^ self ].
	
	self parent requestLayout
]

{ #category : #'geometry bounds' }
BlElement >> requestedHeight [
	" return the exact height. Use it only if you know what your are doing. 
	see BlElement>>requestedSize comment"

	^ self constraints requestedHeightIn: self
]

{ #category : #'geometry bounds' }
BlElement >> requestedSize [ 

	"Normally, one shoud wait for the layouting to measure myself exactly.
	But, in case my size (or my height or my width) is set with an #exact: send, it is possible
	to get the exact size|height|width. 
	So requestSize|height|width will works correctly only in this particular case.
	The behavior in others cases may be impredictable or may raise an error.
	"

	^ self constraints requestedSizeIn: self
]

{ #category : #'geometry bounds' }
BlElement >> requestedWidth [ 
	" return the exact width. Use it only if you know what your are doing. 
	see BlElement>>requestedSize comment"

	^ self constraints requestedWidthIn: self
]

{ #category : #initialization }
BlElement >> resetChildrenArray [
	children := Bloc preferableChildrenDataStructure new
]

{ #category : #'layout anchors' }
BlElement >> rightAnchor [

	^ BlElementRightAnchor new
		  element: self;
		  yourself
]

{ #category : #'api - children enumeration' }
BlElement >> selectChildrenWithId: aStringOrSymbol [

	| targetId |
	targetId := aStringOrSymbol.

	^ Array streamContents: [ :stream |
		  self allChildrenBreadthFirstDo: [ :aChild |
			  aChild id = targetId ifTrue: [ stream nextPut: aChild ] ] ]
]

{ #category : #'event handling' }
BlElement >> shouldChildrenHandleMouseEvents [
	"Return true if my children are allowed to handle mouse events.
	Preventing my children from handling mouse event does not stop me from handling them"
	<return: #Boolean>

	^ flags hasShouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> shouldHandleMouseEvents [
	"Return true if I am allowed to handle mouse events.
	Preventing me from handling mouse event does not stop my children from doing so"
	<return: #Boolean>

	^ flags hasShouldHandleMouseEvents
]

{ #category : #'api - opening' }
BlElement >> showSpace: aSpace [
	
	self deprecated: 'See https://github.com/pharo-graphics/Bloc/issues/698'.

	self hasParent
		ifTrue: [ self parent showSpace: aSpace ]
		ifFalse: [
			self isAttachedToSceneGraph
				ifTrue: [ self space showSpace: aSpace ]
				ifFalse: [ aSpace show ] ]
]

{ #category : #'children accessing' }
BlElement >> siblingsDo: aBlock [
	" Evaluate aBlock with all my siblings "

	self hasParent ifFalse: [ ^ self ].
	self parent childrenDo: [ :child |
		child ~= self ifTrue: [ aBlock value: child ] ]
]

{ #category : #'api - bounds' }
BlElement >> size [
	^ self extent
]

{ #category : #'api - bounds' }
BlElement >> size: aPoint [
	<event: #BlElementExtentChangedEvent>
	| aLayoutConstraints |

	aLayoutConstraints := self constraints.
	(aLayoutConstraints horizontal resizer isExact and: [ 
		aLayoutConstraints horizontal resizer size = aPoint x 
			and: [ aLayoutConstraints vertical resizer isExact
				and: [ aLayoutConstraints vertical resizer size = aPoint y ] ] ])
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c |
		c horizontal exact: aPoint x.
		c vertical exact: aPoint y ]
]

{ #category : #accessing }
BlElement >> space [
	"Return space to which I belong, or nil of I don't belong to any space.
	Direct reference boosts performance.
	Each element has a reference to the current space which is set on demand."
	
	self flag: #todo. "Don't return nil!"
	spaceReference spaceDo: [ :aSpace | ^ aSpace ].
	
	spaceReference isAttachedToSceneGraph
		ifFalse: [ ^ nil ].
	
	self parent ifNotNil: [ :eachParent |
		eachParent space ifNotNil: [ :aSpace |
			spaceReference := aSpace asReference ] ].
	
	spaceReference spaceDo: [ :aSpace | ^ aSpace ].
	^ nil
]

{ #category : #accessing }
BlElement >> space: aSpace [
	"**I am internal Bloc api, do not use me directly!**
	Set space to be accessed directly from my multiple methods.
	Update the space reference for my children.
	aSpace must not be nil."

	spaceReference := aSpace asReference.
	self childrenDo: [ :each | each space: aSpace ]
]

{ #category : #accessing }
BlElement >> spaceDo: aBlock [
	self space ifNotNil: aBlock
]

{ #category : #'text input' }
BlElement >> startTextInput [
]

{ #category : #'text input' }
BlElement >> startTextInputAtRectangle: aRectangle [
]

{ #category : #'text input' }
BlElement >> stopTextInput [
]

{ #category : #layout }
BlElement >> supportsBaseline [
	"Return true if I support baseline alignment"
	<return: #Boolean>

	^ false
]

{ #category : #'children add/remove' }
BlElement >> swapChild: aChildElement with: anotherChildElement [
	self
		swapChildAt: (self childIndexOf: aChildElement)
		with: (self childIndexOf: anotherChildElement)
]

{ #category : #'children add/remove' }
BlElement >> swapChildAt: aChildIndex with: anotherChildIndex [
	self children swapAt: aChildIndex with: anotherChildIndex.	
	self requestLayout
]

{ #category : #'api - tasks' }
BlElement >> taskQueue [
	<return: #BlTaskQueue>
	
	^ taskQueue
]

{ #category : #'layout anchors' }
BlElement >> topAnchor [

	^ BlElementTopAnchor new
		  element: self;
		  yourself
]

{ #category : #'layout anchors' }
BlElement >> topLeftAnchor [

	^ BlElementTopLeftAnchor new
		  element: self;
		  yourself
]

{ #category : #'children accessing' }
BlElement >> topMostParent [
	"Return a topmost parent in a scene graph.
	A topmost parent is an element that does not have a parent of its own"
	<return: #BlElement>

	^ self hasParent
		ifTrue: [ self parent topMostParent ]
		ifFalse: [ self ]
]

{ #category : #'children accessing' }
BlElement >> topMostParentSuchThat: aConditionBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	"Find the topmost parent in a scene graph that satisfies a given condition."
	| aTargetParent |
	
	aTargetParent := nil.
	
	self allParentsDo: [ :eachParent |
		(aConditionBlock value: eachParent)
			ifTrue: [ aTargetParent := eachParent ] ].
		
	^ aTargetParent
		ifNil: ifNoneBlock
		ifNotNil: ifFoundBlock
]

{ #category : #'layout anchors' }
BlElement >> topRightAnchor [

	^ BlElementTopRightAnchor new
		  element: self;
		  yourself
]

{ #category : #transformations }
BlElement >> transformation [
	"Return an object that represents a description of my transformation.
	It can either be a local transformation being a composition of affine transformations or
	and absolute transformation directly defined by a matrix"
	<return: #BlElementTransformation>

	^ transformation
]

{ #category : #transformations }
BlElement >> transformation: anElementTransformation [

	transformation :=
		anElementTransformation
			asCachedTransformationIn: self boundsInLocal.

	self constraints shouldAccountTransformation ifTrue: [ 
		self requestParentLayout ].

	self layout isInfluencedByTransformation ifTrue: [ 
		self requestLayout ].

	boundsCache invalidateParentBounds.
	self invalidate.

	self onTransformationChanged
]

{ #category : #'geometry bounds' }
BlElement >> transformedBounds [

	^ self transformedBounds: BlBounds new
]

{ #category : #'geometry bounds' }
BlElement >> transformedBounds: aBlBounds [

	^ transformation transformBounds: (self boundsInLocal: aBlBounds)
]

{ #category : #'change reporting' }
BlElement >> updateBackground [
	self background matchExtent: self extent
]

{ #category : #'change reporting' }
BlElement >> updateGeometry [
	self geometry matchElement: self
]

{ #category : #transformations }
BlElement >> updateTransformationBounds [

	"Update the bounds of the cached transformation in order to recompute its matrix
	since transformation origin depends on the element's bounds"

	transformation boundingRectangle: self boundsInLocal
]

{ #category : #accessing }
BlElement >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them."

	^ userData ifNil: [ userData := IdentityDictionary new ]
]

{ #category : #'layout anchors' }
BlElement >> verticalCenterAnchor [

	^ BlElementVerticalCenterAnchor new
		  element: self;
		  yourself
]

{ #category : #accessing }
BlElement >> visibility [
	<return: #BlVisibility>

	^ visuals visibility
]

{ #category : #accessing }
BlElement >> visibility: aVisibility [
	"Change the visibility of the element and request layout if needed"
	| shouldRequestLayout |

	aVisibility = self visibility
		ifTrue: [ ^ self ].

	"hidden and visible types of visibility do not remove
	an element from the layout process, therefore we should only request
	layout if visibility changes from or to gone"
	shouldRequestLayout := self visibility = BlVisibility gone
		or: [ aVisibility = BlVisibility gone ].

	visuals := visuals visibility: aVisibility.

	shouldRequestLayout
		ifTrue: [ self requestLayout ].

	"visibility does not change how *this* element is rendered,
	instead it affects the rendering of the parent"
	self hasParent
		ifTrue: [ self parent invalidate ]
]

{ #category : #'geometry bounds' }
BlElement >> visualBounds [
	"Visual bounds represent a high precision area of rendered geometry, including border.
	By default, visual bounds of `inside` outskits equal to geometry bounds since border
	is never rendered outside of the element's geometry."

	| bnds |
	bnds := BlBounds new.
	self computeVisualBoundsInto: bnds.
	^ bnds
]

{ #category : #'event handling' }
BlElement >> wantsMouseEventAt: aPoint [
	"Return true if I can be picked as target for mouse event at given location specified in space coordinates.
	By default elements can handle mouse events if they are visible and not transparent for mouse events"
	<return: #Boolean>

	^ self isVisible and: [ self containsGlobalPoint: aPoint ]
]

{ #category : #'api - compositing' }
BlElement >> wantsSeparateCompositingLayer [

	(self compositingMode wantsCompositionLayer or: [ 
		 self effect wantsCompositionLayer ]) ifFalse: [ ^ false ].

	self allParentsDo: [ :eachParent | 
		eachParent compositingMode wantsBufferedLayer ifTrue: [ ^ false ] ].

	^ true
]

{ #category : #'geometry hooks' }
BlElement >> whenLayoutedDo: aBlock [

	" Evaluate aBlock after each layouting. To use with care and check carefully if you need it.
	In particular, check that the evaluation of aBlock do not send requestLayout!  "

	self addEventHandler: (BlEventHandler
			 on: BlElementLayoutComputedEvent
			 do: [ :event | aBlock cull: event ])
]

{ #category : #'geometry hooks' }
BlElement >> whenLayoutedDoOnce: aBlock [
	"Evaluate block passed as argument after the layout applied.

	As an example of use, imagine you need to get the actual size of an element.
	The size is computed by the layout.
	Thus, if one need to get the size of an element one have to be sure that its layout applied."

	^ self
		addEventHandlerOn: BlElementLayoutComputedEvent
		doOnce: aBlock
]

{ #category : #'api - bounds' }
BlElement >> width [
	^ self extent x
]

{ #category : #'api - bounds' }
BlElement >> width: aNumber [
	<event: #BlElementExtentChangedEvent>
	| aLayoutConstraints |

	aLayoutConstraints := self constraints.
	(aLayoutConstraints horizontal resizer isExact and: [ 
		aLayoutConstraints horizontal resizer size = aNumber ])
		ifTrue: [ ^ self ].

	self constraintsDo: [ :c |
		c horizontal exact: aNumber ]
]

{ #category : #'layout anchors' }
BlElement >> widthAnchor [

	^ BlElementWidthAnchor new
		  element: self;
		  yourself
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenAt: aPoint [
	<return: #Collection of: #BlElement>

	^ Array streamContents: [ :aStream | self withAllChildrenAt: aPoint do: [ :eachElement | aStream nextPut: eachElement ] ]
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenAt: aPoint do: aBlock [
	"Evaluate a given Block with all elements under a given point provided
	in *my* local coordinates sorted in the order they are displayed (children reversed + elevation based).
	Return true if aBlock was evaluated, false otherwise"
	<return: #Boolean>
	| isPointInsideMe anyChildFound |

	isPointInsideMe := self containsPoint: aPoint.
	
	"if point is not inside of me and I clip children, it literally
	means that there neither me nor my children are visible at a given point"
	(isPointInsideMe not and: [ self clipChildren ])
		ifTrue: [ ^ false ].
	
	"a point is inside of me and I am a leaf element -> evaluate a block with me"
	(isPointInsideMe and: [ self hasChildren not ])
		ifTrue: [
			aBlock value: self.
			^ true ].

	anyChildFound := false.
	
	self children sortedByElevation reverseDo: [ :eachChildElement |
		| aPointInChildCoordinates |
		aPointInChildCoordinates := eachChildElement parentPointToLocal: aPoint.
		
		"(implementation detail) we do not wrap an or: statement in a block closure because we explicitly want to evaluate
		it no matter of the value of the boolean"
		anyChildFound := anyChildFound or: (eachChildElement withAllChildrenAt: aPointInChildCoordinates do: aBlock) ].
	
	"if a point is inside of me, evaluate a block regardless whether there was any child"
	isPointInsideMe
		ifTrue: [
			aBlock value: self.
			^ true ].
	
	^ anyChildFound
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenBreadthFirst [
	<return: #Collection of: #BlElement>
	
	^ Array streamContents: [ :aStream |
		aStream nextPut: self.
		self allChildrenBreadthFirstDo: [ :eachElement | aStream nextPut: eachElement ] ]
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenBreadthFirstDo: aBlock [ 
	aBlock value: self.
	self allChildrenBreadthFirstDo: aBlock
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenDepthFirstDo: aBlock [
	self childrenDo: [ :each | each allChildrenDepthFirstDo: aBlock ].
	self childrenDo: aBlock.
	aBlock value: self
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenDo: aBlock [
	"Evaluate aBlock with myself and each of my direct children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"

	aBlock value: self.
	self childrenDo: aBlock
]

{ #category : #'api - children enumeration' }
BlElement >> withAllLeafChildrenAt: aPoint [
	<return: #Collection of: #BlElement>

	^ Array streamContents: [ :aStream | self withAllLeafChildrenAt: aPoint do: [ :eachElement | aStream nextPut: eachElement ] ]
]

{ #category : #'api - children enumeration' }
BlElement >> withAllLeafChildrenAt: aPoint do: aBlock [
	"Evaluate a given Block with all leaf elements under a given point provided
	in *my* local coordinates sorted in the order they are displayed (children reversed + elevation based).
	Return true if aBlock was evaluated, false otherwise"
	<return: #Boolean>
	| isPointInsideMe anyChildFound |

	isPointInsideMe := self containsPoint: aPoint.
	
	"if point is not inside of me and I clip children, it literally
	mean that there neither me nor my children are visible at a given point"
	(isPointInsideMe not and: [ self clipChildren ])
		ifTrue: [ ^ false ].
	
	"a point is inside of me and I am a leaf element -> evaluate a block with me"
	(isPointInsideMe and: [ self hasChildren not ])
		ifTrue: [
			aBlock value: self.
			^ true ].
		
	anyChildFound := false.
	
	self children sortedByElevation reverseDo: [ :eachChildElement |
		| aPointInChildCoordinates |
		aPointInChildCoordinates := eachChildElement parentPointToLocal: aPoint.
		
		"(implementation detail) we do not wrap an or: statement in a block closure because we explicitly want to evaluate
		it no matter of the value of the boolean"
		anyChildFound := anyChildFound or: (eachChildElement withAllLeafChildrenAt: aPointInChildCoordinates do: aBlock) ].
	
	"if a point is inside of me but not in one of my children, then we treat me as a leaf"
	(isPointInsideMe and: [ anyChildFound not ])
		ifTrue: [
			aBlock value: self.
			^ true ].
	
	^ anyChildFound
]

{ #category : #'children accessing' }
BlElement >> withAllParents [
	"Return a collection of all parents including myself starting with me and ending with the top most parent"
	<return: #Array of: #BlElement>

	^ Array streamContents: [ :aStream | self withAllParentsDo: [ :eachParent | aStream nextPut: eachParent ] ]
]

{ #category : #'children accessing' }
BlElement >> withAllParentsDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	self withAllParentsDo: [ :aParent | 
		(aBlock value: aParent)
			ifTrue: [ ^ ifFoundBlock value: aParent ] ].
	^ ifNoneBlock value
]

{ #category : #'children accessing' }
BlElement >> withAllParentsDo: aBlock [
	"Evaluate a block with me and all my parents as an argument starting from me
	up to the top most parent"
	
	aBlock value: self.
	self allParentsDo: aBlock
]

{ #category : #'children testing' }
BlElement >> withAllParentsInclude: anElement [
	"Return true if I have a given element in my parent chain, or if I am anElement."

	^ anElement = self or: [ self allParentsInclude: anElement ]
]

{ #category : #'children accessing' }
BlElement >> withAllParentsReverseDo: aBlock [
	"Evaluate a block with me and all my parents as an argument starting from top most parent, up to me."
	
	self allParentsReverseDo: aBlock.
	aBlock value: self
]

{ #category : #'children accessing' }
BlElement >> withAllParentsUpTo: aParentElement detect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	"Evaluate a block with each of my parents as an argument starting from myself up to but excluding the given parent element
	and evaluate ifFoundBlock if for any any of the parents aBlock returned true"

	self withAllParentsDo: [ :eachParent | 
		eachParent == aParentElement
			ifTrue: [ ^ ifNoneBlock value ].
		(aBlock value: eachParent)
			ifTrue: [ ^ ifFoundBlock value: eachParent ] ].
	^ ifNoneBlock value
]

{ #category : #'children accessing' }
BlElement >> withAllParentsUpTo: aParentElement do: aBlock [
	"Evaluate a block with each of my parents as an argument starting from myself up to but excluding the given parent element"
	
	self withAllParentsDo: [ :eachParent |
		eachParent == aParentElement
			ifTrue: [ ^ self ].
		aBlock value: eachParent ]
]

{ #category : #converting }
BlElement >> writePngTo: aFileReference [
	"Draw me into a PNG at the specified location."

	BlHostRenderer preferableClass write: self asPngTo: aFileReference
]

{ #category : #accessing }
BlElement >> zIndex: aNumber [
	self elevation: (BlRelativeElevation elevation: aNumber)
]
