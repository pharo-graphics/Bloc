"
I am a data structure independent text abstraction.

I define a public API of the text model. User must only talk with me using provided methods. My subclasses provide implementation based on concrete data structures, for example rope or string.

I only store string and corresponding attributes. I don't know anything about text layout or paragraphs. I should be used together with BrTextParagraph in order to be measured, layered out and rendered. 

I provide a fluent text styling api:

[[[
| text |
text := 'Hello world' asRopedText.
(text from: 1 to: 5) foreground: Color blue.
(text from: 7 to: 11) foreground: Color red.
text	
]]]
"
Class {
	#name : #BlText,
	#superclass : #Object,
	#traits : 'TBlDebug + TBlTextStyleable',
	#classTraits : 'TBlDebug classTrait + TBlTextStyleable classTrait',
	#instVars : [
		'announcer',
		'locked'
	],
	#category : 'Bloc-Text-Text'
}

{ #category : #accessing }
BlText class >> empty [
	^ BlEmptyText uniqueInstance
]

{ #category : #'text - enumeration' }
BlText >> allSatisfy: aBlock [
	"Evaluate aBlock with all text character's.
	If aBlock returns false for any element return false, otherwise return true"
	<return: #Boolean>

	self do: [ :aCharacter | (aBlock value: aCharacter)
		ifFalse: [ ^ false] ].
	^ true
]

{ #category : #'text - notifying' }
BlText >> announcerDo: aBlockClosure [
	"Evaluate a given block closure with an announcer as an argument if it is initialized"
	announcer ifNotNil: aBlockClosure
]

{ #category : #'text - enumeration' }
BlText >> anySatisfy: aBlock [
	"Evaluate aBlock with all text character's.
	If aBlock returns true for any element return true, otherwise return false"
	<return: #Boolean>
	
	self do: [ :aCharacter | (aBlock value: aCharacter)
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'text - converting' }
BlText >> asString [
    ^ self printStringLimitedTo: Float infinity
]

{ #category : #'text - accessing' }
BlText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> attribute: aTextAttribute [
	"Apply a given attribute on the whole text"

	self attributes: { aTextAttribute }
]

{ #category : #'text - attributes' }
BlText >> attributes: anAttributesCollection [
	"Apply given attributes on the whole text"

	self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> attributes: anAttributesCollection from: aStart to: anEnd [
	"Apply given attributes on the text from aStart to anEnd"

	self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> attributesAt: anIndex [
	"Return a collection of text attributes without duplicates at a given text index"
	<return: #Collection of: #BlTextAttribute>

	^ (self iterator: anIndex to: anIndex) attributes
]

{ #category : #accessing }
BlText >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ self
]

{ #category : #'text - attributes' }
BlText >> clearAttributes: aBlock [
	self clearAttributes: (1 min: self size) to: self size if: aBlock
]

{ #category : #'text - attributes' }
BlText >> clearAttributes: aStart to: anEnd if: aBlock [
	self subclassResponsibility
]

{ #category : #'text - enumeration' }
BlText >> collect: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Collect the resulting values into a collection like the receiver. Answer  
	the new collection."

	^ Array streamContents: [ :aStream |
		self do: [ :aCharacter | aStream nextPut: (aBlock value: aCharacter) ] ]
]

{ #category : #'text - copying' }
BlText >> copyFrom: aStartIndex to: anEndIndex [
	"Create a copy of this text within a given indices interval.
	Note: I am different from ==#from:to:== in a sense that I don't create a sub-text that points
	to the original text, I create an independent copy which can be safely used in text editors and other tools.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size."
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'text - modifications' }
BlText >> delete: aStart to: anEnd [
	self subclassResponsibility
]

{ #category : #'text - enumeration' }
BlText >> do: aBlock [
	"Evaluate aBlock with every character as argument"
	
	self subclassResponsibility
]

{ #category : #'text - accessing' }
BlText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'text - notifying' }
BlText >> ensureAnnouncer [
	announcer ifNil: [ announcer := BlTextAnnouncer new ]
]

{ #category : #'text - enumeration' }
BlText >> finder [
	^ BlPositionFinder new text: self.
]

{ #category : #'text - accessing' }
BlText >> first [
	<return: #Character>
	
	^ self at: 1
]

{ #category : #'text - accessing' }
BlText >> from: aStart to: anEnd [
	"Create and return a subtext of this text form aStart to anEnd.
	Note: All modifications that are happening to the subtext automatically
	applied on this original text"
	<return: #BlSubText>

	^ BlSubText text: self from: aStart to: anEnd
]

{ #category : #'text - enumeration' }
BlText >> from: aFromIndex to: aToIndex do: aBlock [
	"Evaluate aBlock with every character as argument within interval [aFromIndex, aToIndex]"
	
	self subclassResponsibility
]

{ #category : #'text - copying' }
BlText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlText >> initialize [
	super initialize.
	
	locked := false
]

{ #category : #'text - modifications' }
BlText >> insertString: aString at: anIndex [
	self subclassResponsibility
]

{ #category : #'text - modifications' }
BlText >> insertText: aString at: anIndex [
	^ self subclassResponsibility
]

{ #category : #'text - testing' }
BlText >> isEmpty [
	"Return true if this text is empty, false otherwise.
	Note: Override me to provide performance optimized implementation"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'text - lock' }
BlText >> isLocked [
	"Return true if text is locked, false otherwise"
	<return: #Boolean>

	^ locked
]

{ #category : #'text - testing' }
BlText >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #'text - enumeration' }
BlText >> iterator [
	"Return an iterator pointing to the first text item (character) limited only by the text size"
	<return: #BlTextIterator>

	^ self subclassResponsibility
]

{ #category : #'text - enumeration' }
BlText >> iterator: aStartIndex to: anEndIndex [
	"Return an iterator pointing to the character at anStartIndex and limited by anEndIndex"
	<return: #BlTextIterator>

	^ self subclassResponsibility
]

{ #category : #'text - accessing' }
BlText >> last [
	<return: #Character>
	
	^ self at: self size
]

{ #category : #'text - lock' }
BlText >> lock [
	"Lock text. Any modification results in undefined behaviour"

	locked := true
]

{ #category : #'text - lock' }
BlText >> lockDuring: aBlock [
	"Prevent any text modifications while evaluating a given block"
	| wasLocked |

	wasLocked := self isLocked.
	self lock.
	aBlock ensure: [ wasLocked ifFalse: [ self unlock ] ]
]

{ #category : #'text - copying' }
BlText >> nextGeneration [
	"Return a copy of this text marked as a next generation of this one"
	<return: #BlGenerationText>
	
	^ BlGenerationText fromText: self
]

{ #category : #'text - notifying' }
BlText >> notifyDeleted: aFromIndex to: aToIndex [
	self announcerDo: [ :anAnnouncer | anAnnouncer announce: (BlTextDeleted from: aFromIndex to: aToIndex) ]
]

{ #category : #'text - notifying' }
BlText >> notifyStringInserted: aString at: anIndex [
	self announcerDo: [ :anAnnouncer | anAnnouncer announce: (BlTextStringInserted string: aString at: anIndex) ]
]

{ #category : #'text - printing' }
BlText >> printOn: aStream [
	 [ self do: [ :aChar | aStream nextPut: aChar ] ]
		on: Error do: [ :e | aStream nextPutAll: e description ]
]

{ #category : #'text - printing' }
BlText >> putOn: aWriteStream from: aStart to: anEnd [
	self
		from: aStart
		to: anEnd
		do: [ :aChar | aWriteStream nextPut: aChar ]
]

{ #category : #'text - copying' }
BlText >> readonly [
	"Return a readonly version of this text"
	<return: #BlReadonlyText>

	^ BlReadonlyText text: self
]

{ #category : #'text - accessing' }
BlText >> size [
	<return: #Number>

	^ self subclassResponsibility
]

{ #category : #'text - attributes style' }
BlText >> styler [
	<return: #BlTextAttributesStyler>

	^ BlTextAttributesStyler on: self
]

{ #category : #'text - attributes style' }
BlText >> stylerDo: aBlock [
	"I allow users to apply attributes in a bulk fashion with the help of text attributes styler.

	Example:
	[[[
		| text |
		text := 'Hi John' asRopedText.
		text stylerDo: [ :aStyler | aStyler bold italic foreground: Color red ].
	]]]"
	| aStyler |
	
	aStyler := self styler.
	aBlock value: aStyler.
	aStyler style
]

{ #category : #'text - notifying' }
BlText >> suspendAnnouncementsWhile: aBlock [
	announcer
		ifNil: aBlock
		ifNotNil: [ :anAnnouncer | anAnnouncer suspendAllWhile: aBlock ]
]

{ #category : #'text - accessing' }
BlText >> textOffset [
	"Return absolute text offset to better deal with sub-texts"
	<return: #Number>
	
	^ 0
]

{ #category : #'text - modifications' }
BlText >> trimmer [
	^ BlTextTrimmer new text: self.
]

{ #category : #'text - lock' }
BlText >> unlock [
	"Unlock text. Now I can be modified"

	locked := false
]

{ #category : #'text - attributes' }
BlText >> unstyle [
	"Clear all style related attributes"

	self unstyle: (1 min: self size) to: self size
]

{ #category : #'text - attributes' }
BlText >> unstyle: aFromIndex to: aToIndex [
	"Clear all style related attributes within interval defined by from and to indices"

	self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> unstyled [
	"Return a copy of a text without any style attributes"
	<return: #BlText>

	^ self copy unstyle
]

{ #category : #'text - notifying' }
BlText >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	self announcerDo: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'text - notifying' }
BlText >> when: anAnnouncementClass do: aValuable [
	self ensureAnnouncer.
	announcer when: anAnnouncementClass do: aValuable
]

{ #category : #'text - notifying' }
BlText >> when: anAnnouncementClass send: aSelector to: anObject [
	self ensureAnnouncer.
	announcer weak when: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #'text - enumeration' }
BlText >> withIndexCollect: elementAndIndexBlock [ 
	"Just like with:collect: except that the iteration index supplies the second argument to the block."

	^ Array streamContents: [ :aStream |
		| anIndex |
		anIndex := 1.
		self do: [ :aCharacter |
			aStream nextPut: (elementAndIndexBlock value: aCharacter value: anIndex).
			anIndex := anIndex + 1 ] ]
]

{ #category : #'text - copying' }
BlText >> writable [
	"Convert me to a writable text if I am readonly"
	<return: #BlText>
	
	^ self
]
