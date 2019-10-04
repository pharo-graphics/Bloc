"
BlAsyncElement is an abstract class that provides a simple framework for Bloc Elements that need to perform asynchronous processing of the display, typically because it is CPU intensive, has lots of I/O or depends on other asynchronous elements such as network access.

Using BlAsyncElement consists of creating two classes: 

- A subclass of BlAsyncElement, which is responsible for drawing the results on the canvas.
- A subclass of BlAsyncElementValuable, which is responsible for performing the asynchronous operations.

TaskIt is used to queue and execute operations.  Multiple items may be queued for an element before the first is executed, so the normal approach is to determine the work to be performed at the time the valuable is evaluated.  Subsequent tasks will realise that no additional work is required and finish quickly.

By default, an update is scheduled:

- When the receiver is added to a scene graph.
- When the receiver's layout is changed.

Subclasses can schedule additional updates by sending #queueAsyncUpdate to themselves.

Because adding tasks and their execution order is indeterminate, no attempt is made to remove duplicates, rather the task should confirm that an update is required by calling #needsUpdate.

Subclasses are responsible for implementing #drawOnSpartaCanvas:.

There are two ""priorities"" involved with BlAsyncElement:

- All background processing is done by BlAsyncUIWorkerPool at the Process priority specified in BlTKTBackgroundProcessProvider>>createProcessDoing:named:.
- Items are retrieved from the task queue in priority order.  Priority 0 is the highest priority, with positive numbers being progressively lower priority.  Normally priorities are calculated dynamically, with elements that are currently visible receiving the highest priority, and then lower priority the further away from the visible area they are.

By default the dynamic priority will be based on whether the receiver is within the space's bounds.  However it is possible (or likely) that the receiver will be a child of another element that only occupies a small portion of the space.  Specifying the parent which has the actual visible area improves the priority order.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
!Internal Representation and Key Implementation Points.

!!Instance Variables

	priority:						<Integer>  An optional manually set priority at relative to other BlAsyncElements. 0 is highest priority.
	visibleElement:	<BlElement> The dynamic priority will be based on whether the receiver is visible within the visibleElement.
	taskitRunner:		<Object> The object that is used to schedule tasks.  The default is BlAsyncUIWorkerPool, but this can be replaced with TKTLocalProcessTaskRunner to facilitate testing.
	errorStencil:			<BrStencil> The stencil used to display errors that occurred while processing the element asynchronously.  It takes a single argument, the exception that occurred while processing.

!!Implementation Points

- BlAsyncElement relies on subclasses to send #queueAsyncUpdate due to the conflicting requirements on when to submit the task, e.g. BlLazyElement defers task submission until it has been drawn the first time, while many elements want to render as soon as they are attached to a scene graph.
"
Class {
	#name : #BlAsyncElement,
	#superclass : #BlElement,
	#instVars : [
		'priority',
		'visibleElement',
		'taskitRunner',
		'errorStencil',
		'asyncException'
	],
	#category : #'Bloc-Async'
}

{ #category : #accessing }
BlAsyncElement >> asyncException [
	^ asyncException
]

{ #category : #accessing }
BlAsyncElement >> asyncException: anException [
	"Set the exception raised while trying to asynchronously process the receiver's content.
	This can be called from a background process, so ensure element updates occur in the UI process"

	anException freeze.
	asyncException := anException.
	self enqueueTask: (BlTaskAction new action: [ 
		asyncException 
			ifNil: [ self removeChildren ]
			ifNotNil: [ | exceptionElement |
				exceptionElement := (self errorStencil arguments: { asyncException }) create.
				exceptionElement constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ].
				self addChild: exceptionElement ] ] )
]

{ #category : #presentation }
BlAsyncElement >> displayRendering [
	"Display the Rendering message while background processing performed"

	self enqueueTask: (BlTaskAction new action: [ self setDisplayRendering ])
]

{ #category : #accessing }
BlAsyncElement >> errorStencil [
	^ errorStencil
]

{ #category : #accessing }
BlAsyncElement >> errorStencil: aBrStencil [

	errorStencil := aBrStencil asStencil
]

{ #category : #initialization }
BlAsyncElement >> initialize [ 

	super initialize.
	self setDefaultErrorStencil.

]

{ #category : #testing }
BlAsyncElement >> needsUpdate [
	"Answer a boolean indicating whether the receiver needs to be updated (via an asynchronous task).
	Typically this will be overridden by concrete subclasses to avoid unnecessary updates."

	^asyncException isNil and: [ self isAttachedToSceneGraph ]

]

{ #category : #accessing }
BlAsyncElement >> priority [
	^ priority
]

{ #category : #accessing }
BlAsyncElement >> priority: anInteger [

	priority := anInteger
]

{ #category : #'async processing' }
BlAsyncElement >> queueAsyncUpdate [
	"Queue a task to update the receiver's state."

	self needsUpdate ifFalse: [ ^self ].
	self taskPool schedule: self queueEntry.
]

{ #category : #'async processing' }
BlAsyncElement >> queueEntry [
	"Answer a valuable that will update the receiver when processed"

	^self subclassResponsibility
]

{ #category : #private }
BlAsyncElement >> renderingElement [
	"Answer an element that can be added as a child and displays the standard 'rendering' image"

	| rendering element backgroundPaint container |

	rendering := 'Rendering...' asRopedText 
			foreground: Color gray lighter;
			fontSize: 12.
	element := (BlTextElement new 
				text: rendering;
				geometry: (BlRectangle cornerRadius: 7);
				padding: (BlInsets top: 10 left: 20 bottom: 10 right: 20);
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]).
	backgroundPaint := BlLinearGradientPaint new
						stops:
							{(0.0 -> Color white ).
							(0.25 -> Color white darker).
							(1.0 -> Color white)};
						start: 0@0;
						end: 1@1.
	element background: backgroundPaint.
	container := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: element.
	^container
]

{ #category : #private }
BlAsyncElement >> setDefaultErrorStencil [

	self errorStencil: [ :exception |
		BrButton new
			label: 'Debug' translated asRopedText;
			look: BrGlamorousButtonWithLabelAndIconLook;
			icon: BrGlamorousIcons alarm asElement;
			action: [ [ exception defaultAction ] fork ] ]
]

{ #category : #private }
BlAsyncElement >> setDisplayRendering [
	"Set the rendering element as a child of the receiver.
	This method must be evaluated within the UI process"

	self addChild: self renderingElement
]

{ #category : #'async processing' }
BlAsyncElement >> taskPool [
	"Answer the default pool used for async tasks.
	Subclasses can override to use a different pool"
	<return: #TKTCommonQueueWorkerPool>

	^ BlTktWorkerProvider highUICPUBoundPool
]

{ #category : #accessing }
BlAsyncElement >> taskitRunner [

	^ taskitRunner ifNil: [ taskitRunner := BlTktWorkerProvider nonUISinglePool ]
]

{ #category : #accessing }
BlAsyncElement >> taskitRunner: anObject [
	taskitRunner := anObject
]

{ #category : #accessing }
BlAsyncElement >> visibleElement [
	"Answer the element which will be used to calculate the receivers evaluation priority.
	Default = the space's root element"

	^ visibleElement ifNil: [ self space root ]
]

{ #category : #accessing }
BlAsyncElement >> visibleElement: aBlElement [
	"Answer the element which will be used to calculate the receivers evaluation priority.
	Default (nil) = the space's root element"

	visibleElement := aBlElement
]
