Class {
	#name : #BlDragAndDropExamples,
	#superclass : #Object,
	#category : #'Bloc-DragNDrop-example'
}

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDragEventAndSpaceDragLiftEventDifference [

	<script>

| child space border |
child := BlElement new background: Color random; addEventHandler: BlDragHandler new.

space := BlSpace new.
space root addChild: child.

child addEventHandlerOn: BlDragEvent do: [ 
	border := BlBorder paint: Color random width:5.
	child border: border ].
"event sent during each frame of the drag"
space addEventHandlerOn: BlSpaceDragLiftEvent do: [ 
	child background: Color random ]. 
"event sent at the beginning of the drag"

space show.
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentDropEventReceivedByTargetArea [

	<script>
	| child target space |
	child := BlElement new background: Color red; addEventHandler: BlDragHandler new.

target := BlElement new background: Color lightGreen; border: (BlBorder paint: Color green width: 3); size: 300 asPoint; position: 500 @ 200.

space := BlSpace new.

space root addChildren: { target. child. }.

target addEventHandlerOn: BlDropEvent do: [ self inform: 'Drop on target' ].

child addEventHandlerOn: BlDragEndEvent do: [ self inform: 'Drag Ended' ]. 

child addEventHandlerOn: BlDropEvent do: [ self inform: 'Dropped' ].
"This should never be done, only target will receive this DropEvent"
space show.
]

{ #category : #experimentations }
BlDragAndDropExamples class >> experimentHighlightAnimationToDraggedElement [

	<script>
	| child animation currentAnimation |
	child := BlElement new background: Color red; addEventHandler: BlDragHandler new.

animation := BlColorTransition new
		  from: Color white;
		  to: Color red;
		  duration: 500 milliSeconds;
		  onStepDo: [ :c | child background: c ];
		  beInfinite;
		  yourself.

currentAnimation := nil.
child addEventHandlerOn: BlDragStartEvent do: [ currentAnimation := animation copy.
	child addAnimation: currentAnimation. ].

child addEventHandlerOn: BlDragEndEvent do: [ currentAnimation loops: 0. ]. 

child openInSpace
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
		self inform: 'draggable : ' , draggable asString.
		draggable
			ifTrue: [
				child background: Color green.
				child addEventHandler: dragHandler ]
			ifFalse: [
				child background: Color red.
				child removeEventHandler: dragHandler ] ].


	child openInSpace
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
"This example needs to be checked because of the rotation offset obtained after releasing the drag"
	<script>
	| child angle animation1 animation2 animation3 animation currentAnimation |
	child := BlElement new background: Color red; addEventHandler: BlDragHandler new.
angle := 5.
animation1 := (BlTransformAnimation
		  rotate: angle )
		  duration: 50 milliSeconds;
		  easing: BlLinearInterpolator new;
		target: child;
		  yourself.
animation2 := (BlTransformAnimation
		  rotate: -2*angle )
		  duration: 100 milliSeconds;
		  easing: BlLinearInterpolator new;
		target: child;
		  yourself.
animation3 := (BlTransformAnimation
		  rotate: angle )
		  duration: 50 milliSeconds;
		  easing: BlLinearInterpolator new;
		target: child;
		  yourself.

animation := BlSequentialAnimation new addAll: { animation1.animation2.animation3 }; beInfinite;yourself.
currentAnimation := nil.
child addEventHandlerOn: BlDragStartEvent do: [
	currentAnimation := animation copy.
	child addAnimation: currentAnimation. ].

child addEventHandlerOn: BlDragEndEvent do: [ currentAnimation loops: 0. ]. 

child openInSpace
]

{ #category : #letters }
BlDragAndDropExamples class >> labelContainer: anElement with: aText [

	^ BlElement new
		  layout: (BlLinearLayout vertical alignTopCenter cellSpacing: 10);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChild: (BlTextElement new text: aText asRopedText);
		  addChild: anElement
]

{ #category : #letters }
BlDragAndDropExamples class >> letterFor: aCharacter [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  size: 30 @ 30;
		  margin: (BlInsets all: 5);
		  background: Color veryVeryLightGray;
		  border: (BlBorder paint: Color veryLightGray width: 1);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		  effect: (BlGaussianShadowEffect
				   color: (Color lightGray alpha: 0.4)
				   width: 2
				   offset: 0 @ 0);
		  addChild: (BlTextElement new
				   labelMeasurement;
				   text: aCharacter asString asRopedText)
]

{ #category : #letters }
BlDragAndDropExamples class >> lettersSorter [

	<sampleInstance>
	| letters vowels consonants  |
	letters := self lettersSorterContainer.
	
	vowels := self lettersSorterRoundedContainerWithBorder.
	vowels background: Color lightRed.
	vowels addEventHandler: (BlDropHandler new 
			 acceptItemsSuchThat: [ :aDragItem :aDropArea | aDragItem sourceElement parent ~~ aDropArea ];
			 acceptDomainObjectsSuchThat: [ :anObject | anObject isCharacter and: [ anObject isVowel ] ];
			 whenDroppedDo: 
				[ :anItemsDroppedEvent | anItemsDroppedEvent currentTarget addChildren:
						 (anItemsDroppedEvent items collect: 
						[ :eachDragItem | self lettersSorterDraggableLetterFor: eachDragItem domainObject ]) ]).

	consonants := self lettersSorterRoundedContainerWithBorder.
	consonants background: Color lightBlue.
	consonants addEventHandler: (BlDropHandler new
			 acceptItemsSuchThat: [ :aDragItem :aDropArea | aDragItem sourceElement parent ~~ aDropArea ];
			 acceptDomainObjectsSuchThat: [ :anObject | anObject isCharacter and: [ anObject isVowel not ] ];
			 whenDroppedDo: 
					[ :anItemsDroppedEvent | anItemsDroppedEvent currentTarget addChildren:
						 (anItemsDroppedEvent items collect: 
								[ :eachDragItem | self lettersSorterDraggableLetterFor: eachDragItem domainObject ]) ]).

	letters addChildren:
		({ $a. $c. $Q. $o. $j. $E. $y. $Z. $U. $B. $p. $i } collect: [ :each | self lettersSorterDraggableLetterFor: each ]).

	^ BlElement new
		  layout: (BlLinearLayout horizontal cellSpacing: 30);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChildren: {
				  (self
					   labelContainer: letters
					   with: 'Letters to sort').
				  (self
					   labelContainer: vowels
					   with: 'Vowel letters').
				  (self
					   labelContainer: consonants
					   with: 'Consonant letters') }; openInNewSpace .
]

{ #category : #letters }
BlDragAndDropExamples class >> lettersSorterContainer [

	^ BlElement new
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  padding: (BlInsets all: 10)
]

{ #category : #letters }
BlDragAndDropExamples class >> lettersSorterDraggableLetterFor: aCharacter [

	| element  |
	element := self letterFor: aCharacter.
	element
		addEventHandler: (BlDragHandler new liftItemBlock: [ :aSourceElement |
					 BlDragItem new
						 sourceElement: aSourceElement;
						 domainObject: aCharacter;
						 stencil: [ :aDragItem |
							 self letterFor:
									 aDragItem domainObject
									 ] ]);
		addEventHandlerOn: BlAboutToBeDroppedEvent
		do: [ :anEvent | 
			anEvent currentTarget removeFromParent ].
	^ element
]

{ #category : #letters }
BlDragAndDropExamples class >> lettersSorterRoundedContainerWithBorder [


	^ self lettersSorterContainer
		  border: (BlBorderBuilder new
				   paint: Color gray;
				   dashed;
				   width: 2;
				   build);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #tags }
BlDragAndDropExamples class >> tagFor: aString [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  constraintsDo: [ :c |
			  c horizontal fitContent.
			  c vertical fitContent ];
		  margin: (BlInsets all: 5);
		  padding: (BlInsets all: 10);
		  background: Color veryVeryLightGray;
		  border: (BlBorder paint: Color veryLightGray width: 1);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		  effect: (BlGaussianShadowEffect
				   color: (Color lightGray alpha: 0.4)
				   width: 2
				   offset: 0 @ 0);
		  addChild: (BlTextElement new
				   labelMeasurement;
				   text: aString asString asRopedText)
]

{ #category : #tags }
BlDragAndDropExamples class >> tagOrdererDraggableTagFor: aString [

	^ (self tagFor: aString)
		  addEventHandler: (BlDragHandler new liftItemBlock: [ :aSourceElement |
					   BlDragItem new
						   sourceElement: aSourceElement;
						   domainObject: aString;
						   stencil: [ :aDragItem | self tagFor: aDragItem domainObject ] ]);
		  addEventHandlerOn: BlAboutToBeDroppedEvent
		  do: [ :anEvent | anEvent currentTarget removeFromParent ]; yourself.
	"	withStylesDo: [ :theStyles |
			theStyles
				addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance;
					background: Color veryLightGray);
			 	addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance not;
					background: Color veryVeryLightGray)  ];"
]

{ #category : #tags }
BlDragAndDropExamples class >> tagOrdererSlidingTagFor: aString [

	^ (self tagFor: aString)
		  addEventHandler: (BlDragHandler new
				   dragArea: [ :aSourceElement | aSourceElement parent ];
				   liftItemBlock: [ :aSourceElement |
					   BlDragItem new
						   sourceElement: aSourceElement;
						   domainObject: aString;
						   stencil: [ :aDragItem | self tagFor: aDragItem domainObject ] ]);
		  addEventHandlerOn: BlAboutToBeDroppedEvent
		  do: [ :anEvent | anEvent currentTarget removeFromParent ];
		  yourself
	"withStylesDo: [ :theStyles |
			theStyles
				addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance;
					visibility: BlVisibility hidden);
			 	addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance not;
					visibility: BlVisibility visible)  ];"
]

{ #category : #tags }
BlDragAndDropExamples class >> tagsOrderer [

	<sampleInstance>
	| aContainer |
	aContainer := BlElement new.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	aContainer addEventHandler: (BlDropHandler new
			 acceptOnlyFromThisElement;
			 whenDragOverDo: [ :anItemsDraggedOverEvent |
				 | container locationElement position childPosition |
				 container := anItemsDraggedOverEvent currentTarget.
				 locationElement := container
					                    childWithId: #'drop-area--drop-location'
					                    ifFound: [ :anElement | anElement ]
					                    ifNone: [
						                    | anElement |
						                    anElement := BlElement new
							                                 background: Color orange;
							                                 width: 2;
							                                 constraintsDo: [ :c |
								                                 c ignoreByLayout.
								                                 c vertical matchParent ].

						                    container
							                    addChild: anElement
							                    as: #'drop-area--drop-location'.
						                    anElement ].

				 position := anItemsDraggedOverEvent position x.
				 childPosition := container children accountedByLayout
					                  detect: [ :eachChild |
					                  position < eachChild bounds inParent center x ]
					                  ifFound: [ :eachChild |
					                  eachChild bounds inParent left - 10 ]
					                  ifNone: [
						                  container children accountedByLayout last
							                  bounds inParent right + 10 ].

				 locationElement position: childPosition @ 0 ];
			 whenDragLeftDo: [ :anItemsLeftEvent |
				 anItemsLeftEvent currentTarget removeChildWithId:
					 #'drop-area--drop-location' ];
			 whenDroppedDo: [ :anItemsDroppedEvent |
				 | container position childBefore |
				 container := anItemsDroppedEvent currentTarget.
				 position := anItemsDroppedEvent position x.
				 childBefore := container children accountedByLayout
					                detect: [ :eachChild |
					                position < eachChild bounds inParent center x ]
					                ifFound: [ :eachChild | eachChild ]
					                ifNone: [ nil ].

				 (anItemsDroppedEvent items collect: [ :eachDragItem |
					  eachDragItem sourceElement ]) do: [ :each |
					 childBefore
						 ifNil: [ container addChild: each ]
						 ifNotNil: [ container addChild: each before: childBefore ] ] ]).

	aContainer addChildren:
		({ 'One'. 'Two'. 'Three'. 'Four' } collect: [ :eachName |
			 self tagOrdererDraggableTagFor: eachName ]).

	^ aContainer openInNewSpace
]

{ #category : #tags }
BlDragAndDropExamples class >> tagsOrdererNew [

	<sampleInstance>
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

{ #category : #tags }
BlDragAndDropExamples class >> tagsSlidingOrderer [

	<sampleInstance>
	| aContainer  |
	aContainer := BlElement new.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	aContainer addEventHandler: (BlDropHandler new
			 acceptOnlyFromThisElement;
			 whenHorizontalSlideOverDo: [  ];
			 whenDroppedDo: [ :anItemsDroppedEvent |
				 | container position childBefore |
				 container := anItemsDroppedEvent currentTarget.
				 position := anItemsDroppedEvent position x.
				 childBefore := container children accountedByLayout
					                detect: [ :eachChild |
						                position
						                < (eachChild bounds inParent center x - 5) ]
					                ifFound: [ :eachChild | eachChild ]
					                ifNone: [ nil ].

				 (anItemsDroppedEvent items collect: [ :eachDragItem |
						  eachDragItem sourceElement ]) do: [ :each |
						 childBefore
							 ifNil: [ container addChild: each ]
							 ifNotNil: [ container addChild: each before: childBefore ] ] ]).

	aContainer addChildren:
		({ 'One'. 'Two'. 'Three'. 'Four' } collect: [ :eachName |
			 self tagOrdererSlidingTagFor: eachName ]).

	^ aContainer openInNewSpace 
]

{ #category : #'see class side' }
BlDragAndDropExamples >> seeClassSide [ 
]
