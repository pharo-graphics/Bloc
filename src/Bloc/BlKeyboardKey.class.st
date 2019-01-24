"
!! Code generation

Instance creation methods for the english alphabet are generated using the following script

[[[
($A to: $Z) do: [ :c | BlKeyboardKey class compile: c asLowercase asString, '
	<return: #', BlKeyboardKey name, '>
	^ self new withName: #', c asString classified: 'instance creation' ]
]]]
"
Class {
	#name : #BlKeyboardKey,
	#superclass : #Object,
	#instVars : [
		'value',
		'name'
	],
	#category : #'Bloc-Events-KeyBinding'
}

{ #category : #'instance creation' }
BlKeyboardKey class >> a [
	<return: #BlKeyboardKey>
	^ self new withName: #A
]

{ #category : #'instance creation' }
BlKeyboardKey class >> b [
	<return: #BlKeyboardKey>
	^ self new withName: #B
]

{ #category : #'instance creation' }
BlKeyboardKey class >> c [
	<return: #BlKeyboardKey>
	^ self new withName: #C
]

{ #category : #'instance creation' }
BlKeyboardKey class >> d [
	<return: #BlKeyboardKey>
	^ self new withName: #D
]

{ #category : #'instance creation' }
BlKeyboardKey class >> e [
	<return: #BlKeyboardKey>
	^ self new withName: #E
]

{ #category : #'instance creation' }
BlKeyboardKey class >> f [
	<return: #BlKeyboardKey>
	^ self new withName: #F
]

{ #category : #'instance creation' }
BlKeyboardKey class >> g [
	<return: #BlKeyboardKey>
	^ self new withName: #G
]

{ #category : #'instance creation' }
BlKeyboardKey class >> h [
	<return: #BlKeyboardKey>
	^ self new withName: #H
]

{ #category : #'instance creation' }
BlKeyboardKey class >> i [
	<return: #BlKeyboardKey>
	^ self new withName: #I
]

{ #category : #'instance creation' }
BlKeyboardKey class >> j [
	<return: #BlKeyboardKey>
	^ self new withName: #J
]

{ #category : #'instance creation' }
BlKeyboardKey class >> k [
	<return: #BlKeyboardKey>
	^ self new withName: #K
]

{ #category : #'instance creation' }
BlKeyboardKey class >> l [
	<return: #BlKeyboardKey>
	^ self new withName: #L
]

{ #category : #'instance creation' }
BlKeyboardKey class >> m [
	<return: #BlKeyboardKey>
	^ self new withName: #M
]

{ #category : #'instance creation' }
BlKeyboardKey class >> n [
	<return: #BlKeyboardKey>
	^ self new withName: #N
]

{ #category : #'instance creation' }
BlKeyboardKey class >> o [
	<return: #BlKeyboardKey>
	^ self new withName: #O
]

{ #category : #'instance creation' }
BlKeyboardKey class >> p [
	<return: #BlKeyboardKey>
	^ self new withName: #P
]

{ #category : #'instance creation' }
BlKeyboardKey class >> q [
	<return: #BlKeyboardKey>
	^ self new withName: #Q
]

{ #category : #'instance creation' }
BlKeyboardKey class >> r [
	<return: #BlKeyboardKey>
	^ self new withName: #R
]

{ #category : #'instance creation' }
BlKeyboardKey class >> s [
	<return: #BlKeyboardKey>
	^ self new withName: #S
]

{ #category : #'instance creation' }
BlKeyboardKey class >> t [
	<return: #BlKeyboardKey>
	^ self new withName: #T
]

{ #category : #'instance creation' }
BlKeyboardKey class >> u [
	<return: #BlKeyboardKey>
	^ self new withName: #U
]

{ #category : #accessing }
BlKeyboardKey class >> unknownKeyName [
	^ #Unknown
]

{ #category : #'instance creation' }
BlKeyboardKey class >> v [
	<return: #BlKeyboardKey>
	^ self new withName: #V
]

{ #category : #'instance creation' }
BlKeyboardKey class >> w [
	<return: #BlKeyboardKey>
	^ self new withName: #W
]

{ #category : #'instance creation' }
BlKeyboardKey class >> x [
	<return: #BlKeyboardKey>
	^ self new withName: #X
]

{ #category : #'instance creation' }
BlKeyboardKey class >> y [
	<return: #BlKeyboardKey>
	^ self new withName: #Y
]

{ #category : #'instance creation' }
BlKeyboardKey class >> z [
	<return: #BlKeyboardKey>
	^ self new withName: #Z
]

{ #category : #comparing }
BlKeyboardKey >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #comparing }
BlKeyboardKey >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #initialization }
BlKeyboardKey >> initialize [
	super initialize.
	
	name := self class unknownKeyName.
	value := 0
]

{ #category : #testing }
BlKeyboardKey >> isUnkownKey [
	<return: #Boolean>

	 ^ self name == self class unknownKeyName
]

{ #category : #accessing }
BlKeyboardKey >> name [
	<return: #Symbol>

	^ name
]

{ #category : #printing }
BlKeyboardKey >> printOn: aStream [
	aStream
		nextPutAll: 'Key ';
		nextPutAll: name;
		nextPutAll: ' code: (';
		print: value;
		nextPutAll: ')'
]

{ #category : #accessing }
BlKeyboardKey >> value [
	"Return a platform and host specific value behind the key.
	I am useless for a typical user and have only debugging purpose"
	<return: #Number>
	
	^ value
]

{ #category : #'initialize-release' }
BlKeyboardKey >> withName: aName [
	self withName: aName andValue: 0
]

{ #category : #'initialize-release' }
BlKeyboardKey >> withName: aName andValue: aValue [
	value := aValue.
	name := aName asSymbol
]
