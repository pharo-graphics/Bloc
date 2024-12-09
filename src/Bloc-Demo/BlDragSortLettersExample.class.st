Class {
	#name : #BlDragSortLettersExample,
	#superclass : #BlElement,
	#instVars : [
		'lettersContainer',
		'consonantsContainer',
		'vowelsContainer'
	],
	#category : #'Bloc-Demo-DragAndDrop'
}

{ #category : #accessing }
BlDragSortLettersExample >> consonantsContainer [ 

	^ consonantsContainer 
]

{ #category : #initialization }
BlDragSortLettersExample >> initialize [

	super initialize.
	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	self layout: (BlLinearLayout horizontal cellSpacing: 50).
	self padding: (BlInsets all: 20).

	self initializeContainers.
	self initializeLetters 
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeConsonantsContainer [

	consonantsContainer := BlDragLetterContainer new background:
		                       Color lightOrange.
		
	consonantsContainer addEventHandlerOn: BlDropEvent do: [ :event |
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
				lettersContainer addChild: event gestureSource ] ].

	consonantsContainer addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		'consonants BlDragEnterEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel not ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	consonantsContainer addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		'consonants BlDragLeaveEvent' traceCr.
		event gestureSource background: Color veryVeryLightGray ].
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeContainers [ 

	self initializeLettersContainer.
	self initializeVowelsContainer.
	self initializeConsonantsContainer.
	
	self addChild: (self labelContainer: lettersContainer with: 'Letters to sort').
	self addChild: (self labelContainer: vowelsContainer with: 'Vowel letters').
	self addChild: (self labelContainer: consonantsContainer with: 'Consonant letters')
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeLetters [

	lettersContainer addChildren:
		({ $a. $c. $Q. $o. $j. $E. $y. $Z. $U. $B. $p. $i } collect: [ :each |
			 BlDragLetter new character: each ])

	
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeLettersContainer [

	lettersContainer := BlDragLetterContainer new border:
		                    (BlBorderBuilder new
			                     paint: Color gray;
			                     dashed;
			                     width: 2;
			                     build).
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeVowelsContainer [

	vowelsContainer := BlDragLetterContainer new background:
		                   Color lightBlue.

	vowelsContainer addEventHandlerOn: BlDropEvent do: [ :event |
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
				lettersContainer addChild: event gestureSource ] ].

	vowelsContainer addEventHandlerOn: BlDragEnterEvent do: [ :event |
		event consumed: true.
		'vowels BlDragEnterEvent' traceCr.
		(event gestureSource firstChild text first isCharacter and: [
			 event gestureSource firstChild text first isVowel ])
			ifTrue: [ event gestureSource background: Color lightGreen ]
			ifFalse: [ event gestureSource background: Color lightRed ] ].

	vowelsContainer addEventHandlerOn: BlDragLeaveEvent do: [ :event |
		event consumed: true.
		'vowels BlDragLeaveEvent' traceCr.
		event gestureSource background: Color veryVeryLightGray ]
]

{ #category : #letters }
BlDragSortLettersExample >> labelContainer: anElement with: aText [

	^ BlElement new
		  layout: (BlLinearLayout vertical alignTopCenter cellSpacing: 10);
		  constraintsDo: [ :c |
			  c horizontal matchParent.
			  c vertical matchParent ];
		  addChild: (BlTextElement new text: aText asRopedText);
		  addChild: anElement
]

{ #category : #accessing }
BlDragSortLettersExample >> lettersContainer [

	^ lettersContainer 
]

{ #category : #running }
BlDragSortLettersExample >> run [ 

	<script: 'self new openInSpace'>
]

{ #category : #accessing }
BlDragSortLettersExample >> vowelsContainer [ 

	^ vowelsContainer 
]
