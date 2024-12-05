"
# Text model

I am a data structure independent text abstraction.

I define a public API of the text model. User must only talk with me using provided methods. My subclasses provide implementation based on concrete data structures, for example rope or string.

I only store string and corresponding attributes. I don't know anything about text layout or paragraphs. I should be used together with `BlTextParagraph` in order to be measured, layered out and rendered. 

Once a piece of string is converted `name=BlText` users must not make any assumption on the internat structure of that string inside of the text. For example I replace all occurrences of `CrLf` with a special marker that is exactly one item instead of two characters (`Cr` and `Lf`)

I provide a fluent text styling api:

```
| text |
text := 'Hello world' asRopedText.
(text from: 1 to: 5) foreground: Color blue.
(text from: 7 to: 11) foreground: Color red.
text	
```

## Attributes

- `BlTextUnderlineAttribute`

"
Class {
	#name : #BlText,
	#superclass : #Object,
	#traits : 'TBlDebug + TBlTextStyleable',
	#classTraits : 'TBlDebug classTrait + TBlTextStyleable classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'Bloc-Text-Text'
}

{ #category : #accessing }
BlText class >> empty [
	^ BlEmptyText uniqueInstance
]

{ #category : #'text - modifications' }
BlText >> , aText [
	self append: aText
]

{ #category : #'text - enumeration' }
BlText >> allSatisfy: aBlock [
	"Evaluate aBlock with all text items.
	If aBlock returns false for any element return false, otherwise return true"
	<return: #Boolean>

	self do: [ :anItem | (aBlock value: anItem)
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
	"Evaluate aBlock with all text items.
	If aBlock returns true for any element return true, otherwise return false"
	<return: #Boolean>
	
	self do: [ :anItem | (aBlock value: anItem)
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'text - modifications' }
BlText >> append: aText [
	self insertText: aText at: self size
]

{ #category : #'text - modifications' }
BlText >> appendString: aString [
	self insertString: aString at: self size
]

{ #category : #'text - converting' }
BlText >> asArray [
    ^ Array streamContents: [ :aStream |
		self do: [ :anItem | aStream nextPut: anItem ] ]
]

{ #category : #'text - converting' }
BlText >> asString [
	"I return an original String representaion of this text.
	It is guaranteed that the size of the resulting string is the same as of this text"

	^ String streamContents: [ :aStream |
		self do: [ :aCharacter | aStream nextPut: aCharacter ] ]
]

{ #category : #'text - accessing' }
BlText >> at: anIndex [
	"Return an item at a given index"
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> attribute: aTextAttribute [
	"Apply a given attribute on the whole text"

	self attributes: { aTextAttribute }
]

{ #category : #'text - attributes' }
BlText >> attribute: aTextAttribute from: aStart to: anEnd [
	"Apply a given attribute on the text from aStart to anEnd"

	self attributes: { aTextAttribute } from: aStart to: anEnd
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
BlText >> attributesAndIndicesDo: aBlock [
	self attributesFinder
		attributesAndIndicesDo: aBlock
]

{ #category : #'text - attributes' }
BlText >> attributesAndIndicesSuchThat: aFilterBlock [
	^ self attributesFinder
		attributesAndIndicesSuchThat: aFilterBlock
]

{ #category : #'text - attributes' }
BlText >> attributesAndIndicesSuchThat: aFilterBlock do: aBinaryBlock [
	(self attributesAndIndicesSuchThat: aFilterBlock) do: [ :assoc | aBinaryBlock value: assoc key value: assoc value ].
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
BlText >> attributesDo: aBlock [
	"Evaluate a block with all attributes for each text item"
	| anIterator |
	
	anIterator := self iterator.
	
	"even if there is no next we should still ask for attributes, so we start from `do`"
	[ aBlock cull: anIterator attributes cull: anIterator position ]
		doWhileTrue: [
			| hasNext |
			hasNext := anIterator hasNext.
			anIterator hasNext
				ifTrue: [ anIterator next ].
			hasNext ]
]

{ #category : #'text - attributes' }
BlText >> attributesFinder [
	^ self subclassResponsibility
]

{ #category : #'text - copying' }
BlText >> characters [
	<return: #BlCharacterText>

	^ BlCharacterText text: self
]

{ #category : #'text - attributes' }
BlText >> clearAttributes: aBlock [
	self clearAttributes: (1 min: self size) to: self size if: aBlock
]

{ #category : #'text - attributes' }
BlText >> clearAttributes: aStart to: anEnd if: aBlock [
	self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> clearAttributesOfClass: aBlTextAttributeClass [
	self clearAttributes: [ :eachAttribute | eachAttribute isKindOf: aBlTextAttributeClass ]
]

{ #category : #'text - enumeration' }
BlText >> collect: aBlock [
	"Evaluate aBlock with each of the text's items as the argument.  
	Collect the resulting values into a collection like the receiver. Answer the new collection."

	^ Array streamContents: [ :aStream |
		self do: [ :anItem | aStream nextPut: (aBlock value: anItem) ] ]
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

{ #category : #'text - copying' }
BlText >> copyWithoutExternalReferences [
	<return: #BlText>

	^ (self copyFrom: 1 to: self size)
		clearAttributes: [ :eachAttribute | eachAttribute mayHaveExternalReferences ];
		yourself.
]

{ #category : #'text - modifications' }
BlText >> delete: aStart to: anEnd [
	self deleteAll: { (aStart to: anEnd) }
]

{ #category : #'text - modifications' }
BlText >> deleteAll [
	self ifEmpty: [ ^ self ].
	self delete: (1 min: self size) to: self size
]

{ #category : #'text - modifications' }
BlText >> deleteAll: aCollectionOfIntervals [
	self subclassResponsibility
]

{ #category : #'text - enumeration' }
BlText >> do: aBlock [
	"Evaluate aBlock with every item as argument.
	We do not guarantee that all items of this text are Characters. Some items may be special objects such as line breaks.
	Basically, you should never assume a type of the argument with which aBlock will be evaluated"

	self subclassResponsibility
]

{ #category : #'text - accessing' }
BlText >> empty [
	"Return a similar (the same backend data structure) but empty text"
	<return: #BlText>

	^ self subclassResponsibility
]

{ #category : #'text - converting' }
BlText >> encodeOn: aWriteStream with: aZnCharacterEncoder [
	"Encode myself on a ByteString stream using the provided Zinc encoder."
	
	self subclassResponsibility 
]

{ #category : #'text - notifying' }
BlText >> ensureAnnouncer [

	announcer ifNil: [ announcer := BlTextAnnouncer new ]
]

{ #category : #comparing }
BlText >> equals: anObject [
	| myIterator otherIterator areSame |

	self == anObject
		ifTrue: [ ^ true ].

	(anObject isKindOf: BlText)
		ifFalse: [ ^ false ].
			
	self size ~= anObject size
		ifTrue: [ ^ false ].

	myIterator := self iterator.
	otherIterator := anObject iterator.

	areSame := true.
	[ areSame and: [ myIterator hasNext and: [ otherIterator hasNext ] ] ]
		whileTrue: [
			areSame :=
				myIterator next = otherIterator next
					and: [ myIterator attributes asSet = otherIterator attributes asSet ] ].

	areSame := areSame and: [ myIterator hasNext not and: [ otherIterator hasNext not ] ].
	^ areSame
]

{ #category : #'text - attributes' }
BlText >> findAttribute: aBlTextAttribute indicesDo: aBlock [	
	self attributesFinder
		findAttribute: aBlTextAttribute
		indicesDo: aBlock
]

{ #category : #'text - attributes' }
BlText >> findAttributes: aCollectionOfBlTextAttribute indicesDo: aBlock [
	self attributesFinder
		findAttributes: aCollectionOfBlTextAttribute
		indicesDo: aBlock
]

{ #category : #'text - attributes' }
BlText >> findAttributesSuchThat: aFilterBlock indicesDo: anIterationBlock [

	self attributesFinder
		findAttributesSuchThat: aFilterBlock
		indicesDo: anIterationBlock
]

{ #category : #'text - enumeration' }
BlText >> finder [

	^ BlPositionFinder new
		  text: self;
		  yourself
]

{ #category : #'text - accessing' }
BlText >> first [
	<return: #Object>
	
	^ self at: 1
]

{ #category : #'text - accessing' }
BlText >> first: aNumber [
	<return: #BlRope>
	^ self from: 1 to: aNumber
]

{ #category : #'text - accessing' }
BlText >> from: aStart to: anEnd [
	"Create and return a subtext of this text form aStart to anEnd.
	Note: All modifications that are happening to the subtext automatically
	applied on this original text"
	
	^ BlSubText text: self from: aStart to: anEnd
]

{ #category : #'text - enumeration' }
BlText >> from: aFromIndex to: aToIndex do: aBlock [
	"Evaluate aBlock with every item as argument within interval [aFromIndex, aToIndex]"
	
	self subclassResponsibility
]

{ #category : #'text - copying' }
BlText >> generation [
	"Return an object that uniquely represents this generation of text"
	<return: #Object>

	^ self subclassResponsibility
]

{ #category : #'text - attributes' }
BlText >> hasAttribute: aBlTextAttribute [
	<return: #Boolean>

	^ self attributesFinder
		hasAttribute: aBlTextAttribute
]

{ #category : #'text - attributes' }
BlText >> hasAttributeSuchThat: aComparisonBlock [
	<return: #Boolean>

	^ self attributesFinder
		hasAttributeSuchThat: aComparisonBlock
]

{ #category : #'text - testing' }
BlText >> ifEmpty: aBlock [
	"Evaluate the given block, answering its value if the receiver is empty, otherwise answer the receiver."

	"Note that the fact that this method returns its receiver in case the receiver is not empty allows one to write expressions like the following ones: self classifyMethodAs: (myProtocol ifEmpty: ['As yet unclassified'])"

	^ self isEmpty
		ifTrue: aBlock
		ifFalse: [ self ]
]

{ #category : #'text - testing' }
BlText >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise"
	"If the notEmptyBlock has an argument, eval with the receiver as its argument"

	^ self isEmpty
		ifTrue: emptyBlock
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'text - testing' }
BlText >> ifNotEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
    unless the receiver is empty, in which case answer the receiver."

	^ self isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #'text - testing' }
BlText >> ifNotEmpty: notEmptyBlock ifEmpty: emptyBlock [
	"Evaluate emptyBlock if I'm empty, notEmptyBlock otherwise
	 If the notEmptyBlock has an argument, eval with the receiver as its argument"

	^ self isEmpty
		ifTrue: emptyBlock
		ifFalse: [ notEmptyBlock cull: self ]
]

{ #category : #'text - modifications' }
BlText >> insertString: aString at: anIndex [
	self
		insertStrings: { aString }
		atAll: { anIndex }
]

{ #category : #'text - modifications' }
BlText >> insertStrings: aCollectionOfStrings atAll: aCollectionOfIndices [
	self subclassResponsibility
]

{ #category : #'text - modifications' }
BlText >> insertText: aString at: anIndex [
	^ self subclassResponsibility
]

{ #category : #copying }
BlText >> internalRepresentation [

	" gives direct acces to how the text is privately represented - to be used with caution for optimization purpose"
	^ self subclassResponsibility 
]

{ #category : #'text - testing' }
BlText >> isEmpty [
	"Return true if this text is empty, false otherwise.
	Note: Override me to provide performance optimized implementation"

	^ self subclassResponsibility
]

{ #category : #'text - testing' }
BlText >> isNotEmpty [
	^ self isEmpty not
]

{ #category : #'text - enumeration' }
BlText >> iterator [
	"Return an iterator pointing to the first text item limited only by the text size"
	<return: #BlTextIterator>

	^ self subclassResponsibility
]

{ #category : #'text - enumeration' }
BlText >> iterator: aStartIndex to: anEndIndex [
	"Return an iterator pointing to the item at anStartIndex and limited by anEndIndex"
	<return: #BlTextIterator>

	^ self subclassResponsibility
]

{ #category : #'text - accessing' }
BlText >> last [
	<return: #Object>
	
	^ self at: self size
]

{ #category : #'text - copying' }
BlText >> nextGeneration [
	"Return a copy of this text marked as a next generation of this one"
	<return: #BlGenerationText>
	
	^ BlGenerationText fromText: self
]

{ #category : #'text - notifying' }
BlText >> notifyAttributeAdded: anAttribute from: aFromIndex to: aToIndex [
	self announcerDo: [ :anAnnouncer | anAnnouncer
		announce: (BlTextAttributeAdded attribute: anAttribute from: aFromIndex to: aToIndex) ]
]

{ #category : #'text - notifying' }
BlText >> notifyAttributesRemovedFrom: aFromIndex to: aToIndex [
	self announcerDo: [ :anAnnouncer | anAnnouncer
		announce: (BlTextAttributesRemoved from: aFromIndex to: aToIndex) ]
]

{ #category : #'text - notifying' }
BlText >> notifyDeletedAll: theDeletedIntervals requested: theRequestedIntervals texts: theDeletedTexts [

	theDeletedIntervals ifEmpty: [ ^ self ].

	theRequestedIntervals ifEmpty: [ ^ self ].

	theDeletedTexts ifEmpty: [ ^ self ].

	self announcerDo: [ :anAnnouncer | 
		anAnnouncer announce: (BlTextsDeleted new
				 texts: theDeletedTexts;
				 requestedIntervals: theRequestedIntervals;
				 finalIntervals: theDeletedIntervals) ]
]

{ #category : #'text - notifying' }
BlText >> notifyStringsInserted: aCollectionOfStrings atAll: aCollectionOfFinalIndices requested: aCollectionOfRequestedIndices [
	aCollectionOfStrings
		ifEmpty: [ ^ self ].
		
	aCollectionOfFinalIndices
		ifEmpty: [ ^ self ].
		
	aCollectionOfRequestedIndices
		ifEmpty: [ ^ self ].

	self announcerDo: [ :anAnnouncer |
		| aNonEmptyCollectionOfStrings aNonEmptyCollectionOfFinalIndices aNonEmptyCollectionOfRequestedIndices |
		
		aNonEmptyCollectionOfStrings := Array streamContents: [ :aStreamCollectionOfStrings |
			aNonEmptyCollectionOfFinalIndices := Array streamContents: [ :aStreamCollectionOfFinalIndices |
				aNonEmptyCollectionOfRequestedIndices := Array streamContents: [ :aStreamCollectionOfRequestedIndices |
					aCollectionOfStrings withIndexDo: [ :eachString :eachIndex |
						eachString ifNotEmpty: [
							aStreamCollectionOfStrings nextPut: eachString.
							aStreamCollectionOfFinalIndices nextPut: (aCollectionOfFinalIndices at: eachIndex).
							aStreamCollectionOfRequestedIndices nextPut: (aCollectionOfRequestedIndices at: eachIndex)
						]
					].
				]
			]
		].
	
		aNonEmptyCollectionOfStrings
			ifEmpty: [ ^ self ].
	
		anAnnouncer
			announce: (BlTextStringsInserted new
				strings: aNonEmptyCollectionOfStrings;
				requestedIndices: aNonEmptyCollectionOfFinalIndices ;
				finalIndices: aNonEmptyCollectionOfFinalIndices) ]
]

{ #category : #copying }
BlText >> postCopy [

	announcer := nil
]

{ #category : #'text - printing' }
BlText >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.
	BlTextNonPrintableCharacterPrinter print: self on: aStream.
	aStream nextPut: $).

]

{ #category : #'text - printing' }
BlText >> printOn: aWriteStream from: aStart to: anEnd [
	self
		from: aStart
		to: anEnd
		do: [ :anItem |
			anItem isCharacter
				ifTrue: [ aWriteStream nextPut: anItem ]
				ifFalse: [ aWriteStream print: anItem ] ]
]

{ #category : #'text - enumeration' }
BlText >> readStream [
	"Compatibility with ${method:SequenceableCollection>>#readStream}$"
	^ BlTextReadStream new iterator: self iterator
]

{ #category : #'text - copying' }
BlText >> readonly [

	"Return a readonly version of this text"

	^ BlReadonlyText text: self
]

{ #category : #'text - attributes' }
BlText >> removeAttribute: aBlTextAttribute [
	self removeAttributes: { aBlTextAttribute }
]

{ #category : #'text - attributes' }
BlText >> removeAttributes: aCollectionOfAttributes [
	| theAttributesToRemove |
	
	theAttributesToRemove := aCollectionOfAttributes asIdentitySet.
	self clearAttributes: [ :eachAttribute | theAttributesToRemove includes: eachAttribute ]
]

{ #category : #'text - modifications' }
BlText >> replace: aStart to: anEnd withString: aString [
	self delete: aStart to: anEnd.
	self insertString: aString at: aStart
]

{ #category : #'text - accessing' }
BlText >> second [
	<return: #Object>
	
	^ self at: 2
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

{ #category : #copying }
BlText >> takeInternalRepresentationOf: anotherText [

	" To be used with caution because the receiver and the argument text must have the same internal representation"
	self subclassResponsibility 
]

{ #category : #'text - accessing' }
BlText >> textOffset [
	"Return absolute text offset to better deal with sub-texts"
	<return: #Number>
	
	^ 0
]

{ #category : #'text - accessing' }
BlText >> third [
	<return: #Object>
	
	^ self at: 3
]

{ #category : #'text - modifications' }
BlText >> trimmer [

	^ BlTextTrimmer new
		  text: self;
		  yourself
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

{ #category : #'text - converting' }
BlText >> utf8Encoded [
	"Answer a ByteArray encoding the receiver using UTF-8."

	^ ByteArray new: (self size + 2) * 4 streamContents: [ :stream |
		self
			encodeOn: stream
			with: ZnUTF8Encoder default ]
]

{ #category : #'text - notifying' }
BlText >> when: anAnnouncementClass do: aValuable [
	"Extracted on Pharo12's implementation."

	| subscriberForDeprecation |
	aValuable receiver ifNil: [
		self error:
			'You must specify a subscriber object for this subscription. Please use #when:do:for: method.' ].

	subscriberForDeprecation := thisContext sender receiver = aValuable receiver
		                            ifTrue: [ 'self' ]
		                            ifFalse: [ '`@arg2 receiver' ].
	self
		deprecated:
			'Since there are some block closures (Clean and Constant) without a receiver, the API of announcements was changed to send the subscriber explicitly. 
			We are deprecating this method because it was asking for the receiver of the block to use it as the subscriber.'
		transformWith: '`@receiver when: `@arg1 do: `@arg2'
			->
			('`@receiver when: `@arg1 do: `@arg2 for: '
			 , subscriberForDeprecation).

	self when: anAnnouncementClass do: aValuable for: aValuable receiver
]

{ #category : #'text - notifying' }
BlText >> when: anAnnouncementClass do: aValuable for: aSubscriber [

	self ensureAnnouncer.
	announcer when: anAnnouncementClass do: aValuable for: aSubscriber
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
		self do: [ :anItem |
			aStream nextPut: (elementAndIndexBlock value: anItem value: anIndex).
			anIndex := anIndex + 1 ] ]
]

{ #category : #'text - copying' }
BlText >> writable [
	"Convert me to a writable text if I am readonly"
	<return: #BlText>
	
	^ self
]
