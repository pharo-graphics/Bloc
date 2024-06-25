"
I represent a compulsory ""AND"" combination of multiple distinct keys. (conjunction)
I am useful when there is a need to create a key combination that should be matched when all subcombinations are matching.

Example of a key combination that matches then and only then when both ""arrowLeft"" and ""W"" are pressed:

BlCompulsoryCombination new
	key: Key arrowLeft;
	key: Key w;
	yourself

Unified meta (cmd):

BlCompulsoryCombination new
	with: (BlSingleKeyCombination key: Key arrowLeft);
	with: (BlSingleKeyCombination key: Key w);
	yourself

"
Class {
	#name : #BlCompulsoryCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'combinations'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #comparing }
BlCompulsoryCombination >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ combinations = anObject combinations
]

{ #category : #visiting }
BlCompulsoryCombination >> accept: aKeyCombinationVisitor [
	^ aKeyCombinationVisitor visitCompulsory: self
]

{ #category : #controlling }
BlCompulsoryCombination >> and: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ self with: anotherKeyCombination
]

{ #category : #converting }
BlCompulsoryCombination >> asBufferKeys [
	^ combinations flatCollect: [ :eachCombination | eachCombination asBufferKeys ] as: Set
]

{ #category : #accessing }
BlCompulsoryCombination >> combinations [
	<return: #SequenceableCollection of: #BlKeyCombination>
	
	^ combinations
]

{ #category : #comparing }
BlCompulsoryCombination >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ combinations hash
]

{ #category : #testing }
BlCompulsoryCombination >> includes: aKey [
	^ self combinations anySatisfy: [ :aCombination | aCombination includes: aKey ]
]

{ #category : #initialization }
BlCompulsoryCombination >> initialize [
	super initialize.
	
	combinations := OrderedCollection new
]

{ #category : #testing }
BlCompulsoryCombination >> isCompulsory [
	^ true
]

{ #category : #adding }
BlCompulsoryCombination >> key: aKey [
	self with: (BlSingleKeyCombination key: aKey)
]

{ #category : #'key matching' }
BlCompulsoryCombination >> match: aKeyboardBuffer [
	<return: #Number>

	^ self combinations
		inject: 0
		into: [ :aResult :aCombination | aResult + (aCombination match: aKeyboardBuffer) ]
]

{ #category : #'key matching' }
BlCompulsoryCombination >> matches: aKeyboardBuffer [
	"Please note, I must be in DNF form!"
	<return: #Boolean>
	
	^ self combinations
		ifEmpty: [ false ]
		ifNotEmpty: [ :theCombinations | aKeyboardBuffer hasExactlyAll: (theCombinations collect: #key) ]
]

{ #category : #printing }
BlCompulsoryCombination >> printOn: aStream [
	
	aStream nextPut: $(.
	
	self combinations
		do: [ :aCombination | aCombination printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' & ' ].

	aStream nextPut: $).
]

{ #category : #adding }
BlCompulsoryCombination >> with: aCombination [
	
	aCombination isCompulsory
		ifTrue: [ self combinations addAll: aCombination combinations ]
		ifFalse: [ self combinations add: aCombination ]
]

{ #category : #adding }
BlCompulsoryCombination >> withAll: aCollectionOfCombinations [
	aCollectionOfCombinations do: [ :aCombination | self with: aCombination ]
]
