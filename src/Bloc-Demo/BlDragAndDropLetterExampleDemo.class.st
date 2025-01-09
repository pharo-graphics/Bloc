"
An example of drag&drop of letters, inspired by GToolkit example, but using only bare drag&drop event.

Event are managed in this order: 
**BlDragStartEvent** -> an element is picked with mouse
**BlDragEvent** -> an element is moved
**BlDragEndEvent** -> an element is released from mouse 

When you go over a drop container, you'll **BlDragEnterEvent** and **BlDragLeaveEvent** when you quit it.
When you drop your element, you'll get a **BlDropEvent**

Note that **BlDropEvent** is fired before **BlDragEndEvent**
"
Class {
	#name : #BlDragAndDropLetterExampleDemo,
	#superclass : #Object,
	#instVars : [
		'letters',
		'dragArea',
		'vowels',
		'consonants'
	],
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExampleDemo >> consonantsDropContainer [

	consonants := self lettersSorterRoundedContainerWithBorder.
	consonants background: Color lightBlue.
	consonants addEventHandlerOn: BlDropEvent do: [ :event |
		event consumed: true.
		'consonants BlDropEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel not ])
			ifTrue: [
				'consonants drop accepted' traceCr.
				event gestureSource removeFromParent.
				event target addChild: event gestureSource ]
			ifFalse: [
				'consonants drop rejected' traceCr.
				event gestureSource
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				letters addChild: event gestureSource ] ].

	consonants addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		'consonants BlDragEnterEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel not ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	consonants addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		'consonants BlDragLeaveEvent' traceCr.
		event gestureSource background: Color veryVeryLightGray ].

	^ consonants
]

{ #category : #initialization }
BlDragAndDropLetterExampleDemo >> initDragArea [

	dragArea := BlElement new
		            id: 'dragArea';
		            border: (BlBorder paint: Color red width: 2);
		            size: 600@500.
	dragArea addChild: (BlElement new
			 layout: (BlLinearLayout horizontal cellSpacing: 30);
			 constraintsDo: [ :c |
				 c horizontal matchParent.
				 c vertical matchParent ];
			 addChildren: {
					 (self labelContainer: letters with: 'Letters to sort').
					 (self labelContainer: vowels with: 'Vowel letters').
					 (self labelContainer: consonants with: 'Consonant letters') })
]

{ #category : #initialization }
BlDragAndDropLetterExampleDemo >> initLetters [

	letters := self lettersSorterContainer.
	vowels := self vowelsDropContainer.
	consonants := self consonantsDropContainer.

	letters addChildren:
		({ $a. $c. $Q. $o. $j. $E. $y. $Z. $U. $B. $p. $i } collect: [ :each | self lettersSorterDraggableLetterFor: each ]).
]

{ #category : #initialization }
BlDragAndDropLetterExampleDemo >> initialize [

	self initLetters.
	self initDragArea.
	^ dragArea
]

{ #category : #letters }
BlDragAndDropLetterExampleDemo >> labelContainer: anElement with: aText [

	^ BlElement new
		  layout: (BlLinearLayout vertical alignTopCenter cellSpacing: 10);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChild: (BlTextElement new text: aText asRopedText);
		  addChild: anElement
]

{ #category : #letters }
BlDragAndDropLetterExampleDemo >> letterFor: aCharacter [

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
BlDragAndDropLetterExampleDemo >> lettersSorterContainer [

	^ BlElement new
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  padding: (BlInsets all: 10)
]

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExampleDemo >> lettersSorterDraggableLetterFor: aCharacter [

	| element |
	element := self letterFor: aCharacter.
	element addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		'source1 BlStartDragEvent' traceCr.
		element removeFromParent.
		dragArea addChild: element.
		element preventMeAndChildrenMouseEvents ].

	element addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consumed: true.
		'source1 BlDragEndEvent' traceCr.
		element background: Color veryVeryLightGray.
		element parent id = 'dragArea' ifTrue: [
			element removeFromParent.
			letters addChild: element.
			element allowMeAndChildrenMouseEvents ] ].

	element addEventHandlerOn: BlDragEvent do: [ :event |
		event consumed: true. "self inform:  'source1 BlDragEvent'."
		element position: event position ].

	^ element
]

{ #category : #letters }
BlDragAndDropLetterExampleDemo >> lettersSorterRoundedContainerWithBorder [


	^ self lettersSorterContainer
		  border: (BlBorderBuilder new
				   paint: Color gray;
				   dashed;
				   width: 2;
				   build);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #running }
BlDragAndDropLetterExampleDemo >> run [

	<script: 'self new openInNewSpace'>
	
]

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExampleDemo >> vowelsDropContainer [

	vowels := self lettersSorterRoundedContainerWithBorder.
	vowels background: Color lightYellow .
	vowels addEventHandlerOn: BlDropEvent do: [ :event |
		event consumed: true.
		'vowels BlDropEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel ])
			ifTrue: [
				'vowels drop accepted' traceCr.
				event gestureSource removeFromParent.
				event target addChild: event gestureSource ]
			ifFalse: [
				'vowels drop rejected' traceCr.
				event gestureSource
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				letters addChild: event gestureSource ] ].

	vowels addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		'vowels BlDragEnterEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	vowels addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		'vowels BlDragLeaveEvent' traceCr.
		event gestureSource background: Color veryVeryLightGray ].

	^ vowels
]
