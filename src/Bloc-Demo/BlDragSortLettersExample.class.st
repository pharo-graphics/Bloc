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

	consonantsContainer dropAcceptCondition: [ :element |
		element isVowel not ].
	consonantsContainer dropAcceptBehavior: [ :element |
		element removeFromParent.
		consonantsContainer addChild: element ].
	consonantsContainer dropRejectBehavior: [ :element |
		element
			removeFromParent;
			allowMeAndChildrenMouseEvents.
		element defaultContainer addChild: element ].

	consonantsContainer dragEnterAcceptBehavior: [ :element |
		element background: Color lightGreen ].
	consonantsContainer dragEnterRejectBehavior: [ :element |
		element background: Color lightRed ].
	consonantsContainer dragLeaveBehavior: [ :element |
		element background: Color veryVeryLightGray ]
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
			 BlDragLetter new character: each; defaultContainer: lettersContainer ])
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeLettersContainer [

	lettersContainer := BlDragLetterContainer new border:
		                    (BlBorderBuilder new
			                     paint: Color gray;
			                     dashed;
			                     width: 2;
			                     build).
	lettersContainer dropAcceptBehavior: [ :element |
		element removeFromParent.
		lettersContainer addChild: element ].

	lettersContainer dragEnterAcceptBehavior: [ :element |  ].
	lettersContainer dragEnterRejectBehavior: [ :element |  ].
	lettersContainer dragLeaveBehavior: [ :element |  ]
]

{ #category : #initialization }
BlDragSortLettersExample >> initializeVowelsContainer [

	vowelsContainer := BlDragLetterContainer new background:
		                   Color lightBlue.

	vowelsContainer dropAcceptCondition: [ :element | element isVowel ].
	vowelsContainer dropAcceptBehavior: [ :element |
		element removeFromParent.
		vowelsContainer addChild: element ].
	vowelsContainer dropRejectBehavior: [ :element |
		element
			removeFromParent;
			allowMeAndChildrenMouseEvents.
		element defaultContainer addChild: element ].

	vowelsContainer dragEnterAcceptBehavior: [ :element |
		element background: Color lightGreen ].
	vowelsContainer dragEnterRejectBehavior: [ :element |
		element background: Color lightRed ].
	vowelsContainer dragLeaveBehavior: [ :element |
		element background: Color veryVeryLightGray ]
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
