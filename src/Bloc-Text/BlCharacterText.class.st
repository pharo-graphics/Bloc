"
I am a special type of `name=BlText` with a guarantee that every item is a character.
{{gtClass:name=BlCharacterText} is designed to be polymorphic with ${class:name=WideString}}, e.g. I can be compared with it (""text = string"" and ""string = text"").

Similar to the String I can not modified (insertion or deletions). Therefore 

"
Class {
	#name : #BlCharacterText,
	#superclass : #BlReadonlyText,
	#category : #'Bloc-Text-Text'
}

{ #category : #comparing }
BlCharacterText >> = anObject [
	| myIterator |
	self == anObject
		ifTrue: [ ^ true ].

	"I can be compared with BlText or other collections"
	((anObject isKindOf: Collection)
		or: [ anObject isKindOf: BlText ])
			ifFalse: [ ^ false ].
			
	self size ~= anObject size
		ifTrue: [ ^ false ].

	myIterator := self iterator.
	
	anObject do: [ :eachObjectItem |
		| myCurrentCharacter |
		myIterator hasNext
			ifFalse: [ ^ false ].
		
		myCurrentCharacter := myIterator next asCharacter.
		myCurrentCharacter ~= eachObjectItem
			ifTrue: [ ^ false ] ].

	^ true
]

{ #category : #accessing }
BlCharacterText >> at: anIndex [
	"Return a character at a given index"
	<return: #Character>
	
	^ (super at: anIndex) asCharacter
]

{ #category : #accessing }
BlCharacterText >> basicAt: anIndex [
	"Return an integer representation of the character at a given index"
	<return: #Integer>

	^ (self at: anIndex) asInteger
]

{ #category : #'text - copying' }
BlCharacterText >> copyFrom: aStartIndex to: anEndIndex [
	"For performance reasons I do not return a copy of the text because I am immutable. This speeds up parser by an order of magnitude.
	
	README: For compatibility reasons with the rest of the system we allow aStartIndex to be bigger than anEndIndex and also bigger than self size"
	<return: #BlText>

	aStartIndex > anEndIndex
		ifTrue: [ ^ self empty ].

	^ (self from: aStartIndex to: anEndIndex) characters
]

{ #category : #'text - enumeration' }
BlCharacterText >> do: aBlock [
	"Evaluate aBlock with every character as argument"
	
	self text do: [ :eachItem | aBlock value: eachItem asCharacter ]
]

{ #category : #'text - enumeration' }
BlCharacterText >> from: aFromIndex to: aToIndex do: aBlock [
	"Evaluate aBlock with every character as argument within interval [aFromIndex, aToIndex]"
	
	self text from: aFromIndex to: aToIndex do: [ :eachItem | aBlock value: eachItem asCharacter ]
]

{ #category : #comparing }
BlCharacterText >> hash [
	| hash low |
	hash := self class hash bitAnd: 16rFFFFFFF.
	self do: [ :each |
		hash := hash + each asInteger.
		"Begin hashMultiply"
		low := hash bitAnd: 16383.
		hash := (16r260D * low + ((16r260D * (hash // 16384) + (16r0065 * low) bitAnd: 16383) * 16384)) bitAnd: 16r0FFFFFFF ].
	^ hash
]

{ #category : #'string - compatibility' }
BlCharacterText >> isByteString [
	^ false
]

{ #category : #'string - compatibility' }
BlCharacterText >> isString [
	^ true
]

{ #category : #'string - compatibility' }
BlCharacterText >> trimBoth [
	"Trim separators from both sides of the receiving string."
	
	^ self trimmer bothSeparators trimmed
]

{ #category : #'string - compatibility' }
BlCharacterText >> withoutTrailingNewlines [
	"Return a copy of the receiver with any combination of cr/lf characters at the end removed"
	<return: #BlCharacterText>

	^ self trimmer rightLineBreaks trimmed
]
