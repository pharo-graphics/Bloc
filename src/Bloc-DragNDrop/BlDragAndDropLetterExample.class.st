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
	#name : #BlDragAndDropLetterExample,
	#superclass : #Object,
	#instVars : [
		'letters',
		'dragArea',
		'vowels',
		'consonants'
	],
	#category : #'Bloc-DragNDrop-example'
}

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExample >> consonantsDropContainer [

	consonants := self lettersSorterRoundedContainerWithBorder.
	consonants background: Color lightBlue.
	consonants addEventHandlerOn: BlDropEvent do: [ :event |
		event consumed: true.
		self inform: 'consonants BlDropEvent'.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel not ])
			ifTrue: [
				self inform: 'consonants drop accepted'.
				event gestureSource removeFromParent.
				event target addChild: event gestureSource ]
			ifFalse: [
				self inform: 'consonants drop rejected'.
				event gestureSource
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				letters addChild: event gestureSource ] ].

	consonants addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		self inform: 'consonants BlDragEnterEvent'.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel not ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	consonants addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		self inform: 'consonants BlDragLeaveEvent'.
		event gestureSource background: Color veryVeryLightGray ].

	^ consonants
]

{ #category : #initialization }
BlDragAndDropLetterExample >> initDragArea [

	dragArea := BlElement new
		            id: 'dragArea';
		            border: (BlBorder paint: Color red width: 2);
		            extent: 600@500.
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
BlDragAndDropLetterExample >> initLetters [

	letters := self lettersSorterContainer.
	vowels := self vowelsDropContainer.
	consonants := self consonantsDropContainer.

	letters addChildren:
		({ $a. $c. $Q. $o. $j. $E. $y. $Z. $U. $B. $p. $i } collect: [ :each | self lettersSorterDraggableLetterFor: each ]).
]

{ #category : #initialization }
BlDragAndDropLetterExample >> initialize [

	self initLetters.
	self initDragArea.
	^ dragArea
]

{ #category : #letters }
BlDragAndDropLetterExample >> labelContainer: anElement with: aText [

	^ BlElement new
		  layout: (BlLinearLayout vertical alignTopCenter cellSpacing: 10);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChild: (BlTextElement new text: aText asRopedText);
		  addChild: anElement
]

{ #category : #letters }
BlDragAndDropLetterExample >> letterFor: aCharacter [

	^ BlElement new
		  layout: BlLinearLayout horizontal alignCenter;
		  extent: 30 @ 30;
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
BlDragAndDropLetterExample >> lettersSorterContainer [

	^ BlElement new
		  layout: BlFlowLayout horizontal;
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  padding: (BlInsets all: 10)
]

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExample >> lettersSorterDraggableLetterFor: aCharacter [

	| element |
	element := self letterFor: aCharacter.
	element addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		self inform: 'source1 BlStartDragEvent'.
		element removeFromParent.
		dragArea addChild: element.
		element preventMeAndChildrenMouseEvents ].

	element addEventHandlerOn: BlDragEndEvent do: [ :event |
		event consumed: true.
		self inform: 'source1 BlDragEndEvent'.
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
BlDragAndDropLetterExample >> lettersSorterRoundedContainerWithBorder [


	^ self lettersSorterContainer
		  border: (BlBorderBuilder new
				   paint: Color gray;
				   dashed;
				   width: 2;
				   build);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #running }
BlDragAndDropLetterExample >> run [

	<script: 'self new openInNewSpace'>
	
]

{ #category : #'drag and drop handlers' }
BlDragAndDropLetterExample >> vowelsDropContainer [

	vowels := self lettersSorterRoundedContainerWithBorder.
	vowels background: Color lightYellow .
	vowels addEventHandlerOn: BlDropEvent do: [ :event |
		event consumed: true.
		self inform: 'vowels BlDropEvent'.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel ])
			ifTrue: [
				self inform: 'vowels drop accepted'.
				event gestureSource removeFromParent.
				event target addChild: event gestureSource ]
			ifFalse: [
				self inform: 'vowels drop rejected'.
				event gestureSource
					removeFromParent;
					allowMeAndChildrenMouseEvents.
				letters addChild: event gestureSource ] ].

	vowels addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		self inform: 'vowels BlDragEnterEvent'.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	vowels addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		self inform: 'vowels BlDragLeaveEvent'.
		event gestureSource background: Color veryVeryLightGray ].

	^ vowels
]
