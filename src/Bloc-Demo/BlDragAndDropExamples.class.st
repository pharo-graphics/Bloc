Class {
	#name : #BlDragAndDropExamples,
	#superclass : #Object,
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDragChangesScale [
	"Dragging the element changes its size, revert it when dropping"
	<script>
	| child scaleUpAnimation scaleDownAnimation |
	child := BlElement new
		         background: Color lightRed;
		         size: 50 asPoint;
		         addEventHandler: BlDragHandlerNew new.

	scaleUpAnimation := (BlTransformAnimation scale: 1.3)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
	scaleDownAnimation := (BlTransformAnimation scale: 1 / 1.3)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

	child
		addEventHandlerOn: BlDragStartEvent
		do: [ child addAnimation: scaleUpAnimation copy ].
	child
		addEventHandlerOn: BlDragEndEvent
		do: [ child addAnimation: scaleDownAnimation copy ].

	child openInSpace
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDragEventAndSpaceDragLiftEventDifference [

	"SpaceDragLiftEvent seems to be the same as DragStartEvent but sent to the space instead of the dragged Element"

	<script>
	| child space border |
	child := BlElement new
		         background: Color random;
		         addEventHandler: BlDragHandler new.

	space := BlSpace new.
	space root addChild: child.

	child addEventHandlerOn: BlDragEvent do: [
		border := BlBorder paint: Color random width: 5.
		child border: border ].
	"event sent during each frame of the drag"
	space
		addEventHandlerOn: BlSpaceDragLiftEvent
		do: [ child background: Color random ].
	"event sent at the beginning of the drag"

	space show
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragFromGridLayout [ 

	<script> 
	| grid elements offset space |
	grid := BlElement new size: 400 asPoint; layout: (BlGridLayout horizontal columnCount: 2).

elements := OrderedCollection new.
offset := 0.

space := BlSpace new.

1 to: 4 do: [ :i |
	|elt textElt|
	
	"Element initialization"
	elt := BlElement new size: 200 asPoint; background: Color lightGreen; border: (BlBorder paint: Color black width: 2); layout: BlFrameLayout new.
	
	textElt := BlTextElement new text: i asString asRopedText; constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter ].
	textElt text fontSize: 100.
	elt addChild: textElt.
	
	"Event handling"
	elt addEventHandlerOn: BlDragStartEvent do: [ :e |
		e consume.
		offset := elt positionInSpace - e position.
		elt removeFromParent.
		space root addChild: elt.
		elt preventMeAndChildrenMouseEvents ].
	
	elt addEventHandlerOn: BlDragEvent do: [ :e |
		elt position: e position + offset. ].
	
	elt addEventHandlerOn: BlDragEndEvent do: [ :e |
		elt allowMeAndChildrenMouseEvents ]. 
	
	"Add element to grid"
	grid addChild: elt. ].

space root addChild: grid.
space show.
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragFromGridLayoutWithFirstPreview [

	<script>
	| grid elements offset space preview textPreview |
	grid := BlElement new size: 400 asPoint; layout: (BlGridLayout horizontal columnCount: 2).

elements := OrderedCollection new.
offset := 0.

space := BlSpace new.
preview := BlElement new size: 200 asPoint; background: (Color lightGreen alpha: 0.3); border: (BlBorder paint: Color black width: 2); layout: BlFrameLayout new.

textPreview := BlAttributedTextElement new text: '0' asRopedText; constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter ].
textPreview text fontSize: 100.

preview addChild: textPreview.

1 to: 4 do: [ :i |
	|elt textElt|
	
	"Element initialization"
	elt := BlElement new size: 200 asPoint; background: Color lightGreen; border: (BlBorder paint: Color black width: 2); layout: BlFrameLayout new.
	
	textElt := BlTextElement new text: i asString asRopedText; constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter ].
	textElt text fontSize: 100.
	elt addChild: textElt.
	
	"Event handling"
	elt addEventHandlerOn: BlDragStartEvent do: [ :e |
		e consume.
		offset := elt positionInSpace - e position.
		elt removeFromParent.
		space root addChild: elt.
		elt preventMeAndChildrenMouseEvents.
		textPreview text: elt firstChild text ].
	
	elt addEventHandlerOn: BlDragEvent do: [ :e |
		elt position: e position + offset. ].
	
	elt addEventHandlerOn: BlDragEndEvent do: [ :e |
		elt allowMeAndChildrenMouseEvents ]. 
	
	elt addEventFilterOn: BlDragEnterEvent do: [ :e |
		textPreview text: elt firstChild text.
		e consume ].
	
	"Add element to grid"
	grid addChild: elt. ].
 
space root addChild: grid.

preview position: 400 asPoint.
space root addChild: preview.
space show.
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragPreviewGameWithElementMoving [

	<script>
	
"Basic elements initialization"

| space grid offset elements preview textPreview rearrangeBlock checkOrderBlock scaleFactor scaleUpAnimation scaleDownAnimation |
space := BlSpace new extent: 1000 asPoint.
space root layout: BlFrameLayout new.
space root background: Color lightRed.
grid := BlElement new size: 600 asPoint; layout: (BlGridLayout horizontal columnCount: 3); constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter].
offset := 0.
elements := OrderedCollection new.

"Preview element initialization"

preview := BlElement new size: 200 asPoint; background: (Color lightGreen alpha: 0.3); border: (BlBorder paint: Color black width: 2); layout: BlFrameLayout new.
textPreview := BlAttributedTextElement new text: '0' asRopedText; constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter ].
textPreview text fontSize: 100.
preview addChild: textPreview.

"Initialize the block closure that will rearrange the grid elements to insert the preview"

rearrangeBlock := [ :formerElement |
	|index|
	index := grid children indexOf: formerElement.
	(grid children includes: preview) ifTrue: [grid removeChild: preview].
	grid addChild: preview at: index.
	 ].

"Block closure that checks if the game is in order/finished"
checkOrderBlock := [ :grid |
	|children index inOrder|
	children := grid children.
	index := 1.
	inOrder := true.
	children do: [ :each |
		(each firstChild text asString = index asString) ifFalse: [ inOrder := false ].
		index := index + 1.
		].
	inOrder ifTrue: [ space root background: Color lightGreen. ]
	].

"Some animations for prettier visuals"
scaleFactor := 1.6.
scaleUpAnimation := (BlTransformAnimation scale: scaleFactor)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
scaleDownAnimation := (BlTransformAnimation scale: 1 / scaleFactor)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

"Initialize and insert grid elements"
1 to: 9 do: [ :i |
	|elt textElt|
	
	"Element initialization"
	elt := BlElement new size: 200 asPoint; background: Color lightGreen; border: (BlBorder paint: Color black width: 2); layout: BlFrameLayout new.
	
	textElt := BlTextElement new text: i asString asRopedText; constraintsDo: [:c | c frame vertical alignCenter. c frame horizontal alignCenter ].
	textElt text fontSize: 100.
	elt addChild: textElt.
	
	"Event handling"
	elt addEventHandlerOn: BlDragStartEvent do: [ :e |
		e consume.
		offset := elt positionInSpace - e position.
		rearrangeBlock value: elt.
		elt removeFromParent.
		space root addChild: elt.
		elt constraintsDo: [:c | c ignoreByLayout ].
		elt preventMeAndChildrenMouseEvents.
		textPreview text: elt firstChild text.
		elt addAnimation: scaleDownAnimation copy ].
	
	elt addEventHandlerOn: BlDragEvent do: [ :e |
		elt position: e position + offset. ].
	
	elt addEventHandlerOn: BlDragEndEvent do: [ :e |
		|previewIndex|
		elt allowMeAndChildrenMouseEvents.
		elt addAnimation: scaleUpAnimation copy.
		previewIndex := grid children indexOf: preview.
		grid removeChild: preview.
		elt removeFromParent.
		grid addChild: elt at: previewIndex.
		elt constraintsDo: [ :c | c accountByLayout ].
		checkOrderBlock value: grid. ]. 
	
	elt addEventFilterOn: BlDragEnterEvent do: [ :e |
		rearrangeBlock value: elt.
		e consume ].
	
	"Add element to grid"
	elements add: elt.
	"grid addChild: elt." ].

elements shuffle.
elements do: [ :each | grid addChild: each ].
 
"Displaying the result"
space root addChild: grid.
space show.
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragPreviewGameWithPreviewMoving [
	"Basic elements initialization"

	<script>
	| space grid offset elements preview textPreview rearrangeBlock checkOrderBlock scaleFactor scaleUpAnimation scaleDownAnimation draggedElement |
	space := BlSpace new extent: 1000 asPoint.
	space root layout: BlFrameLayout new.
	space root background: Color lightRed.
	grid := BlElement new
		        size: 600 asPoint;
		        layout: (BlGridLayout horizontal columnCount: 3);
		        constraintsDo: [ :c |
			        c frame vertical alignCenter.
			        c frame horizontal alignCenter ].
	offset := 0.
	elements := OrderedCollection new.

	"Preview element initialization"

	preview := BlElement new
		           size: 200 asPoint;
		           background: (Color lightGreen);
		           border: (BlBorder paint: Color black width: 2);
		           layout: BlFrameLayout new;
		           preventMeAndChildrenMouseEvents;
					  constraintsDo: [ :c | c ignoreByLayout ];
		           yourself.
	textPreview := BlAttributedTextElement new
		               text: '0' asRopedText;
		               constraintsDo: [ :c |
			               c frame vertical alignCenter.
			               c frame horizontal alignCenter ].
	textPreview text fontSize: 100.
	preview addChild: textPreview.
	draggedElement := nil.

	"Initialize the block closure that will rearrange the grid elements to insert the preview"

	rearrangeBlock := [ :formerElement |
	                  | index |
	                  index := grid children indexOf: formerElement.
	                  (grid children includes: draggedElement ) ifTrue: [
		                  grid removeChild: draggedElement ].
	                  grid addChild: draggedElement at: index ].

	"Block closure that checks if the game is in order/finished"
	checkOrderBlock := [ :grid |
	                   | children index inOrder |
	                   children := grid children.
	                   index := 1.
	                   inOrder := true.
	                   children do: [ :each |
		                   each firstChild text asString = index asString
			                   ifFalse: [ inOrder := false ].
		                   index := index + 1 ].
	                   inOrder ifTrue: [
		                   space root background: Color lightGreen ] ].

	"Some animations for prettier visuals"
	scaleFactor := 1.6.
	scaleUpAnimation := (BlTransformAnimation scale: scaleFactor)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
	scaleDownAnimation := (BlTransformAnimation scale: 1 / scaleFactor)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

	"Initialize and insert grid elements"
	1 to: 9 do: [ :i |
		| elt textElt |
		"Element initialization"
		elt := BlElement new
			       size: 200 asPoint;
			       background: Color lightGreen;
			       border: (BlBorder paint: Color black width: 2);
			       layout: BlFrameLayout new.

		textElt := BlTextElement new
			           text: i asString asRopedText;
			           constraintsDo: [ :c |
				           c frame vertical alignCenter.
				           c frame horizontal alignCenter ].
		textElt text fontSize: 100.
		elt addChild: textElt.

		"Event handling"
		elt addEventHandlerOn: BlDragStartEvent do: [ :e |
			e consume.
			offset := elt positionInSpace - e position.
			elt background: (Color lightGreen alpha: 0.3).
			textPreview text: elt firstChild text.
			preview position: elt positionInSpace.
			space root addChild: preview.
			preview addAnimation: scaleDownAnimation copy.
			draggedElement := elt ].

		elt addEventHandlerOn: BlDragEvent do: [ :e | 
			e consume.
			preview position: e position + offset ].

		elt addEventHandlerOn: BlDragEndEvent do: [ :e |
			e consume.
			preview position: elt positionInSpace.
			preview addAnimation: (scaleUpAnimation copy onFinishedDo: [
					 preview removeFromParent.
					 elt background: Color lightGreen ]).
			draggedElement := nil.
			checkOrderBlock value: grid ].

		elt addEventFilterOn: BlDragEnterEvent do: [ :e |
			rearrangeBlock value: elt.
			e consume ].

		"Add element to grid"
		elements add: elt
		"grid addChild: elt." ].

	elements shuffle.
	elements do: [ :each | grid addChild: each ].

	"Displaying the result"
	space root addChild: grid.
	space show
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragPreviewWithElementMoving [
	"Basic elements initialization"

	<script>
	| grid space offset preview textPreview rearrangeBlock scaleFactor scaleUpAnimation scaleDownAnimation |
	grid := BlElement new
		        size: 600 asPoint;
		        layout: (BlGridLayout horizontal columnCount: 3).
	space := BlSpace new.
	offset := 0.

	"Preview element initialization"

	preview := BlElement new
		           size: 200 asPoint;
		           background: (Color lightGreen alpha: 0.3);
		           border: (BlBorder paint: Color black width: 2);
		           layout: BlFrameLayout new.
	textPreview := BlAttributedTextElement new
		               text: '0' asRopedText;
		               constraintsDo: [ :c |
			               c frame vertical alignCenter.
			               c frame horizontal alignCenter ].
	textPreview text fontSize: 100.
	preview addChild: textPreview.

	"Initialize the block closure that will rearrange the grid elements to insert the preview"

	rearrangeBlock := [ :formerElement |
	                  | index |
	                  index := grid children indexOf: formerElement.
	                  (grid children includes: preview) ifTrue: [
		                  grid removeChild: preview ].
	                  grid addChild: preview at: index ].

	"Some animations for prettier visuals"
	scaleFactor := 1.6.
	scaleUpAnimation := (BlTransformAnimation scale: scaleFactor)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
	scaleDownAnimation := (BlTransformAnimation scale: 1 / scaleFactor)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

	"Initialize and insert grid elements"
	1 to: 9 do: [ :i |
		| elt textElt |
		"Element initialization"
		elt := BlElement new
			       size: 200 asPoint;
			       background: Color lightGreen;
			       border: (BlBorder paint: Color black width: 2);
			       layout: BlFrameLayout new.

		textElt := BlTextElement new
			           text: i asString asRopedText;
			           constraintsDo: [ :c |
				           c frame vertical alignCenter.
				           c frame horizontal alignCenter ].
		textElt text fontSize: 100.
		elt addChild: textElt.

		"Event handling"
		elt addEventHandlerOn: BlDragStartEvent do: [ :e |
			e consume.
			offset := elt positionInSpace - e position.
			rearrangeBlock value: elt.
			elt removeFromParent.
			space root addChild: elt.
			elt preventMeAndChildrenMouseEvents.
			textPreview text: elt firstChild text.
			elt addAnimation: scaleDownAnimation copy ].

		elt
			addEventHandlerOn: BlDragEvent
			do: [ :e | elt position: e position + offset ].

		elt addEventHandlerOn: BlDragEndEvent do: [ :e |
			|previewIndex|
			elt allowMeAndChildrenMouseEvents.
			elt addAnimation: scaleUpAnimation copy.
			previewIndex := grid children indexOf: preview.
			grid removeChild: preview.
			elt removeFromParent.
			grid addChild: elt at: previewIndex ].

		elt addEventFilterOn: BlDragEnterEvent do: [ :e |
			rearrangeBlock value: elt.
			e consume ].

		"Add element to grid"
		grid addChild: elt ].

	"Displaying the result"
	space root addChild: grid.
	space show
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentDragPreviewWithPreviewMoving [
	"Basic elements initialization"

	<script>
	| grid space offset preview textPreview rearrangeBlock scaleFactor scaleUpAnimation scaleDownAnimation draggedElement |
	grid := BlElement new
		        size: 600 asPoint;
		        layout: (BlGridLayout horizontal columnCount: 3).
	space := BlSpace new.
	offset := 0.

	"Preview element initialization"

	preview := BlElement new
		           size: 200 asPoint;
		           background: Color lightGreen;
		           border: (BlBorder paint: Color black width: 2);
		           layout: BlFrameLayout new;
		           preventMeAndChildrenMouseEvents;
		           yourself.
	textPreview := BlAttributedTextElement new
		               text: '0' asRopedText;
		               constraintsDo: [ :c |
			               c frame vertical alignCenter.
			               c frame horizontal alignCenter ].
	textPreview text fontSize: 100.
	preview addChild: textPreview.
	draggedElement := nil.

	"Initialize the block closure that will rearrange the grid elements to insert the preview"
	rearrangeBlock := [ :formerElement |
	                  | index |
	                  index := grid children indexOf: formerElement.
	                  (grid children includes: draggedElement) ifTrue: [
		                  grid removeChild: draggedElement ].
	                  grid addChild: draggedElement at: index ].

	"Some animations for prettier visuals"
	scaleFactor := 1.6.
	scaleUpAnimation := (BlTransformAnimation scale: scaleFactor)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
	scaleDownAnimation := (BlTransformAnimation scale: 1 / scaleFactor)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

	"Initialize and insert grid elements"
	1 to: 9 do: [ :i |
		| elt textElt |
		"Element initialization"
		elt := BlElement new
			       size: 200 asPoint;
			       background: Color lightGreen;
			       border: (BlBorder paint: Color black width: 2);
			       layout: BlFrameLayout new.

		textElt := BlTextElement new
			           text: i asString asRopedText;
			           constraintsDo: [ :c |
				           c frame vertical alignCenter.
				           c frame horizontal alignCenter ].
		textElt text fontSize: 100.
		elt addChild: textElt.

		"Link preview element to dragged element"
		elt addEventHandlerOn: BlDragStartEvent do: [ :e |
			e consume.
			offset := elt positionInSpace - e position.
			elt background: (Color lightGreen alpha: 0.3).
			textPreview text: elt firstChild text.
			preview position: elt position.
			space root addChild: preview.
			preview addAnimation: scaleDownAnimation copy.
			draggedElement := elt ].

		elt addEventHandlerOn: BlDragEvent do: [ :e |
			e consume.
			preview position: e position + offset ].


		elt addEventHandlerOn: BlDragEndEvent do: [ :e |
			e consume.
			preview position: elt position.
			preview addAnimation: (scaleUpAnimation copy onFinishedDo: [
					 preview removeFromParent.
					 elt background: Color lightGreen ]).
			draggedElement := nil ].

		"rearrange elements in grid when entering one element while dragging"
		elt addEventFilterOn: BlDragEnterEvent do: [ :e |
			rearrangeBlock value: elt.
			e consume ].

		"Add element to grid"
		grid addChild: elt ].

	"Displaying the result"
	space root addChild: grid.
	space show
]

{ #category : #'experimentations - dragSelector' }
BlDragAndDropExamples class >> experimentDragSelectorHighlightsSelectedElements [
	"This example shows how to draw a 'drag selector' rectangle using leftDrag, highlights hovered elements and inspect the list of it"
	<script>
	| space lasso initialPosition red blue green elements selectedElements |
	space := BlSpace new.
	lasso := BlElement new border: (BlBorderBuilder new
			          paint: Color veryLightGray;
			          width: 2;
			          dashed;
			          build).

	initialPosition := 0 asPoint.

	red := BlElement new
		       background: Color lightRed;
		       position: 100 asPoint.
	blue := BlElement new
		        background: Color lightBlue;
		        position: 200 asPoint.
	green := BlElement new
		         background: Color lightGreen;
		         position: 300 @ 150.

	elements := {
		            red.
		            blue.
		            green }.
	selectedElements := {  } asOrderedCollection.
	space root addChildren: elements.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consume.
		initialPosition := event position.
		elements do: [ :each | each border: BlBorder empty ].
		selectedElements := {  } asOrderedCollection ].

	space root addEventHandlerOn: BlDragEvent do: [ :event |
		| eventPos lassoPosX lassoPosY lassoSize |
		eventPos := event position.
		lassoPosX := eventPos x min: initialPosition x.
		lassoPosY := eventPos y min: initialPosition y.
		lassoSize := (eventPos - initialPosition) x abs
		             @ (eventPos - initialPosition) y abs.
		lasso hasParent ifTrue: [ lasso removeFromParent ].
		lasso
			position: lassoPosX @ lassoPosY;
			size: lassoSize.
		space root addChild: lasso ].

	space root addEventHandlerOn: BlDragEndEvent do: [ :event |
		| border |
		border := BlBorder paint: Color green width: 2.
		elements do: [ :each |
			((lasso position x <= (each position x + each width) and:
				  lasso position x + lasso width >= each position x) and:
				 (lasso position y <= (each position y + each height) and:
					  lasso position y + lasso height >= each position y)) ifTrue: [
				each border: border.
				selectedElements add: each ] ].
		selectedElements inspect ].

	space show
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDragStrategies [
	"Careful this example uses a prototype of a new DragHandler, click on the element to change strategies
	red -> Default (free drag)
	green -> Horizontal
	blue -> Vertical"

	<script>
	| handler child space strategy |
	handler := BlDragHandlerNew new.
	child := BlElement new
		         size: 100 asPoint;
		         background: Color red;
		         addEventHandler: handler.

	space := BlSpace new.
	space root addChildren: { child }.
	space show.


	strategy := 'Default'.
	child addEventHandlerOn: BlClickEvent do: [
		strategy = 'Default'
			ifTrue: [
				strategy := 'Horizontal'.
				'Now using a Horizontal Strategy' traceCr.
				child background: Color green.
				handler dragStrategy: BlDragHorizontalStrategy uniqueInstance ]
			ifFalse: [
				strategy = 'Horizontal'
					ifTrue: [
						strategy := 'Vertical'.
						'Now using a Vertical Strategy' traceCr.
						child background: Color blue.
						handler dragStrategy: BlDragVerticalStrategy uniqueInstance ]
					ifFalse: [
						strategy := 'Default'.
						'Now using a Default Strategy' traceCr.
						child background: Color red.
						handler dragStrategy: BlDragDefaultStrategy uniqueInstance ] ] ]
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDropEventReceivedByTargetArea [
	"sends correctly (and inform) a DropEvent to the target area when dropping the element on it"

	<script>
	| child target space |
	child := BlElement new
		         background: Color red;
		         addEventHandler: BlDragHandler new.

	target := BlElement new
		          background: Color lightGreen;
		          border: (BlBorder paint: Color green width: 3);
		          size: 300 asPoint;
		          position: 500 @ 200.

	space := BlSpace new.

	space root addChildren: {
			target.
			child }.

	target addEventHandlerOn: BlDropEvent do: [
		'Drop on target' traceCr.
		target background: Color random ].

	child
		addEventHandlerOn: BlDragEndEvent
		do: [ 'Drag Ended' traceCr ].

	child addEventHandlerOn: BlDropEvent do: [ 'Dropped' traceCr].
	"This should never be done, only target will receive this DropEvent"
	space show
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentHighlightAnimationToDraggedElement [
	"Adds a king of highlight Animation when dragging the element"
	<script>
	| child animation currentAnimation |
	child := BlElement new
		         background: Color red;
		         addEventHandler: BlDragHandler new.

	animation := BlColorTransition new
		             from: Color white;
		             to: Color red;
		             duration: 500 milliSeconds;
		             onStepDo: [ :c | child background: c ];
		             beInfinite;
		             yourself.

	currentAnimation := nil.
	child addEventHandlerOn: BlDragStartEvent do: [
		currentAnimation := animation copy.
		child addAnimation: currentAnimation ].

	child
		addEventHandlerOn: BlDragEndEvent
		do: [ currentAnimation loops: 0 ].

	child openInSpace
]

{ #category : #'experimentations - halos' }
BlDragAndDropExamples class >> experimentHoverToSeeHalosDecription [ 

	<script> 
	| elt haloContainer |
	elt := BlElement new background: Color lightRed; clipChildren: false; size: 150 asPoint; position: 100 asPoint.
haloContainer := BlElement new 
	background: Color lightGreen;
	layout: BlLinearLayout horizontal; 
	constraintsDo: [ :c | 
		c vertical fitContent. 
		c horizontal fitContent.
		c padding: (BlInsets all: 5) ];
	position: 0 @ -30;
	clipChildren: false. 

elt addEventHandlerOn: BlDragEvent do: [ :e | 'drag' traceCr].

elt addEventHandlerOn: BlDragEvent do: [ :e | elt inspect ].

elt addEventHandlerOn: BlDragStartEvent do: [ :e | elt inspect ]. 

elt addEventHandlerOn: BlClickEvent do: [ :event |
	(event modifiers isCtrl and: event modifiers isShift) 
		ifTrue: [
			(elt hasChild: haloContainer) ifFalse: [
				haloContainer removeChildren.
				elt eventDispatcher handlersDo: [ :handler |
					|handlerElt textElt|
					handlerElt := BlElement new size: 20 asPoint; background: Color random; clipChildren: false; constraintsDo: [ :c | c margin: (BlInsets all: 2) ].
					handlerElt addEventHandlerOn: BlClickEvent do: [ :e |
						handlerElt inspect ].
					textElt := BlTextElement new text: handler action asText asRopedText;background: Color lightYellow; position: 0@ 20.
					textElt text fontSize: 15.
					handlerElt addEventHandlerOn: BlMouseEnterEvent do: [ :e |
						handlerElt addChild: textElt.
						 ].
					handlerElt addEventHandlerOn: BlMouseLeaveEvent do: [ :e |
						handlerElt removeChild: textElt ]. 
					
					haloContainer addChild: handlerElt ].
				elt addChild: haloContainer]
			ifTrue: [ 
				elt removeChild: haloContainer ] ]].
	 


elt openInSpace 
]

{ #category : #'experimentations - halos' }
BlDragAndDropExamples class >> experimentInspectOnCtrlShift [

	<script>
	|elt|
	elt := BlElement new background: Color lightRed.

	elt addEventHandlerOn: BlClickEvent do: [ :event |
		(event modifiers isCtrl and: event modifiers isShift) ifTrue: [
			event inspect ] ].

	elt openInSpace
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentNewTagsOrderer [
	"This script was simplified from the example on the PR"
	<script>
	| aContainer |
	aContainer := BlElement new background: Color lightGray.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	aContainer addChildren:
		({ 'One'. 'Two'. 'Three'. 'Four' } collect: [ :eachName |
			 self tagOrdererDraggableTagFor: eachName ]).

	aContainer openInNewSpace
]

{ #category : #'experimentations - dragSelector' }
BlDragAndDropExamples class >> experimentRectangleDragSelect [
	"This example shows how to draw a 'drag selector' rectangle using leftDrag"
	<script>
	| space lasso initialPosition |
	space := BlSpace new.
	lasso := BlElement new border: (BlBorderBuilder new
			          paint: Color veryLightGray;
			          width: 2;
			          dashed;
			          build).

	initialPosition := 0 asPoint.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consume.
		initialPosition := event position ].
	space root addEventHandlerOn: BlDragEvent do: [ :event |
		| eventPos lassoPosX lassoPosY lassoSize |
		eventPos := event position.
		lassoPosX := eventPos x min: initialPosition x.
		lassoPosY := eventPos y min: initialPosition y.
		lassoSize := (eventPos - initialPosition) x abs
		             @ (eventPos - initialPosition) y abs.
		lasso hasParent ifTrue: [ lasso removeFromParent ].
		lasso
			position: lassoPosX @ lassoPosY;
			size: lassoSize.
		space root addChild: lasso ].

	space show
]

{ #category : #'experimentations - dragSelector' }
BlDragAndDropExamples class >> experimentRectangleDragSelectWithElementsOnSpace [
	"This example shows how to draw a 'drag selector' rectangle using leftDrag when there's elements in the space"
	<script>
	| space lasso initialPosition |
	space := BlSpace new.
	lasso := BlElement new border: (BlBorderBuilder new
			          paint: Color veryLightGray;
			          width: 2;
			          dashed;
			          build).

	initialPosition := 0 asPoint.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consume.
		initialPosition := event position ].
	space root addEventHandlerOn: BlDragEvent do: [ :event |
		| eventPos lassoPosX lassoPosY lassoSize |
		eventPos := event position.
		lassoPosX := eventPos x min: initialPosition x.
		lassoPosY := eventPos y min: initialPosition y.
		lassoSize := (eventPos - initialPosition) x abs
		             @ (eventPos - initialPosition) y abs.
		lasso hasParent ifTrue: [ lasso removeFromParent ].
		lasso
			position: lassoPosX @ lassoPosY;
			size: lassoSize.
		space root addChild: lasso ].

	space root addChild: (BlElement new
			 background: Color lightRed;
			 position: 100 asPoint).
	space root addChild: (BlElement new
			 background: Color lightBlue;
			 position: 200 asPoint).

	space show
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentRemoveDragHandlerAtRunTime [
	"It could be cool to 'sleep' the handler instead of removing/adding it each time"
	<script>
	| draggable child dragHandler |
	draggable := false.

	child := BlElement new background: Color red.
	dragHandler := BlDragHandler new.

	child addEventHandlerOn: BlClickEvent do: [
		draggable := draggable not.
		'draggable :' trace.
		draggable asString traceCr.
		draggable
			ifTrue: [
				child background: Color green.
				child addEventHandler: dragHandler ]
			ifFalse: [
				child background: Color red.
				child removeEventHandler: dragHandler ] ].


	child openInSpace
]

{ #category : #'experimentations - dragSelector - shortcut' }
BlDragAndDropExamples class >> experimentShortcutDragSelectorDragsSelectedElements [
	"This example lets us select elements to drag and we can drag the 'drag selector' to drag all selected elements"
	<script>
	| space lasso initialPosition red blue green elements selectedElements lassoBorder offset |
	space := BlSpace new.
	lassoBorder := BlBorderBuilder new
		               paint: Color veryLightGray;
		               width: 2;
		               dashed;
		               build.
	lasso := BlElement new
		         border: lassoBorder;
		         clipChildren: false.

	initialPosition := 0 asPoint.

	red := BlElement new
		       background: Color lightRed;
		       position: 100 asPoint.
	blue := BlElement new
		        background: Color lightBlue;
		        position: 200 asPoint.
	green := BlElement new
		         background: Color lightGreen;
		         position: 300 @ 150.

	elements := {
		            red.
		            blue.
		            green }.
	selectedElements := {  } asOrderedCollection.
	space root addChildren: elements.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			event consume.
			initialPosition := event position.
			selectedElements do: [ :each | each border: BlBorder empty ].
			selectedElements := {  } asOrderedCollection ] ].
	space root addEventHandlerOn: BlDragEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			| eventPos lassoPosX lassoPosY lassoSize |
			eventPos := event position.
			lassoPosX := eventPos x min: initialPosition x.
			lassoPosY := eventPos y min: initialPosition y.
			lassoSize := (eventPos - initialPosition) x abs
			             @ (eventPos - initialPosition) y abs.
			lasso hasParent ifTrue: [ lasso removeFromParent ].
			lasso
				position: lassoPosX @ lassoPosY;
				size: lassoSize.
			space root addChild: lasso ] ].

	space root addEventHandlerOn: BlDragEndEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			| border |
			border := BlBorder paint: Color green width: 2.
			elements do: [ :each |
				((lasso position x <= (each position x + each width) and:
					  lasso position x + lasso width >= each position x) and:
					 (lasso position y <= (each position y + each height) and:
						  lasso position y + lasso height >= each position y)) ifTrue: [
					each border: border.
					selectedElements add: each ] ] ] ].

	offset := 0.
	lasso addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consume.
		offset := event position - lasso position.
		lasso border: BlBorder empty.
		selectedElements do: [ :each |
			each position: each position - lasso position.
			each removeFromParent.
			lasso addChild: each ] ].

	lasso
		addEventHandlerOn: BlDragEvent
		do: [ :event | lasso position: event position - offset ].

	lasso addEventHandlerOn: BlDragEndEvent do: [ :event |
		lasso border: lassoBorder.
		selectedElements do: [ :each |
			each position: each position + lasso position.
			each removeFromParent.
			space root addChild: each ] ].

	space show
]

{ #category : #'experimentations - dragSelector - shortcut' }
BlDragAndDropExamples class >> experimentShortcutDragSelectorHighlightsSelectedElements [
	"This example shows how to highlight elements hovered by the 'drag selector'"
	<script>
	| space lasso initialPosition red blue green elements selectedElements |
	space := BlSpace new.
	lasso := BlElement new border: (BlBorderBuilder new
			          paint: Color veryLightGray;
			          width: 2;
			          dashed;
			          build).

	initialPosition := 0 asPoint.

	red := BlElement new
		       background: Color lightRed;
		       position: 100 asPoint.
	blue := BlElement new
		        background: Color lightBlue;
		        position: 200 asPoint.
	green := BlElement new
		         background: Color lightGreen;
		         position: 300 @ 150.

	elements := {
		            red.
		            blue.
		            green }.
	selectedElements := {  } asOrderedCollection.
	space root addChildren: elements.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			event consume.
			initialPosition := event position ] ].
	space root addEventHandlerOn: BlDragEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			| eventPos lassoPosX lassoPosY lassoSize |
			eventPos := event position.
			lassoPosX := eventPos x min: initialPosition x.
			lassoPosY := eventPos y min: initialPosition y.
			lassoSize := (eventPos - initialPosition) x abs
			             @ (eventPos - initialPosition) y abs.
			lasso hasParent ifTrue: [ lasso removeFromParent ].
			lasso
				position: lassoPosX @ lassoPosY;
				size: lassoSize.
			space root addChild: lasso ] ].

	space root addEventHandlerOn: BlDragEndEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			| border |
			border := BlBorder paint: Color green width: 2.
			elements do: [ :each |
				((lasso position x <= (each position x + each width) and:
					  lasso position x + lasso width >= each position x) and:
					 (lasso position y <= (each position y + each height) and:
						  lasso position y + lasso height >= each position y)) ifTrue: [
					each border: border.
					selectedElements add: each ] ].
			selectedElements inspect ] ].

	space show
]

{ #category : #'experimentations - dragSelector - shortcut' }
BlDragAndDropExamples class >> experimentShortcutRectangleDragSelect [
	"This example shows how to draw a 'drag selector' rectangle using ctrl+leftDrag"
	<script>
	| space lasso initialPosition |
	space := BlSpace new.
	lasso := BlElement new border: (BlBorderBuilder new
			          paint: Color veryLightGray;
			          width: 2;
			          dashed;
			          build).

	initialPosition := 0 asPoint.

	space root addEventHandlerOn: BlDragStartEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			event consume.
			initialPosition := event position ] ].
	space root addEventHandlerOn: BlDragEvent do: [ :event |
		event modifiers isCtrl ifTrue: [
			| eventPos lassoPosX lassoPosY lassoSize |
			eventPos := event position.
			lassoPosX := eventPos x min: initialPosition x.
			lassoPosY := eventPos y min: initialPosition y.
			lassoSize := (eventPos - initialPosition) x abs
			             @ (eventPos - initialPosition) y abs.
			lasso hasParent ifTrue: [ lasso removeFromParent ].
			lasso
				position: lassoPosX @ lassoPosY;
				size: lassoSize.
			space root addChild: lasso ] ].

	space show
]

{ #category : #'experimentations - preview' }
BlDragAndDropExamples class >> experimentTabsDragPreview [

	<script>
	| grid space offset preview textPreview rearrangeBlock scaleFactor scaleUpAnimation scaleDownAnimation draggedElement |
	grid := BlElement new
		        size: 700 asPoint;
		        layout: BlLinearLayout horizontal.
	space := BlSpace new.
	offset := 0.

	"Preview element initialization"

	preview := BlElement new
		           size: 70 @ 70;
		           background: Color lightGreen;
		           border: (BlBorder paint: Color black width: 2);
		           layout: BlFrameLayout new;
		           preventMeAndChildrenMouseEvents;
		           yourself.
	textPreview := BlAttributedTextElement new
		               text: '0' asRopedText;
		               constraintsDo: [ :c |
			               c frame vertical alignCenter.
			               c frame horizontal alignCenter ].
	textPreview text fontSize: 30.
	preview addChild: textPreview.
	draggedElement := nil.

	"Initialize the block closure that will rearrange the grid elements to insert the preview"
	rearrangeBlock := [ :formerElement |
	                  | index |
	                  index := grid children indexOf: formerElement.
	                  (grid children includes: draggedElement) ifTrue: [
		                  grid removeChild: draggedElement ].
	                  grid addChild: draggedElement at: index ].

	"Some animations for prettier visuals"
	scaleFactor := 1.2.
	scaleUpAnimation := (BlTransformAnimation scale: scaleFactor)
		                    duration: 0.3 seconds;
		                    easing: BlEasingBounceIn new.
	scaleDownAnimation := (BlTransformAnimation scale: 1 / scaleFactor)
		                      duration: 0.3 seconds;
		                      easing: BlEasingBounceOut new.

	"Initialize and insert grid elements"
	1 to: 9 do: [ :i |
		| elt textElt |
		"Element initialization"
		elt := BlElement new
			       size: 70 @ 70;
			       background: Color lightGreen;
			       border: (BlBorder paint: Color black width: 2);
			       layout: BlFrameLayout new.

		textElt := BlTextElement new
			           text: i asString asRopedText;
			           constraintsDo: [ :c |
				           c frame vertical alignCenter.
				           c frame horizontal alignCenter ].
		textElt text fontSize: 30.
		elt addChild: textElt.

		"Link preview element to dragged element"
		elt addEventHandlerOn: BlDragStartEvent do: [ :e |
			e consume.
			offset := elt positionInSpace - e position.
			elt background: (Color lightGreen alpha: 0.3).
			textPreview text: elt firstChild text.
			preview position: elt position.
			space root addChild: preview.
			preview addAnimation: scaleDownAnimation copy.
			draggedElement := elt ].

		elt addEventHandlerOn: BlDragEvent do: [ :e |
			e consume.
			preview position: e position + offset ].


		elt addEventHandlerOn: BlDragEndEvent do: [ :e |
			e consume.
			preview position: elt position.
			preview addAnimation: (scaleUpAnimation copy onFinishedDo: [
					 preview removeFromParent.
					 elt background: Color lightGreen ]).
			draggedElement := nil ].

		"rearrange elements in grid when entering one element while dragging"
		elt addEventFilterOn: BlDragEnterEvent do: [ :e |
			rearrangeBlock value: elt.
			e consume ].

		"Add element to grid"
		grid addChild: elt ].

	"Displaying the result"
	space root addChild: grid.
	space show
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentTargetBorderChangesWithDragEnterAndLeaveEvents [
	"This example shows that if we end the drag while entered the target, the element will leave the target and the border will remain green because there's obviously no DragLeaveEvent sent"
	<script>
	| child target borderRed borderGreen space |
	child := BlElement new
		         background: Color blue;
		         addEventHandler: BlDragHandler new.

	target := BlElement new
		          background: Color lightGray;
		          size: 150 asPoint;
		          position: 100 asPoint.

	borderRed := BlBorder paint: Color red width: 3.
	borderGreen := BlBorder paint: Color green width: 3.
	target border: borderRed.

	space := BlSpace new.
	space root addChildren: {
			target.
			child }.
	space show.

	target
		addEventHandlerOn: BlDragEnterEvent
		do: [ target border: borderGreen ].
	target
		addEventHandlerOn: BlDragLeaveEvent
		do: [ target border: borderRed ]

]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentWiggleAnimationToDraggedElement [
	"Adds a 'wiggle' animation when dragging the elements"
	"This example needs to be checked because of the rotation offset obtained after releasing the drag"

	<script>
	| child angle animation1 animation2 animation3 animation currentAnimation |
	child := BlElement new
		         background: Color red;
		         addEventHandler: BlDragHandler new.
	angle := 5.
	animation1 := (BlTransformAnimation rotate: angle)
		              duration: 50 milliSeconds;
		              easing: BlLinearInterpolator new;
		              target: child;
		              yourself.
	animation2 := (BlTransformAnimation rotate: -2 * angle)
		              duration: 100 milliSeconds;
		              easing: BlLinearInterpolator new;
		              target: child;
		              yourself.
	animation3 := (BlTransformAnimation rotate: angle)
		              duration: 50 milliSeconds;
		              easing: BlLinearInterpolator new;
		              target: child;
		              yourself.

	animation := BlSequentialAnimation new
		             addAll: {
				             animation1.
				             animation2.
				             animation3 };
		             beInfinite;
		             yourself.
	currentAnimation := nil.
	child addEventHandlerOn: BlDragStartEvent do: [
		currentAnimation := animation copy.
		child addAnimation: currentAnimation ].

	child
		addEventHandlerOn: BlDragEndEvent
		do: [ currentAnimation loops: 0 ].

	child openInSpace
]

{ #category : #'see class side' }
BlDragAndDropExamples >> seeClassSide [ 
]
