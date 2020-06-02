"
! Welcome to Bloc

I am the root class of all visual elements in Bloc and can be composed out of other elements that we will refer to as ==children==. 

!! Visual properties

Being a root class and a core element I let users to configure a few esential visual properties such as background, border, opacity, size and a few more. In this part we will go through each of them.

!!! Background

${class:BlBackground}$describes how an element should be filled, e.g. its background.
${class:BlBackgroundExamples}$ gives a detailed insight in the world of bloc backgrounds.

!!! Border

${class:BlBorder}$ is a visual property that defines how the outline of the element should be rendered. It also influences ==stroked bounds== of the element.
${class:BlBorderExamples}$ provides more detailed information about a border.

!!! Opacity

Opacity defines how transparent an element is. It does not influence event propagation.
${class:BlOpacityExamples}$ shows in details how opacity affects the element.

!! Composition

To be in-line with Bloc design we prefer composition over iheritance. Thus it is better to have tiny bloc elements with small and simple api and clear responsibilities that can later be composed into a more sophisticated graphical scene. In this paragraph we will learn the basic composition aspects and corresponding API.

The composition relation between parent and children is 1:N meaning that an element can have at most one parent. Therefore by design it is only possible to add an element to just one element. Trying to add an element that is already a child to some other element results in ${class:BlAlreadyAddedAsChildError}$ 

Bloc elements provide a set of methods to add and remove children.

!!! Adding children

There are four ways to add some given element as a direct child to another element.

The most commonly used way to add a child is to use ${method:BlElement>>#addChild:}$ which adds a given element as the last child in the collection of children.
[[[
| parent child |
parent := BlElement new size: 100@100; background: Color veryVeryLightGray.
child := BlElement new size: 50@50; background: Color red lighter.
parent addChild: child
]]]

Users may also choose to add an element as the first child, for that purpose Bloc provides ${method:BlElement>>#addChildFirst:}$.

!!Geometry and bounds

Every element is responsible for drawing itself. At the same time, every element has a ${class:BlGeometry}$ that defines the bounds and the clipping.

See ${class:BlGeometryVisualAndLayoutBoundsExamples}$ for concrete details.

!!Tutorial

You can learn Bloc following a memory game tutorial: ${icebergFile:path=feenkcom/Bloc/doc/tutorial-memory-game/00-memory-game.pillar}$.


"
Class {
	#name : #BlElement,
	#superclass : #Object,
	#traits : 'TBlTransformable + TBlEventTarget + TBlDebug',
	#classTraits : 'TBlTransformable classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'elevation',
		'geometry',
		'geometryResizer',
		'parent',
		'boundsCache',
		'eventDispatcher',
		'border',
		'background',
		'backgroundResizer',
		'constraints',
		'layout',
		'children',
		'effect',
		'visibility',
		'focusability',
		'space',
		'misc',
		'mouseCursor',
		'opacity',
		'outskirts',
		'bounds',
		'measuredBounds',
		'changes',
		'transformation',
		'shouldHandleMouseEvents',
		'shouldChildrenHandleMouseEvents',
		'taskQueue',
		'errorHandler',
		'needsPaint'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'api - animations' }
BlElement >> addAnimation: aBlBaseAnimation [

	aBlBaseAnimation target: self.
	self enqueueTask: aBlBaseAnimation
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement [
	"Add anElement as my last direct child and request layout update.
	anElement must not be a direct child of any other element!
	anElement must not be nil"

	self addChild: anElement at: self childrenCount + 1
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement as: aContainerName [
	"Add a given element to my children and make it a named container, so that
	we could add children in that container"
	
	self
		assert: [ (self children
			detect: [ :aChild |
				aChild userData
					at: #blocContainer
					ifPresent: [ :aName | aName = aContainerName ]
					ifAbsent: [ false ] ]
			ifFound: [ true ]
			ifNone: [ false ]) not ]
		description: [ 'Child named #', aContainerName asString, ' already exists' ].
	
	anElement userData at: #blocContainer put: aContainerName.
	self addChild: anElement
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement at: anIndex [
	"Add anElement at an index moving other children to the right.
	anElement must not be a direct child of any other element!
	anElement must not be nil
	anIndex must be greater or equal to 1 and less or equal than amount of existing children + 1"
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not add nil element' ].

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
	"mt managed children changed, request invalidation"
	self childrenChanged.	
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
				aChild userData
					at: #blocContainer
					ifPresent: [ :aName | aName = aContainerName ]
					ifAbsent: [ false ] ]
			ifFound: [ true ]
			ifNone: [ false ]) not ]
		description: [ 'Child named #', aContainerName asString, ' already exists' ].
	
	anElement userData at: #blocContainer put: aContainerName.
	self addChild: anElement at: anIndex
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement in: aContainerName [
	"Add a given element to a named container that must already exist"

	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement. ]
		ifNone: [ self error: 'Container named ', aContainerName asString, ' is not found!' ]
]

{ #category : #'children add/remove' }
BlElement >> addChild: anElement in: aContainerName as: aChildContainerName [
	"Add a given element to a named container that must already exist
	and mark the added child as container too"

	self
		childNamed: aContainerName
		ifFound: [ :aContainerElement | aContainerElement addChild: anElement as: aChildContainerName ]
		ifNone: [ self error: 'Container named #', aContainerName asString, ' does not exist' ]
]

{ #category : #'children add/remove' }
BlElement >> addChildFirst: anElement [
	"Add anElement as my first direct child and request layout update.
	anElement must not be a direct child of any other element!
	anElement must not be nil"

	self addChild: anElement at: 1
]

{ #category : #'children add/remove' }
BlElement >> addChildFirst: anElement as: aContainerName [
	"Add a given element as my first child and make it a named container, so that
	we could add children in that container"

	anElement userData at: #blocContainer put: aContainerName.
	self addChildFirst: anElement
]

{ #category : #'children add/remove' }
BlElement >> addChildren: aListOfElements [
	"Add elements from aListOfElements as my rearmost(last) direct children and
	request layout update.
	aListOfElements must not be nil.
	all elements from aListOfElements must not be added to any other element
	@see BlElement>>#addChild: for more documentation"
	self
		assert: [ aListOfElements isNotNil ]
		description: [ 'List of elements to add must not be nil' ].
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
	"finally requesting children changed"
	self childrenChanged.
	"We should request layout from newly added elements to mark them as dirty too"
	aListOfElements do: [ :anElement | anElement requestLayout ]
]

{ #category : #'children add/remove' }
BlElement >> addChildren: aListOfElements in: aContainerName [
	"Add given elements to a named container that must already exist"

	self
		childNamed: aContainerName
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
BlElement >> allChildrenBreadthFirstSelect: aBlock [ 
	| selectedChildren |
	selectedChildren := OrderedCollection new.
	self allChildrenBreadthFirstDo: [:each | 
		(aBlock value: each) ifTrue: [ selectedChildren add: each ] ].
	^ selectedChildren
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
	
	self hasParent ifFalse: [ ^ self ].
	self parent withAllParentsDo: aBlock
]

{ #category : #'event handling' }
BlElement >> allowChildrenMouseEvents [
	"Allow my children to receive mouse events"

	shouldChildrenHandleMouseEvents := true
]

{ #category : #'event handling' }
BlElement >> allowMeAndChildrenMouseEvents [
	"Allow me and my children to receive mouse events"

	shouldHandleMouseEvents := true.
	shouldChildrenHandleMouseEvents := true
]

{ #category : #'event handling' }
BlElement >> allowMouseEvents [
	"Allow *me* to handle mouse events.
	It does not influence the ability of the children to handle events, hence I am a local property"

	shouldHandleMouseEvents := true
]

{ #category : #layout }
BlElement >> applyLayoutIn: aBlBounds [
	self errorHandler
		with: self
		do: [ self applyLayoutSafelyIn: aBlBounds ]
		failed: [ self applyLayoutThatFailedIn: aBlBounds ]
]

{ #category : #'private - layout' }
BlElement >> applyLayoutSafelyIn: aRectangle [
	"Layout me and my children within aRectangle in my local coordinates.
	Note: aRectangle may be a temporary or mutable rectangle, so you must not
	store or refer it without making a copy!
	Note: subclasses should not override me, instead override onLayout: for concrete implementation.
	aRectangle must not be nil"
	| oldExtent newExtent newPosition extentChanged |

	oldExtent := self extent.
	newPosition := aRectangle origin.
	newExtent := aRectangle extent.
	extentChanged := newExtent ~= oldExtent.

	"Fast exit if I or any of my children did not request layout update
	and if my current bounds are the same as aRectangle"
	(self isLayoutRequested or: [ extentChanged or: [ newPosition ~= self position ] ])
		ifFalse: [ ^ self ].

	"! actually change my position and extent !"
	self position: newPosition extent: newExtent.

	"if my extent did not change and if I or any of my children did not request layout we do nothing"
	(extentChanged or: [ self isLayoutRequested ])
		ifTrue: [ self onLayout: aRectangle ].
		
	"we are done, mark that there are no layout requests pending"
	self layout requestingLayout: false
]

{ #category : #'private - layout' }
BlElement >> applyLayoutThatFailedIn: aRectangle [
	"Perform fallback safe action when layout computation failed"

	self position: aRectangle origin extent: aRectangle extent.
	"we are done, mark that there are no layout requests pending"
	self layout requestingLayout: false
]

{ #category : #converting }
BlElement >> asElement [
	^ self 
]

{ #category : #'*Bloc-Utilities - Pannable' }
BlElement >> asPannableElement [
	| pannable |
	self removeFromParent.
	pannable := BlPannableElement new.
	pannable contentElement: self.
	^ pannable
]

{ #category : #'*Bloc-Utilities - Pannable' }
BlElement >> asScalableElement [
	| aScalableElement |
	
	self removeFromParent.
	aScalableElement := BlScalableElement new.
	aScalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aScalableElement addChild: self.

	^ aScalableElement
]

{ #category : #'*Bloc-Utilities - Scrolling' }
BlElement >> asScrollableElement [
	| scrollable |
	self removeFromParent.
	scrollable := BlScrollableElement new.
	scrollable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollable addChild: self.
	^ scrollable
]

{ #category : #'children add/remove' }
BlElement >> attachChild: anElement [
	"Attaches previously detached element as my last direct child.
	@see #attachChild:at: for more info"

	self attachChild: anElement at: self childrenCount + 1
]

{ #category : #'children add/remove' }
BlElement >> attachChild: anElement at: anIndex [
	"Attaches an element making it my direct child. Attaching an element assigns me as the parent
	and puts an element in the list of children so that it can be retrieved by `children at:`.
   I am intended to be lightweight and make no assumptions about whether the parent or child should be redrawn.
	Proper use includes also making any appropriate #requestLayout or #changed message sends.
   I should only be used for elements which were detached from me as their previous parent.
	anElement must not be nil.
	anElement must not be my direct child.
	anIndex must be within my childrens' array"
	self assert: anElement isNotNil.
	self assert: anElement parent isNil.
	self assert: anIndex > 0.
	self assert: anIndex <= (self children size + 1).

	anElement parent: self.
	self children add: anElement at: anIndex
]

{ #category : #'api - look' }
BlElement >> background [
	"Return my current background.
	Background can not be nil"
	<return: #BlBackground>

	^ background
]

{ #category : #'api - look' }
BlElement >> background: aBlBackground [
	"Change my background to a given one.
	Color and Form can be used as background - they will be converted to an appropriate background object.
	It is also possible to create a more complicated composite background with the help of ==BlBackgroundBuilder==.

	aBlBackground must not be nil"
	<event: #BlElementBackgroundChangedEvent>
	| aNewBackground |

	self
		assert: [ aBlBackground isNotNil ]
		description: [ 'Background must not be nil' ].
		
	aNewBackground := aBlBackground asBlBackground.
	self background = aNewBackground
		ifTrue: [ ^ self ].

	background := aNewBackground.
	self updateBackground.
	self eventDispatcher dispatchBackgroundChanged.
	self invalidate
]

{ #category : #'private - accessing' }
BlElement >> backgroundResizer [
	<return: #BlBackgroundResizer>

	^ backgroundResizer
]

{ #category : #'private - accessing' }
BlElement >> backgroundResizer: aBackgroundResizer [
	 backgroundResizer := aBackgroundResizer
]

{ #category : #layout }
BlElement >> baselineOffset [
	"Return the offset of the element's text baseline from the element's top boundary.
	If I don't not support baseline alignment, BlElement>>#supportsBaseline return false"
	<return: #Number>

	^ 0
]

{ #category : #'api - look' }
BlElement >> border [
	<return: #BlBorder>

	^ border
]

{ #category : #'api - look' }
BlElement >> border: aBlBorder [
	"Change my border and invalidate me"
	<event: #BlElementBorderChangedEvent>

	self
		assert: [ aBlBorder isNotNil ]
		description: [ 'Background must not be nil' ].

	self border = aBlBorder
		ifTrue: [ ^ self ].

	border := aBlBorder.
	self geometry releaseStrokedBoundsCache.
	self eventDispatcher dispatchBorderChanged.
	self invalidate
]

{ #category : #'geometry bounds' }
BlElement >> bounds [
	<return: #BlElementBounds>

	^ bounds
]

{ #category : #'private - accessing' }
BlElement >> boundsCache [
	^ boundsCache
]

{ #category : #'geometry bounds' }
BlElement >> boundsInLocal [
	<return: #Rectangle>

	^ self bounds inLocal asRectangle
]

{ #category : #'geometry bounds' }
BlElement >> boundsInLocal: aBounds [
	"I load my local bounds in the given mutable bounds and return it.
	I do not rely on cache and always provide actual bounds.
	Local Bounds is nothing else than the bounds with origin point set to 0@0
	and with extent equal to my pure extent.
	Local Bounds property does not take effect or border into account.
	I am a part of internal api, use me with caution"
	<return: #BlBounds>

	^ self bounds boundsInLocal: aBounds
]

{ #category : #'geometry bounds' }
BlElement >> boundsInParent [
	self deprecated: 'Use `element bounds inParent` instead'.

	^ self bounds inParent asRectangle
]

{ #category : #'geometry bounds' }
BlElement >> boundsInParent: aBounds [
	<return: #BlBounds>
	
	self deprecated: 'Use `element bounds inParent` instead'.
	
	^ self localBoundsToParent: (self boundsInLocal: aBounds)
]

{ #category : #'geometry bounds' }
BlElement >> boundsInSpace [
	^ boundsCache boundsInSpace
]

{ #category : #'geometry bounds' }
BlElement >> boundsInSpace: aBounds [
	"I load my bounds in space in a given mutable rectangle and return provided one.
	I do not rely on cache and always provide actual bounds.
	I am a part of internal api, use me with caution"
	<return: #BlBounds>

	self boundsInLocal: aBounds.
	self localBoundsToGlobal: aBounds.
	^ aBounds
]

{ #category : #'geometry bounds' }
BlElement >> boundsInWindow [
	^ self isAttachedToSceneGraph
		ifTrue: [ boundsCache boundsInSpace scaleBy: self space windowScale ]
		ifFalse: [ boundsCache boundsInSpace ]
]

{ #category : #'geometry transform' }
BlElement >> centerRotateByDegrees: anAngle [ 
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		rotateBy: anAngle axis: BlVector zAxis;
		apply
]

{ #category : #'geometry transform' }
BlElement >> centerRotateByRadians: anAngle [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		rotateBy: anAngle radiansToDegrees axis: BlVector zAxis;
		apply
]

{ #category : #updating }
BlElement >> changed [
	self error: 'Never use me, instead invalidate only what is needed'
]

{ #category : #'private - accessing' }
BlElement >> changes [
	<return: #BlElementChanges>
	
	^ changes
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
BlElement >> childNamed: aChildName [
	<return: #BlElement>

	self
		childNamed: aChildName
		ifFound: [ :anElement | ^ anElement ]
		ifNone: [ self error: 'Children container named ', aChildName asString, ' does not exist' ]
]

{ #category : #'children accessing' }
BlElement >> childNamed: aContainerName ifFound: ifFoundBlock ifNone: ifNoneBlock [
	<return: #Object>

	self allChildrenBreadthFirstDo: [ :aChild |
		aChild userData
			at: #blocContainer
			ifPresent: [ :aName | (aName = aContainerName)
				ifTrue: [ ^ ifFoundBlock cull: aChild ] ] ].
	^ ifNoneBlock value
]

{ #category : #'children accessing' }
BlElement >> children [
	"Return an array of all my direct children.
	children can not be nil"
	<return: #BlChildrenCollection>

	^ children
]

{ #category : #'children dispatching' }
BlElement >> childrenChanged [
]

{ #category : #'children accessing' }
BlElement >> childrenCount [
	"Return amount of my direct children"
	<return: #Number>

	^ children size
]

{ #category : #'api - children enumeration' }
BlElement >> childrenDo: aBlockOrSymbol [
	"Evaluate aBlock with each of my direct children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"
	self
		assert: [ aBlockOrSymbol isNotNil ]
		description: [ 'Block must not be nil' ].
	
	self children do: aBlockOrSymbol
]

{ #category : #'api - look' }
BlElement >> clipChildren [
	^ misc clipChildren
]

{ #category : #'api - look' }
BlElement >> clipChildren: anObject [
	misc clipChildren: anObject
]

{ #category : #'change reporting' }
BlElement >> commitChanges [
	"Commit all accumulated element changes since previous commit"

	self changes commitOn: self.
	self childrenDo: [ :anElement | anElement commitChanges ]
]

{ #category : #'api - painting' }
BlElement >> compositionLayer [
	"Return my composition layer if I have one or nil otherwise"
	<return: #BlCompositionLayer or: nil>
	
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

{ #category : #'private - layout' }
BlElement >> computeLayout [
	"Private! Never use me outside of #forceLayout"
	| relayoutCounter maxRelayoutCount |

	relayoutCounter := 0.
	maxRelayoutCount := 100.
	[ self isLayoutRequested
		and: [ relayoutCounter < maxRelayoutCount ] ]
		whileTrue: [
			| widthSpec heightSpec maxExtent |
			
			maxExtent := self isAttachedToSceneGraph
				ifTrue: [ self space extent ]
				ifFalse: [ 800 @ 600 ].
			
			widthSpec := BlMeasurementSpec exact: maxExtent x.
			heightSpec := BlMeasurementSpec exact: maxExtent y.

			self measure: (BlExtentMeasurementSpec new
				widthSpec: (self layout
					measurementSpecFor: widthSpec
					usedSize:  0
					resizer: self constraints horizontal resizer);
				heightSpec: (self layout
					measurementSpecFor: heightSpec
					usedSize:  0
					resizer: self constraints vertical resizer)).
			
			"...then we layout in measured on previous step bounds"
			self applyLayoutIn: self measuredBounds asRectangle.
			
			self commitChanges.
			
			relayoutCounter := relayoutCounter + 1 ]
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
	
	self
		assert: [ aLayoutConstraints isNotNil]
		description: [ 'Constraints must not be nil' ].
		
	self
		assert: [ (aLayoutConstraints isKindOf: BlockClosure) not ]
		description: [ 'Did you mean constraintsDo: ? Constraints should be an object' ].

	constraints := aLayoutConstraints.
	self requestLayout
]

{ #category : #'api - layout' }
BlElement >> constraintsDo: aBlock [
	"Perform aBlock with my constraints as argument.
	Note: After evaluation I request a layout update!
	aBlock must not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	
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
	"Return true if a given point provided in local coordinates is inside of my geometry, false otherwise"
	<return: #Boolean>

	(self geometryBounds containsPoint: aPoint)
		ifFalse: [ ^ false ].

	^ self geometry containsPoint: aPoint in: self
]

{ #category : #copying }
BlElement >> copy [
	"Visual elements can not be copied.
	The reason for that is unpredictable amount of conflicting copying behaviours.
	For example, what should happen if a copied element is added to the parent?
	Should we create a new element without the parent or add a copied one to the parent of
	the original element? What should we do with View Models? How to deal with event handlers? ...
	
	Thus, we decided that the most consistent behaviour is to forbid all kind of copying
	and let users instantiate elements by themselves in the way they want it"

	self shouldNotImplement
]

{ #category : #accessing }
BlElement >> debug: aBoolean [
	"When set to true I will render various debug information
	on top of the element, default is false"
	
	misc debug: aBoolean.
	self invalidate
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
BlElement >> defaultBackgroundResizer [
	^ BlBackgroundResizer match
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
BlElement >> defaultFocusability [
	<return: #BlFocusability>

	^ BlFocusability before
]

{ #category : #initialization }
BlElement >> defaultGeometry [
	^ BlRectangle new
]

{ #category : #initialization }
BlElement >> defaultGeometryResizer [
	^ BlGeometryResizer match
]

{ #category : #initialization }
BlElement >> defaultLayout [
	^ BlBasicLayout new
]

{ #category : #initialization }
BlElement >> defaultOutskirts [
	^ BlOutskirts inside
]

{ #category : #initialization }
BlElement >> defaultTransformation [
	"Return an instance of BlTransformation that plays a role of my default transformation"
	<return: #BlElementTransformation>

	^ BlElementLocalTransformation new
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
	I must not be used within removeChild: because I have completely different intent; I meant to be temporary, while
	removeChild: is permanent.
	I don't clean focus in order to be able to preserve it in case child is attached back.
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement isNotNil.
	self assert: anElement parent == self.

	anElement parent: nil.
	self children remove: anElement
]

{ #category : #'api - painting' }
BlElement >> detachCompositionLayer [
	"Detach my composition layer if any"

	self compositionLayer
		ifNotNil: [ :aLayer |
			aLayer removeFromParent.
			self compositionLayer: nil ]
]

{ #category : #'children add/remove' }
BlElement >> detachFromParentWhile: aBlock [
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

{ #category : #'children dispatching' }
BlElement >> dispatchAddedToParent [
	"Sent after I was added to another element as direct child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onAddedToParent.
	self eventDispatcher dispatchAddedToParent.
	self dispatchAddedToSuperParent: self
]

{ #category : #'children dispatching' }
BlElement >> dispatchAddedToSceneGraph [
	"Sent after any of my parents or I was added to scene graph.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onAddedToSceneGraph.
	self eventDispatcher dispatchAddedToSceneGraph.
	self childrenDo: [ :anElement | anElement dispatchAddedToSceneGraph ]
]

{ #category : #'children dispatching' }
BlElement >> dispatchAddedToSuperParent: anElement [
	"Sent after I or one of my parents was added to another element as a child.
	I dispatch or fire all necessary events, clean internal caches and send a corresponding hooks"

	self onAddedToSuperParent: anElement.
	self eventDispatcher dispatchAddedToSuperParent: anElement.

	self childrenDo: [ :aChildElement | aChildElement dispatchAddedToSuperParent: anElement ]
]

{ #category : #'children dispatching' }
BlElement >> dispatchChildAdded: anElement [
	
	"First send hook to myself"
	self onChildAdded: anElement.
	"Let child dispatch necessary events and hooks"
	anElement dispatchAddedToParent.

	"If an only if I am attached to scene graph we let child know
	that it is a part of the scene graph now"
	self isAttachedToSceneGraph
		ifTrue: [ anElement dispatchAddedToSceneGraph ].
]

{ #category : #'children dispatching' }
BlElement >> dispatchChildRemoved: anElement [

	"First send hook to myself"
	self onChildRemoved: anElement.
	"Let child dispatch necessary events and hooks"
	anElement dispatchRemovedFromParent: self.
	
	"If an only if I am attached to scene graph we let child know
	that it is not a part of the scene graph anymore"
	self isAttachedToSceneGraph
		ifTrue: [ anElement dispatchRemovedFromSceneGraph ].
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
	"Compute the horizontal distance from my closest edge to a provided x coorinate of a point both given in my parent coordinates"
	<return: #Number>
	| aClampedCoordinate theBoundsInParent |
	
	theBoundsInParent := self bounds inParent.
	aClampedCoordinate := (aPoint x min: theBoundsInParent right) max: theBoundsInParent left.
	
	^ (aClampedCoordinate - aPoint x) abs
]

{ #category : #'geometry bounds' }
BlElement >> distanceToY: aPoint [
	"Compute the vertical distance from my closest edge to a provided y coorinate of a point both given in my parent coordinates"
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

	^ effect
]

{ #category : #accessing }
BlElement >> effect: anEffect [
	"Change my effect to a given one requesting draw area invalidations.
	anEffect must not be nil"
	
	self
		assert: [ anEffect isNotNil ]
		description: [ 'anEffect must not be nil' ].
	
	self flag: 'What should happen when we already have an effect?'.
	
	anEffect on: self.
	effect := anEffect.
	self invalidate
]

{ #category : #'geometry bounds' }
BlElement >> effectBounds [
	^ (self effectBounds: BlBounds new) asRectangle
]

{ #category : #'geometry bounds' }
BlElement >> effectBounds: aSpartaRectangle [
	^ self effect effectBounds: aSpartaRectangle
]

{ #category : #'api - look' }
BlElement >> elevation [
	<return: #BlElevation>

	^ elevation
]

{ #category : #'api - look' }
BlElement >> elevation: aBlElevation [
	elevation := aBlElevation
]

{ #category : #'api - tasks' }
BlElement >> enqueueTask: aBlTask [
	aBlTask onEnqueuedInElement: self.
	self isAttachedToSceneGraph
		ifTrue: [ self space enqueueTask: aBlTask ]
		ifFalse: [ self taskQueue enqueue: aBlTask ]
]

{ #category : #accessing }
BlElement >> errorHandler [
	<return: #BlErrorHandler>

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

{ #category : #'event handling' }
BlElement >> findMouseEventTargetAt: aPoint [
	"Return the deepest child element among all my children or myself that may be a target for mouse event at provided location.
	The coordinate point is given in space coordinates.
	I may return nil if no such child found and if I can not be event target either"
	<return: #BlElement or: nil>
	| doWantEvent |
	
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

	self children sortedByElevation reversed
		do: [ :eachChild |
			(eachChild findMouseEventTargetAt: aPoint)
				ifNotNil: [ :aTargetElement | ^ aTargetElement ] ].
	
	^ (doWantEvent and: [ self shouldHandleMouseEvents ])
		ifTrue: [ self ]
		ifFalse: [ nil ]
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

{ #category : #accessing }
BlElement >> focusability [
	<return: #BlFocusability>

	^ focusability
]

{ #category : #accessing }
BlElement >> focusability: aFocusability [
	focusability := aFocusability
]

{ #category : #'focus accessing' }
BlElement >> focusables: anOrderedCollection along: aBlFocusSearchDirection [
	"Add focusable elements that are descendants of this element (possibly including me) to anOrderedCollection
	depending on my focusability strategy"

	self focusability
		focusables: anOrderedCollection
		along: aBlFocusSearchDirection
		of: self
]

{ #category : #accessing }
BlElement >> focused [
	^ misc focused
]

{ #category : #accessing }
BlElement >> focused: aBoolean [
	misc focused: aBoolean
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
	<return: #BlBounds>
	
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

	self topMostParent == self
		ifTrue: [ self computeLayout ]
		ifFalse: [ self topMostParent computeLayout ]
]

{ #category : #'api - look' }
BlElement >> geometry [
	"Return my geometry used to clip/fill/stroke me and to clip my children during rendering.
	geometry can not be nil."
	<return: #BlGeometry>

	^ geometry
]

{ #category : #'api - look' }
BlElement >> geometry: aBlGeometry [
	
	"clean the cache of the old geometry"
	self geometry releaseCache.
	geometry := aBlGeometry.

	"clear path cache after updating geometry path"
	self geometry releaseCache.
	boundsCache invalidateBoundsInLocal.

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
BlElement >> geometryBounds: aBounds [
	"I load my geometry bounds in a given mutable rectangle and return provided one.
	By default it is nothing else than a rectangle with origin point set to
	geometry's position and with extent equal to my geometry's extent.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT
	I am a part of internal api, use me with caution"
	<return: #BlBounds>

	^ self geometry geometryBounds: aBounds
]

{ #category : #'geometry bounds' }
BlElement >> geometryBoundsInSpace [
	"Return bounds of my geometry in space coordinates.
	Note, that geometry bounds may differ from #boundsInSpace for the case of non-trivial geometry.
	Geometry bounds in space is used to find out if a mouse event position is within the element.
	GEOMETRY BOUNDS PROPERTY DOES NOT TAKE EFFECT OR BORDER OR BACKGROUND INTO ACCOUNT"
	<return: #Rectangle>

	^ boundsCache geometryBoundsInSpace
]

{ #category : #'geometry bounds' }
BlElement >> geometryBoundsInSpace: aSpartaRectangle [
	
	self geometryBounds: aSpartaRectangle.
	self localBoundsToGlobal: aSpartaRectangle.
	^ aSpartaRectangle
]

{ #category : #'private - accessing' }
BlElement >> geometryResizer [
	<return: #BlGeometryResizer>

	^ geometryResizer
]

{ #category : #'private - accessing' }
BlElement >> geometryResizer: aGeometryResizer [
	 geometryResizer := aGeometryResizer
]

{ #category : #'geometry bounds convertion' }
BlElement >> globalBoundsToLocal: aBounds [
	"In-place transform bounds from global space coordinates to local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	"Checking for very common mistake"
	aBounds isRectangle
		ifTrue: [ self error: 'Was given a Rectangle ', aBounds asString, ' while it should be Bounds' ].

	"First delegate transformation to my parent if I have one"
	self hasParent
		ifTrue: [ self parent globalBoundsToLocal: aBounds ].

	"and then transform provided bounds from parent coordinates to my local ones"
	self parentBoundsToLocal: aBounds.

	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> globalBoundsToMine: aBlBounds fromParent: aParentElement [
	"In-place transform provided bounds from coordinate system of a given parent
	to my local coordinates and return a result"
	<return: #BlBounds>
	| theParents |

	aParentElement == self
		ifTrue: [ ^ aBlBounds ].

	self
		assert: [ self hasParent: aParentElement ]
		description: [ 'A given element must be my parent (be in my children composition tree)' ].

	theParents := Array streamContents: [ :aStream |
		| eachParent |
		
		aStream nextPut: self.
		eachParent := self parent.
		[ eachParent == aParentElement ] whileFalse: [
			aStream nextPut: eachParent.
			eachParent := eachParent parent ] ].

	theParents reverseDo: [ :eachParent | eachParent parentBoundsToLocal: aBlBounds ].

	^ aBlBounds
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
	"Transform a given point from the coordinates of my root most parent to my parent's coordinates"
	<return: #Point>

	^ self hasParent
		ifTrue: [ self parent globalPointToLocal: aPoint ]
		ifFalse: [ aPoint ]
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

{ #category : #printing }
BlElement >> gtDisplayOn: aStream [
	^ aStream nextPutAll: misc label
]

{ #category : #'children testing' }
BlElement >> hasChild: anElement [
	<return: #Boolean>
	
	^ anElement parent == self
]

{ #category : #'children testing' }
BlElement >> hasChildren [
	"Return true if I have at least one direct child,
	false otherwise"
	<return: #Boolean>
	
	^ self children isEmpty not
]

{ #category : #'focus testing' }
BlElement >> hasFocus [
	"Return true if I have or contain a focused element, false otherwise"
	<return: #Boolean>

	^ self isFocused or: [
		self children anySatisfy: [ :anElement | anElement hasFocus ] ]
]

{ #category : #'focus testing' }
BlElement >> hasFocusable [
	"Returns true if I am focusable or if I contain a reachable child for which #hasFocusable returns true,
	false otherwise"
	<return: #Boolean>

	^ self isFocusable or: [
		self children anySatisfy: [ :anElement | anElement hasFocusable ] ]
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
	<return: #Boolean>

	^ self hasParent
]

{ #category : #'children testing' }
BlElement >> hasParent [
	"Return true if I have a parent, otherwise false.
	Being added as direct child to other element does not necessary
	mean that I am in the space scene graph"
	<return: #Boolean>

	^ self parent isNotNil
]

{ #category : #'children testing' }
BlElement >> hasParent: anElement [
	"Return true if I have a given element in my parent chain, false otherwise"
	<return: #Boolean>

	self allParentsDo: [ :aParentElement |
		aParentElement == anElement
			ifTrue: [ ^ true ] ].

	^ false
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

{ #category : #initialization }
BlElement >> initialize [
	super initialize.

	boundsCache := BlBoundsCache on: self.
	bounds := BlElementLocalBounds new referenceElement: self.
	measuredBounds := BlElementLocalBounds new referenceElement: self.
	changes := BlElementChanges new.

	eventDispatcher := BlElementEventDispatcher on: self.
	constraints := BlLayoutCommonConstraints new.
	self resetChildrenArray.

	transformation := self defaultTransformation owner: self.
	geometry := self defaultGeometry.
	geometryResizer := self defaultGeometryResizer.
	"we have to tell geometry to adapt to the element now, otherwise its size will not be updated"
	geometryResizer adapt: geometry to: self.
	
	outskirts := self defaultOutskirts.
	border := self defaultBorder.
	background := self defaultBackground asBlBackground.
	backgroundResizer := self defaultBackgroundResizer.
	layout := self defaultLayout.
	elevation := self defaultElevation.
	focusability := self defaultFocusability.
	visibility := self defaultVisibility.
	effect := BlNullEffect on: self.

	shouldHandleMouseEvents := true.
	shouldChildrenHandleMouseEvents := true.

	misc := BlMiscProperties new.
	misc label: self className.
	opacity := 1.0.
	
	taskQueue := BlTaskQueue new.
	errorHandler := self defaultErrorHandler.
	
	"set to true once layout is done"
	needsPaint := false
]

{ #category : #'geometry bounds' }
BlElement >> insets [
	^ self padding
]

{ #category : #'change reporting' }
BlElement >> invalidRect: aSpartaRectangle [
	"Invalidate a dirty rectangle of the display.
	aSpartaRectangle must be given in my own coordinates"

	self invalidRect: aSpartaRectangle from: self
]

{ #category : #'change reporting' }
BlElement >> invalidRect: aBlBounds from: anElement [
	"Translate dirty reports from an Element.
	A rectangle is given in my own coordinates"

	"we are guarding owerselves from unnecessary computations of rectangle transformation"
	self isAttachedToSceneGraph
		ifFalse: [ ^ self ].

	"transform provided rectangle to my parent's coordinates before I pass it further"
	self localBoundsToParent: aBlBounds.
	self hasParent
		ifTrue: [ self parent invalidRect: aBlBounds from: anElement ]
		ifFalse: [ self space invalidRect: aBlBounds from: anElement ]
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
BlElement >> invalidateAfterRelocate: anOffset [
	"Invalidate due to relocation by a given offset"

	self wantsCompositionLayer
		ifTrue: [ self compositionLayer
				ifNil: [ self hasParent
						ifTrue: [ self parent invalidate ] ]
				ifNotNil: [ :aLayer |
					aLayer offset: aLayer offset + anOffset.
					self isAttachedToSceneGraph
						ifTrue: [ self space markNeedsCompositionPaint: self from: self ]  ] ]
		ifFalse: [ self hasParent
				ifTrue: [ self parent invalidate ] ]
]

{ #category : #'change reporting' }
BlElement >> invalidationBounds [
	<return: #Rectangle>

	^ boundsCache invalidationBounds
]

{ #category : #'geometry bounds' }
BlElement >> invalidationBounds: aBounds [
	"I compute and load damaged area in my local coordinates that would be invalidated
	if #invalidate would be sent to me"
	<return: #BlBounds>
	| anInvalidationBounds |

	anInvalidationBounds := (self effectBounds: aBounds) merge: self boundsInLocal.
	
	"in order to support debug drawing"
	misc debug ifTrue: [ anInvalidationBounds expandBy: 1 ].

	self clipChildren ifFalse: [ 
		| aChildBounds |
		aChildBounds := BlBounds new.
		self children do: [ :anElement |
			anElement invalidationBounds: aChildBounds.
			anElement localBoundsToParent: aChildBounds.
			anInvalidationBounds merge: aChildBounds ] ].

	^ anInvalidationBounds
]

{ #category : #'children testing' }
BlElement >> isAttachedToSceneGraph [
	"Return true if I am inside of a scene graph, e.g. I have a space's root element
	as my top-most parent, false otherwise"
	<return: #Boolean>

	"To support temporary detachment/attachment which sets parent to nil but
	preserves reference to space we can not recursively go up in parent's hierarchy
	and have to check space reference existence instead"
	^ self space isNotNil
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

{ #category : #'focus testing' }
BlElement >> isFocused [
	"Returns true if I have focus, false otherwise"
	<return: #Boolean>

	^ self focused
]

{ #category : #layout }
BlElement >> isLayoutRequested [
	"Indicates whether or not this elements's layout will be requested during the next hierarchy layout pass.
	Return true if the layout will be forced during next layout pass, false otherwise"
	<return: #Boolean>

	^ self layout requestingLayout
]

{ #category : #layout }
BlElement >> isManaged [
	self 
		deprecated: 'Use "constraints ignoredByLayout not" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self constraints ignoredByLayout not
]

{ #category : #testing }
BlElement >> isOpaque [
	"Return true if I am completely opaque (my opacity is 1)"
	<return: #Boolean>

	^ self opacity = 1.0
]

{ #category : #testing }
BlElement >> isRoot [
	"Return true if I am a root element of a space, false otherwise"
	<return: #Boolean>

	^ self isAttachedToSceneGraph and: [ self space root = self ]
]

{ #category : #testing }
BlElement >> isTranslucent [
	"Return true if I am semi-transparent (opacity is 0 < opacity < 1)"
	<return: #Boolean>

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
	just influence rendering and not behaviour or interraction.
	If element is invisible it does not receive events such as mouse clicks"
	<return: #Boolean>

	^ self visibility isVisible
]

{ #category : #testing }
BlElement >> isVisibleInSpace [
	"Return true if I am in a visible area of a space (window), false otherwise.
	Note, that this visibility is computed only based on bounds. 
	It may happend that I am not visible because of another element."
	<return: #Boolean>

	^ self isAttachedToSceneGraph and: [ 
		self isVisible and: [
			self bounds inSpace bounds intersects: (0@0 extent: self space extent) ] ].
]

{ #category : #accessing }
BlElement >> labeled: aString [
	misc label: aString
]

{ #category : #'api - layout' }
BlElement >> layout [
	<return: #BlLayout>

	^ layout
]

{ #category : #'api - layout' }
BlElement >> layout: aBlLayout [
	"Change my current layout to a given one.
	After the layout change I request the layout recomputation.
	aBlLayout must not be nil"
	<event: #BlElementLayoutChangedEvent>

	self
		assert: [ aBlLayout isNotNil ]
		description: [ 'Layout must not be nil' ].

	layout := aBlLayout.

	self eventDispatcher dispatchLayoutChanged.
	self requestLayout
]

{ #category : #'api - layout' }
BlElement >> layoutDo: aBlock [
	"Perform aBlock with my layout as argument.
	Nite: After evaluation I request a layout update.
	aBlock must not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.

	aBlock value: self layout.
	self requestLayout
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToGlobal: aBounds [
	"In-place transform bounds from local coordinates to global space coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>
	
	"Checking for very common mistake"
	aBounds isRectangle
		ifTrue: [ self error: 'Was given a Rectangle ', aBounds asString, ' while it should be Bounds' ].

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToParent: aBounds.

	"and then delegate transformation to my parent if I have one"
	self hasParent
		ifTrue: [ self parent localBoundsToGlobal: aBounds ].

	^ aBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToMine: aBlBounds fromChild: anElement [
	"In-place transform provided bounds from coordinate system of a given descendant element
	to my local coordinates and return a result"
	<return: #BlBounds>
	| aParentElement |
	
	self
		assert: [ aBlBounds isKindOf: BlBounds ]
		description: [ 'Bounds should be {1} but was {2}' format: { BlBounds . aBlBounds class } ].
	
	anElement == self
		ifTrue: [ ^ aBlBounds ].
		
	self
		assert: [ anElement hasParent: self ]
		description: [ 'A child element must be my descentant (be in my children composition tree)' ].
	
	aParentElement := anElement.
	
	[
		aParentElement localBoundsToParent: aBlBounds.
		aParentElement := aParentElement parent
	] doWhileFalse: [ aParentElement == self ].
			
	^ aBlBounds
]

{ #category : #'geometry bounds convertion' }
BlElement >> localBoundsToParent: aBounds [
	"In-place transform bounds from local coordinates to my parent's coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	"first apply transformation if we have one"
	transformation transformBounds: aBounds.

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
	<return: #BlBounds>
	
	"Checking for very common mistake"
	aBounds isRectangle
		ifTrue: [ self error: 'Was given a Rectangle ', aBounds asString, ' while it should be BlBounds' ].

	"First we need to transform provided bounds from my local coordinates to parent ones"
	self localBoundsToGlobal: aBounds.

	"and then delegate transformation to my parent if I have one"
	self isAttachedToSceneGraph
		ifTrue: [ aBounds scaleBy: self space windowScale ].

	^ aBounds
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

{ #category : #'geometry position convertion' }
BlElement >> localPointToParent: aPoint [
	"Transforma a given point from my local coordinates to local coordinates of my parent.
	Since this transfortmation does not actually involve my parent, it can be performed
	regardless of if I have one"
	<return: #Point>
	| pt |
	"first we should apply my transformation, since it is the only factor
	effecting local nature of a coordinate"
	pt := self transformation transformPoint: aPoint.
	"next we should translate it to be within my parent's local coordinates"
	^ pt translateBy: self position
]

{ #category : #'focus requesting' }
BlElement >> looseFocus [
	self isAttachedToSceneGraph
		ifTrue: [ self looseFocus: self ]
		ifFalse: [ self focused: false ]
]

{ #category : #'focus requesting' }
BlElement >> looseFocus: aChildElement [
	"Propagate focus loose up in the scene graph with an original
	element that looses focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].
		
	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent looseFocus: aChildElement ]
		ifFalse: [ self space looseFocusFor: aChildElement ]
]

{ #category : #accessing }
BlElement >> managed [
	self 
		deprecated: 'Use "constraints ignoredByLayout not" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
	
	^ self isManaged
]

{ #category : #accessing }
BlElement >> managed: aBoolean [
	"If false is provided, then the element is not subject to the parent's layout"
	self 
		deprecated: 'Use "constraintsDo: [ :c | c ignoreByLayout ]" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.

	self constraintsDo: [ :c |
		aBoolean
			ifTrue: [ c accountByLayout ]
			ifFalse: [ c ignoreByLayout ] ]
]

{ #category : #'children accessing' }
BlElement >> managedChildren [
	"Return an array of all my direct managed children.
	Managed children are taken into account during layout process.
	children can not be nil"
	<return: #Array>
	self 
		deprecated: 'Use "children accountedByLayout" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self children accountedByLayout
]

{ #category : #'children accessing' }
BlElement >> managedChildrenDo: aBlock [
   "Evaluate aBlock with each of my direct managed children as argument.
	aBlock can not be nil.
	aBlock must accept exactly one argument"
	self assert: aBlock isNotNil.
	self assert: aBlock argumentCount = 1.
	self 
		deprecated: 'Use "children accountedByLayout do:" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self children accountedByLayout do: aBlock
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
	self
		assert: [ aBlInsets isNotNil ]
		description: [ 'Margin must not be nil' ].

	self constraintsDo: [ :c | c margin: aBlInsets ]
]

{ #category : #'api - painting' }
BlElement >> markNeedsPaintFrom: anElement [
	"Make me as dirty and request renderer to re-paint me.
	anElement is the element from which the re-painting request originates"
	needsPaint := true.
	
	self wantsCompositionLayer
		ifTrue: [
			self isAttachedToSceneGraph
				ifTrue: [ self space markNeedsPaint: self from: anElement ] ]
		ifFalse: [ 
			self hasParent
				ifTrue: [ self parent markNeedsPaintFrom: anElement ]
				ifFalse: [
					self isAttachedToSceneGraph
						ifTrue: [ self space markNeedsPaint: self from: anElement ] ] ]
]

{ #category : #'layout constraints' }
BlElement >> maxExtent [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	^ self maxWidth @ self maxHeight
]

{ #category : #'layout constraints' }
BlElement >> maxExtent: aPoint [
	self 
		deprecated: 'Use #constraintsDo: instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	self  maxWidth: aPoint x.
	self  maxHeight: aPoint y
]

{ #category : #'layout constraints' }
BlElement >> maxHeight [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	^ self constraints maxHeight
]

{ #category : #'layout constraints' }
BlElement >> maxHeight: aNumber [
	self 
		deprecated: 'Use #constraintsDo: instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	self constraints maxHeight: aNumber
]

{ #category : #'layout constraints' }
BlElement >> maxWidth [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	^ self constraints maxWidth
]

{ #category : #'layout constraints' }
BlElement >> maxWidth: aNumber [
	
	self 
		deprecated: 'Use #constraintsDo: instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self constraints maxWidth: aNumber
]

{ #category : #layout }
BlElement >> measure: anExtentMeasurementSpec [
	self errorHandler
		with: self
		do: [ self measureSafely: anExtentMeasurementSpec ]
		failed: [ self measureThatFailed: anExtentMeasurementSpec ]
]

{ #category : #'private - layout' }
BlElement >> measureSafely: anExtentMeasurementSpec [
	"Measure my extent based on extent specifications represented by anExtentMeasurementSpec.
	Subclasses should not override me, instead override onMeasure:
	for concrete implementation.
	anExtentMeasurementSpec must not be nil"
	self
		assert: [ anExtentMeasurementSpec isNotNil ]
		description: [ 'Extent spec must not be nil' ].
	
	"Fast exit if I or any of my children did not request layout update
	and my previous measurement specification equals to new one"
	(self isLayoutRequested not
		and: [ self layout previousMeasurementSpec = anExtentMeasurementSpec ])
		ifTrue: [ ^ self ].

	"we have to eat layout request first marking it as false in order
	to do a second or third layout pass if needed.
	It works as follows: if during measurement or layout an element
	requests a layout (because of event for example) #waitingLayout
	is put back to true and we will do another layout pass as result"
	self layout waitingLayout: false.

	"Store extent specification to be used for checking next time measure: is sent"
	self layout previousMeasurementSpec: anExtentMeasurementSpec.

	"Perform measuring algorithm"
	self onMeasure: anExtentMeasurementSpec.
	
]

{ #category : #'private - layout' }
BlElement >> measureThatFailed: anExtentMeasurementSpec [
	
	self layout
		waitingLayout: false;
		previousMeasurementSpec: anExtentMeasurementSpec
]

{ #category : #layout }
BlElement >> measuredBounds [
	"Return my measured bounds where origin is my current position
	and extent is measured extent.
	@see BlElement>>#measuredExtent for more info"
	<return: #BlElementBounds>
	
	^ measuredBounds
]

{ #category : #layout }
BlElement >> measuredExtent [
	"Return my measured extent used during layout by layout strategies.
	It is being computed during measuring step.
	@see BlElement>>onMeasure:
	measuredExtent can not be nil"
	<return: #Point>
	
	^ self measuredBounds extent
]

{ #category : #layout }
BlElement >> measuredExtent: anExtent [
	"Set newly measured extent.
	@see BlElement>>#measuredExtent for more info
	anExtent must not be nil"
	self
		assert: [ anExtent isNotNil ]
		description: [ 'Measured extent must not be nil' ].
	
	self measuredBounds extent: anExtent
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
	"Return my measured position used during layout by layout strategies.
	It is being computed during measuring step.
	@see BlElement>>onMeasure:
	measuredPosition can not be nil"
	<return: #Point>
	
	^ self measuredBounds position
]

{ #category : #layout }
BlElement >> measuredWidth [
	"Return my measured width.
	@see BlElement>>#measuredExtent for more info"
	<return: #Number>
	
	^ self measuredBounds width
]

{ #category : #'layout constraints' }
BlElement >> minExtent [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	^ self minWidth @ self minHeight
]

{ #category : #'layout constraints' }
BlElement >> minExtent: aPoint [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	self  minWidth: aPoint x.
	self  minHeight: aPoint y
]

{ #category : #'layout constraints' }
BlElement >> minHeight [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	^ self constraints minHeight
]

{ #category : #'layout constraints' }
BlElement >> minHeight: aNumber [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	 self constraints minHeight:  aNumber
]

{ #category : #'layout constraints' }
BlElement >> minWidth [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	^  self constraints minWidth
]

{ #category : #'layout constraints' }
BlElement >> minWidth: aNumber [
	self 
		deprecated: 'Use #constraints instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
		
	self constraints minWidth: aNumber
]

{ #category : #accessing }
BlElement >> mouseCursor [
	^ mouseCursor 
]

{ #category : #accessing }
BlElement >> mouseCursor: aCursor [
	mouseCursor := aCursor
]

{ #category : #'api - painting' }
BlElement >> needsPaint [
	"Return true if I am marked as dirty and am wating to be re-painted"
	<return: #Boolean>

	^ needsPaint
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
	Note: Always send onAddedToSceneGraph to super class if you override me!"
	
	self isFocused
		ifTrue: [ self requestFocus ].
		
	self space enqueueTasksFrom: self taskQueue
]

{ #category : #'hooks - children' }
BlElement >> onAddedToSuperParent: aParentElement [
	"I am sent after I or any of my parents is added to other element as a child.
	You can access my parent by sending #parent to myself.
	Note: Always send onAddedToSuperParent: to super class if you override me!"
]

{ #category : #'hooks - children' }
BlElement >> onChildAdded: anElement [
	"I am sent after anElement was added to me as my direct child.
	Note: Always send onChildAdded: to super class if you override me!"
]

{ #category : #'hooks - children' }
BlElement >> onChildRemoved: anElement [
	"I am sent after anElement was ramoved from me and is no longer my direct child.
	Note: Always send onChildRemoved: to super class if you override me!"
]

{ #category : #'hooks - geometry' }
BlElement >> onExtentChanged [
	"Is sent when my extent changed"

	"extent changed => invalidate cached local bounds"
	boundsCache invalidateBoundsInLocal.
	"extent changed => path also"
	self updateGeometry.
	"background might want to resize itself"
	self updateBackground.
	"clear path cache after updating geometry path"
	self geometry releaseCache.
	
	self transformation invalidateMatrix.

	self invalidate.
	self notifyExtentChanged
]

{ #category : #layout }
BlElement >> onLayout: aBounds [
	"I am sent then and only then when my extent changed as the result of a layout"
	"By default let layout strategy do the layouting job.
	If needed override this method to do some additional actions.
	@see BlLayoutStrategy>>#layout: self in: aBounds - override if
	custom layout strategy is needed"
	
	self layout layout: self in: aBounds
]

{ #category : #'hooks - layout' }
BlElement >> onLayoutDone [
	"Is sent after layout is completely computed.
	All layout changes done within this hook will be performed during the next frame.
	Note: I am sent before the drawing process"
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
	
	self invalidateAfterRelocate: aNewPosition - aPreviousPosition.
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

	space := nil.
	self detachCompositionLayer
]

{ #category : #'hooks - geometry' }
BlElement >> onTransformationChanged [
	"Is sent when my transformation changed"
	
	self onTransformationInSpaceChanged
]

{ #category : #'hooks - geometry' }
BlElement >> onTransformationInSpaceChanged [
	"Is sent when my transformation in space changed, it may be that my own transformation changed or of my parent"
	
	self children do: [ :eachChild | eachChild onTransformationInSpaceChanged ]
]

{ #category : #accessing }
BlElement >> opacity [
	"Return my transparency degree.
	@see BlElement>>#opacity: for more information"
	<return: #Number>

	^ opacity
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

	self
		assert: [ aNumber isNotNil ]
		description: [ 'Opacity can not be nil' ].

	opacity := (aNumber asFloat max: 0.0) min: 1.0.
	
	"If opacity is very close to zero, element actually should be completely
	transparent, and the other way around, if opacity is almost 1
	we can treat element as completely opaque.
	Implementation detail: #reduce has too high precision for our needs"
	(opacity closeTo: 0.0 epsilon: 0.001) ifTrue: [ opacity := 0.0 ].
	(opacity closeTo: 1.0 epsilon: 0.001) ifTrue: [ opacity := 1.0 ].

	self invalidate
]

{ #category : #'geometry bounds' }
BlElement >> outsets [
	^ self margin
]

{ #category : #accessing }
BlElement >> outskirts [
	<return: #BlOutskirts>

	^ outskirts
]

{ #category : #accessing }
BlElement >> outskirts: aBlOutskirts [
	"Change my outskirts - the way the border is interpreted.
	See BlOutskirts for more information"
	
	self
		assert: [ aBlOutskirts isNotNil ]
		description: [ 'Outskirts must not be nil' ].

	aBlOutskirts = self outskirts
		ifTrue: [ ^ self ].

	outskirts := aBlOutskirts.
	self geometry releaseStrokedBoundsCache.
	self invalidate
]

{ #category : #'children accessing' }
BlElement >> owner [
	<return: #BlElement>

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
	self
		assert: [ aBlInsets isNotNil ]
		description: [ 'Padding must not be nil' ].

	self constraintsDo: [ :c | c padding: aBlInsets ]
]

{ #category : #accessing }
BlElement >> parent [
	<return: #BlElement or: nil>
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
	<return: #BlBounds>

	"then translate according to my position within the parent.
	Note, that an element might have a position even if it does not have a parent"
	aBounds translateBy: self position negated.
	
	"first apply inverted transformation if we have one"
	transformation inverseTransformBounds: aBounds.
	
	^ aBounds
]

{ #category : #'geometry position convertion' }
BlElement >> parentPointToLocal: aPoint [
	"Transform a given point from parent to my local coordinates"
	<return: #Point>
	| aLocalPoint |

	aLocalPoint := aPoint translateBy: self position negated.
	aLocalPoint := self transformation inverseTransformPoint: aLocalPoint.
	^ aLocalPoint
]

{ #category : #'geometry position' }
BlElement >> position [
	<return: #Point>

	^ self bounds position
]

{ #category : #'geometry position' }
BlElement >> position: aPoint [ 
	self 
		deprecated: 'Use relocate: instead'
		on: 	'1 October 2017' 
		in: 'Pharo-7.0-alpha.build.132.sha.4ea2f39a9f43185d31b844be5ad33b677f43bf17'.
	^ self relocate: aPoint 
]

{ #category : #accessing }
BlElement >> position: aPosition extent: anExtent [
	"I do a hard work of changing element's position and extent.
	This action must be very optimized in the sense of invalidation.
	For example if element becomes smaller in both axis (horizontal and vertical)
	it is enough to invalidate damaged area only once within old bounds,
	the same applies to homogeneous growing: we invalidate once after applying changes.
	Note, I do not request layout update and do not send invalidate to myself if only
	position changes, instead I send invalidate with my effect bounds in parent coordinates
	to my parent. It allows developers to implement drawing cache"
	| isPositionChanged isExtentChanged aPreviousExtent aPreviousPosition | 
	
	self
		assert: [ aPosition x isInfinite not and: [ aPosition y isInfinite not ] ]
		description: [ 'Position can not be infinite' ].
	
	self
		assert: [ anExtent x isInfinite not and: [ anExtent y isInfinite not ] ]
		description: [ 'Extent can not be infinite' ].

	aPreviousPosition := self position.
	aPreviousExtent := self extent.
	
	isPositionChanged := (aPreviousPosition closeTo: aPosition epsilon: BlElementChange epsilon) not.
	isExtentChanged := (aPreviousExtent closeTo: anExtent epsilon: BlElementChange epsilon) not.

	"nothing changed, return"
	(isPositionChanged or: [ isExtentChanged ])
		ifFalse: [ ^ self ].

	isPositionChanged ifTrue: [
		"change my position"
		self bounds position: aPosition.
		self changes positionChange: aPreviousPosition to: aPosition.

		"position changed without extent => invalidate cached space bounds.
		Note, that if extent changes we invalidate bounds cache anyway"
		isExtentChanged ifFalse: [ boundsCache invalidateBoundsInSpace ] ].

	isExtentChanged ifTrue: [ 
		"change my extent"
		self bounds extent: anExtent.
		self changes extentChange: aPreviousExtent to: anExtent.
		boundsCache invalidateBoundsInLocal ]
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

	shouldChildrenHandleMouseEvents := false
]

{ #category : #'event handling' }
BlElement >> preventMeAndChildrenMouseEvents [
	"Prevent me and my children from receiving mouse events"

	shouldHandleMouseEvents := false.
	shouldChildrenHandleMouseEvents := false
]

{ #category : #'event handling' }
BlElement >> preventMouseEvents [
	"Prevent *me* from handling mouse events.
	It does not influence the ability of the children to handle events, hence I am a local property"
	
	shouldHandleMouseEvents := false
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
		nextPutAll: misc label;
		nextPutAll: ' @ ';
		store: self identityHash
]

{ #category : #'api - bounds' }
BlElement >> relocate: aPoint [
	"Request position change in parent coordinates that will happen on the next frame or next layout pass triggered by #forceLayout.

	Note: I do not invalidate drawing bounds nor change actual position.
	I only register an update request and ask my parent (if there is one) to recompute
	layout. Do nothing if previous #relocate request was performed with the same coordinates.
	Note: We can not guarantee that new element's position will be equal to reqeusted one,
	since it depends on the applied layout.
	aPoint must not be nil"
	<event: #BlElementPositionChangedEvent>
	<event: #BlElementPositionInSpaceChangedEvent>

	self
		assert: [ aPoint isNotNil ]
		description: [ 'aPoint must not be nil' ].

	self measuredBounds position = aPoint
		ifTrue: [ ^ self ].

	self measuredBounds position: aPoint.
	self requestParentLayout
]

{ #category : #'children add/remove' }
BlElement >> removeChild: anElement [
	"Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	self assert: anElement isNotNil.
	self assert: anElement parent == self.
	
	"First of all, we have to damage area occupied by removed element"
	anElement invalidate.
	"then we request layout update while element is not yet removed"
	anElement requestLayout.

	anElement parent: nil.
	self children remove: anElement.
	self dispatchChildRemoved: anElement.
	
	"child removed"
	self childrenChanged
]

{ #category : #'children add/remove' }
BlElement >> removeChild: anElement in: aContainerName [
	self
		childNamed: aContainerName
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
	"First of all, we have to damage area occupied by removed element"
	anElement invalidate.
	"then we request layout update while element is not yet removed"
	anElement requestLayout.

	anElement parent: nil.
	self children removeAt: anIndex.
	self dispatchChildRemoved: anElement.
	self childrenChanged.
]

{ #category : #'children add/remove' }
BlElement >> removeChildNamed: aContainerName [
	self
		childNamed: aContainerName
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

	oldChildren do: [ :anElement |
		"First of all, we have to damage area occupied by removed element"
		anElement invalidate.
		"then we request layout update while element is not yet removed"
		anElement requestLayout.

		anElement parent: nil ].

	"actually remove children"
	self resetChildrenArray.
	"send hook after elements has been removes"
	oldChildren do: [ :anElement | self dispatchChildRemoved: anElement ].
	"finally requesting children changed"
	self childrenChanged
]

{ #category : #'children add/remove' }
BlElement >> removeChildren: aListOfElements [
	"Remove all elements listed in aListOfElements from my direct children.
	All elements must be my direct children.
	@use BlElement>>#removeChildren if you want to remove all my children
	@see BlElement>>#removeChild: for more info
	aListOfElements must not be nil."
	self assert: aListOfElements isNotNil.
	self
		assert: [ aListOfElements allSatisfy: [ :anElement | anElement parent == self ] ]
		description: [ 'I can only remove my direct children!' ].
	
	aListOfElements do: [ :anElement |
		"First of all, we have to damage area occupied by removed element"
		anElement invalidate.
		"then we request layout update while element is not yet removed"
		anElement requestLayout.
		anElement parent: nil ].
	self children removeAll: aListOfElements.
	aListOfElements do: [ :anElement | self dispatchChildRemoved: anElement ].

	self childrenChanged
]

{ #category : #'children add/remove' }
BlElement >> removeChildrenIn: aContainerName [
	self
		childNamed: aContainerName
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
	"Relace a given child relement with another element preserving the children order.
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
	
	aChildElement userData
		at: #blocContainer
		ifPresent: [ :aName | self addChild: anotherElement at: aChildIndex as: aName ]
		ifAbsent: [ self addChild: anotherElement at: aChildIndex ]
]

{ #category : #'children add/remove' }
BlElement >> replaceChild: aChildElement with: anotherElement as: aSymbol [
	"Relace a given child relement with another element preserving the children order.
	Request layout and redraw an area occupied by anElement.
	As result anElement sends BlElementRemovedEvent
	anElement must not be nil.
	anElement must be my direct child"
	| aChildIndex |

	self assert: aChildElement isNotNil.
	self assert: aChildElement parent == self.
	self assert: anotherElement isNotNil.
	self assert: aSymbol isNotNil.
	
	aChildIndex := self childIndexOf: aChildElement.
	self removeChildAt: aChildIndex.
	self addChild: anotherElement at: aChildIndex as: aSymbol
]

{ #category : #'focus requesting' }
BlElement >> requestFocus [
	"Request a focus for this element.
	If I am not added to the scene graph mark me as focused in order to re-try focus
	request as soon I am added to the scene graph"

	self isAttachedToSceneGraph
		ifTrue: [ self requestFocus: self ]
		ifFalse: [ self focused: true ]
]

{ #category : #'focus requesting' }
BlElement >> requestFocus: aChildElement [
	"Propagate focus request up in the scene graph with an original
	element that requested focus"

	self
		assert: [ self isAttachedToSceneGraph ]
		description: [ 'I must be attached to the scene graph' ].

	(self hasParent and: [ self parent isAttachedToSceneGraph ])
		ifTrue: [ self parent requestFocus: aChildElement ]
		ifFalse: [ self space requestFocusFor: aChildElement ]
]

{ #category : #layout }
BlElement >> requestLayout [
	"Request invalidation of layout on next space pulse
	@see #requestLayout: for more information"

	Bloc debugModeEnabled
		ifTrue: [ BlRequestLayoutSignal emit ].

	self requestLayout: self
]

{ #category : #layout }
BlElement >> requestLayout: anElement [
	"Request invalidation of layout on next space pulse originally
	emitted by a given element.
	Note: there should be no ===self isLayoutRequested ifTrue: [ ^ self ]===
	check since there can be a case when I am requesting layout, but my parent
	still does not"

	self layout requestingLayout: true.
	"checking for parent to be not nil is faster when inlined instead
	of using withParent:. It is critical because this method is being
	sent quite often and should be performant"
	self parent
		ifNotNil: [ :aParent | aParent requestLayout: anElement ]
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

{ #category : #initialization }
BlElement >> resetChildrenArray [
	children := Bloc preferableChildrenDataStructure new
]

{ #category : #'geometry transform' }
BlElement >> rotateByDegrees: anAngle [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	"self transform
		inherit;
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		rotateBy: anAngle axis: BlVector zAxis;
		apply"
]

{ #category : #'geometry transform' }
BlElement >> rotateByDegrees: angle axis: aVector [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		rotateBy: angle axis: aVector;
		apply
]

{ #category : #'geometry transform' }
BlElement >> rotateByDegrees: angle axis: aVector around: anOrigin [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		origin: anOrigin;
		rotateBy: angle axis: aVector;
		apply
]

{ #category : #'geometry transform' }
BlElement >> rotateByDegrees: angle center: aPoint [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		origin: (BlAffineTransformationPositionOrigin position: aPoint);
		rotateBy: angle axis: BlVector zAxis;
		apply
]

{ #category : #'geometry transform' }
BlElement >> rotateByRadians: anAngle [ 
	self 
		deprecated: 'Use rotateByDegrees: instead'
		on: 	'16 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
	^ self rotateByDegrees: anAngle radiansToDegrees
]

{ #category : #'geometry transform' }
BlElement >> rotateByRadians: angle center: aPoint [ 
	self 
		deprecated: 'Use rotateByDegrees:center: instead'
		on: 	'16 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.
	^ self rotateByDegrees: angle radiansToDegrees center: aPoint 
]

{ #category : #'geometry transform' }
BlElement >> scaleBy: aVector [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: aVector asPoint x y: aVector asPoint y z: 1);
		apply
]

{ #category : #'geometry transform' }
BlElement >> scaleTo: aFactorPoint [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: aFactorPoint asPoint x y: aFactorPoint asPoint y z: 1);
		apply
]

{ #category : #'geometry transform' }
BlElement >> scaleX: factor [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: factor y: 1 z: 1);
		apply
]

{ #category : #'geometry transform' }
BlElement >> scaleX: fx Y: fy [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: fx y: fy z: 1);
		apply
]

{ #category : #'geometry transform' }
BlElement >> scaleY: factor [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: 1 y: factor z: 1);
		apply
]

{ #category : #'event handling' }
BlElement >> shouldChildrenHandleMouseEvents [
	"Return true if my children are allowed to handle mouse events.
	Preventing my children from handling mouse event does not stop me from handling them"
	<return: #Boolean>

	^ shouldChildrenHandleMouseEvents
]

{ #category : #'event handling' }
BlElement >> shouldHandleMouseEvents [
	"Return true if I am allowed to handle mouse events.
	Preventing me from handling mouse event does not stop my children from doing so"
	<return: #Boolean>

	^ shouldHandleMouseEvents
]

{ #category : #'api - opening' }
BlElement >> showSpace: aSpace [
	self hasParent
		ifTrue: [ self parent showSpace: aSpace ]
		ifFalse: [
			self isAttachedToSceneGraph
				ifTrue: [ self space showSpace: aSpace ]
				ifFalse: [ aSpace show ] ]
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
	"Return space to which I belong. Direct reference boosts performance.
	Each element has a reference to the current space which is set at demand."
	<return: #BlSpace>
	
	space
		ifNotNil: [ ^ space ].
	
	self parent ifNotNil: [ :eachParent | space := eachParent space ].
	
	^ space
]

{ #category : #accessing }
BlElement >> space: aSpace [
	"Set space to be accessed directly from my multiple methods.
	Update the space reference for my children.
	aSpace must not be nil."
	self
		assert: [ aSpace isNotNil ]
		description: [ 'Space must not be nil' ].

	space := aSpace.
	self childrenDo: [ :each | each space: aSpace ]
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

{ #category : #'children accessing' }
BlElement >> topMostParent [
	"Return a topmot parent in a scene graph.
	A topmost parent is an element that does not have a parent by its own"
	<return: #BlElement>

	^ self hasParent
		ifTrue: [ self parent topMostParent ]
		ifFalse: [ self ]
]

{ #category : #'focus requesting' }
BlElement >> transferFocus [
	self space transferFocusTo: self
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
	transformation := anElementTransformation owner: self.
	self boundsCache invalidateBoundsInSpace.
	self invalidate.

	self onTransformationChanged
]

{ #category : #'geometry bounds' }
BlElement >> transformedBounds [
	^ boundsCache transformedBounds
]

{ #category : #'geometry bounds' }
BlElement >> transformedBounds: aSpartaRectangle [

	^ transformation transformBounds: (self boundsInLocal: aSpartaRectangle)
]

{ #category : #'geometry transform' }
BlElement >> translateBy: aDelta [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		inherit;
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		translateBy: (BlVector x: aDelta asPoint x y: aDelta asPoint y z: 0);
		apply
]

{ #category : #'geometry transform' }
BlElement >> translateTo: aPoint [
	self 
		deprecated: 'Use Transformation Builder instead'
		on: 	'15 October 2017' 
		in: 'Pharo-7.0+alpha.build.171.sha.df95d5fd8faa4c6bfd3537e26d67bb2c37daf99f (32 Bit)'.

	self transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		translateBy: (BlVector x: aPoint asPoint x y: aPoint asPoint y z: 0);
		apply
]

{ #category : #'geometry transform' }
BlElement >> translateX: xFactor Y: yFactor [
	self deprecated: 'Use translateBy: aBlPoint'.
	self translateBy: xFactor @ yFactor
]

{ #category : #'change reporting' }
BlElement >> updateBackground [
	self backgroundResizer adapt: self background to: self
]

{ #category : #'change reporting' }
BlElement >> updateGeometry [
	self geometryResizer adapt: self geometry to: self
]

{ #category : #accessing }
BlElement >> userData [
	"Returns a Dictionary that holds application dependent and temporary objects.
	Be careful to limit the use of such facility and prefer clean instance variables when it is possible to define them."
	<return: #Dictionary>
	self
		assert: [ misc userData isNotNil ]
		description: [ 'User data must not be nil' ].

	^ misc userData
]

{ #category : #accessing }
BlElement >> userData: aDictionary [
	misc userData: aDictionary
]

{ #category : #accessing }
BlElement >> visibility [
	<return: #BlVisibility>

	^ visibility
]

{ #category : #accessing }
BlElement >> visibility: aVisibility [
	"Change the visibility of the element and request layout if needed"
	| shouldRequestLayout |

	aVisibility = self visibility
		ifTrue: [ ^ self ].

	"hidden and visible types of visibility do not remove
	and element from the layout process, therefore we should only request
	layout if visibility changes from or to gone"
	shouldRequestLayout := visibility = BlVisibility gone
		or: [ aVisibility = BlVisibility gone ].

	visibility := aVisibility.

	shouldRequestLayout
		ifTrue: [ self requestLayout ].

	self invalidate
]

{ #category : #'geometry bounds' }
BlElement >> visualBounds [
	"Visual bounds represent a high precision area of rendered geometry, including border.
	By default, visual bounds of `inside` outskits equal to geometry bounds since border
	is never rendered outside of the element's geometry.
	Note: When there is no sparta canvas available, return geometry bounds"
	
	^ Bloc hasSparta
		ifTrue: [ self visualBoundsOn: (Bloc preferableSpartaCanvas offscreen) ]
		ifFalse: [ self geometryBounds ]
]

{ #category : #'geometry bounds' }
BlElement >> visualBounds: aBlBounds on: aCanvas [
	^ self geometry strokedBounds: aBlBounds of: self on: aCanvas
]

{ #category : #'geometry bounds' }
BlElement >> visualBoundsOn: aCanvas [
	"Return my visual bounds as a Rectangle.
	Visual bounds only take border and geometry into account.
	If a border is of inner type, then visual bounds are the same
	as geometry bounds, otherwise visual bounds are larger than geometry ones"
	<return: #Rectangle>
	
	^ (self visualBounds: BlBounds new on: aCanvas) asRectangle
]

{ #category : #testing }
BlElement >> wantCompositionBufferLayer [
	self userData
		at: #wantsCompositionBufferLayer
		put: true
]

{ #category : #testing }
BlElement >> wantCompositionLayer [
	self userData
		at: #wantsCompositionLayer
		put: true
]

{ #category : #testing }
BlElement >> wantsCompositionBufferLayer [
	^ self userData
		at: #wantsCompositionBufferLayer
		ifAbsent: [ false ]
]

{ #category : #testing }
BlElement >> wantsCompositionLayer [
	"Return true if I should be painted in my own composition layer (if supported)"
	<return: #Boolean>

	^ self userData
		at: #wantsCompositionLayer
		ifAbsent: [ false ]
]

{ #category : #'event handling' }
BlElement >> wantsMouseEventAt: aPoint [
	"Return true if I can be picked as target for mouse event at given location specified in space coordinates.
	By default elements can handle mouse events if they are visible and not transparent for mouse events"
	<return: #Boolean>

	^ self isVisible and: [ self containsGlobalPoint: aPoint ]
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
	mean that there neither me nor my children are visible at a given point"
	(isPointInsideMe not and: [ self clipChildren ])
		ifTrue: [ ^ false ].
	
	"a point is inside of me and I am a leaf element -> evaluate a block with me"
	(isPointInsideMe and: [ self hasChildren not ])
		ifTrue: [
			aBlock value: self.
			^ true ].

	anyChildFound := false.
	
	self children sortedByElevation reversed do: [ :eachChildElement |
		| aPointInChildCoordinates |
		aPointInChildCoordinates := eachChildElement parentPointToLocal: aPoint.
		
		"(implementation detail) we do not wrap an or: statement in a block closure because we explicitly want to evaluate
		it no matter of the value of the boolean"
		anyChildFound := anyChildFound or: (eachChildElement withAllChildrenAt: aPointInChildCoordinates do: aBlock) ].
	
	"if a point is inside of me, evaluate a block regardless whether there were any child"
	isPointInsideMe
		ifTrue: [
			aBlock value: self.
			^ true ].
	
	^ anyChildFound
]

{ #category : #'api - children enumeration' }
BlElement >> withAllChildrenBreadthFirst [
	| all |
	all := OrderedCollection with: self.
	self allChildrenBreadthFirstDo: [ :x | all add: x ].
	^ all
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
	
	self children sortedByElevation reversed do: [ :eachChildElement |
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

{ #category : #accessing }
BlElement >> zIndex: aNumber [
	self elevation: (BlRelativeElevation elevation: aNumber)
]
