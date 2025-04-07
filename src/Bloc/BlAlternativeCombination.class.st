"
I represent an alternative ""OR"" combination of multiple distinct keys. (disjunction)

I am very useful to support shortcuts that treat different keyboard keys as identical.
For example there might be two SHIFT keys: SHIFT_L (left shift) and SHIFT_R (right shift). In most cases for the end user there should be no difference between those two.

Here is an example of how to unify two shifts:

BlAlternativeCombination new
	key: Key leftShift;
	key: Key rightShift;
	yourself

Unified meta (cmd):

BlAlternativeCombination new
	with: (BlSingleKeyCombination key: Key leftMeta);
	with: (BlSingleKeyCombination key: Key rightMeta);
	yourself

"
Class {
	#name : #BlAlternativeCombination,
	#superclass : #BlKeyCombination,
	#instVars : [
		'combinations'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #comparing }
BlAlternativeCombination >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ combinations = anObject combinations
]

{ #category : #visiting }
BlAlternativeCombination >> accept: aKeyCombinationVisitor [
	^ aKeyCombinationVisitor visitAlternative: self
]

{ #category : #converting }
BlAlternativeCombination >> asBufferKeys [
	^ combinations first asBufferKeys
]

{ #category : #accessing }
BlAlternativeCombination >> combinations [
	<return: #SequenceableCollection of: #BlKeyCombination>

	^ combinations
]

{ #category : #comparing }
BlAlternativeCombination >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ combinations hash
]

{ #category : #testing }
BlAlternativeCombination >> includes: aKey [
	^ self combinations anySatisfy: [ :aCombination | aCombination includes: aKey ]
]

{ #category : #initialization }
BlAlternativeCombination >> initialize [
	super initialize.
	
	"keys := SortedCollection sortBlock: [ :keyA :keyB | keyA keyValue < keyB keyValue ]".
	combinations := OrderedCollection new
]

{ #category : #testing }
BlAlternativeCombination >> isAlternative [
	^ true
]

{ #category : #adding }
BlAlternativeCombination >> key: aKey [
	self with: (BlSingleKeyCombination key: aKey)
]

{ #category : #'key matching' }
BlAlternativeCombination >> match: aKeyboardBuffer [
	<return: #Number>
	
	^ self combinations
		inject: 0
		into: [ :max :aCombination | max max: (aCombination match: aKeyboardBuffer) ]
]

{ #category : #'key matching' }
BlAlternativeCombination >> matches: aKeyboardBuffer [
	<return: #Boolean>

	^ self combinations
		anySatisfy: [ :aCombination | aCombination matches: aKeyboardBuffer ]
]

{ #category : #controlling }
BlAlternativeCombination >> or: anotherKeyCombination [
	<return: #BlKeyCombination>

	^ self with: anotherKeyCombination
]

{ #category : #printing }
BlAlternativeCombination >> printOn: aStream [
	
	aStream nextPut: $(.
	
	self combinations
		do: [ :aCombination | aCombination printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ' | ' ].

	aStream nextPut: $)
]

{ #category : #adding }
BlAlternativeCombination >> with: aCombination [
	aCombination isAlternative
		ifTrue: [ self combinations addAll: aCombination combinations ]
		ifFalse: [ self combinations add: aCombination ]
]

{ #category : #adding }
BlAlternativeCombination >> withAll: aCollectionOfCombinations [
	self combinations addAll: aCollectionOfCombinations
]
