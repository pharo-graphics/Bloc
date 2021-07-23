"
# Keyboard key

I represent a named keyboard key such as `arrowLeft` or `A`.

## Code generation

Instance creation methods for the english alphabet are generated using the following script

```
			
($A to: $Z) do: [ :c | BlKeyboardKey class compile: c asString uncapitalized, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', c asString classified: 'keys - letters' ].

#(zero one two three four five six seven eight nine) withIndexDo: [ :n :i | BlKeyboardKey class compile: n asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #''', (i - 1) asString, '''' classified: 'keys - digits' ].

(1 to: 12) do: [ :n | BlKeyboardKey class compile: 'F', n asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #F', n asString classified: 'keys - functions' ].

#(Return Tab Space Delete Escape CapsLock Function Backspace) do: [ :n | BlKeyboardKey class compile: n uncapitalized asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', n asString classified: 'keys - special' ].

#(VolumeUp VolumeDown Mute) do: [ :n | BlKeyboardKey class compile: n uncapitalized asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', n asString classified: 'keys - sound' ].

#(PageUp PageDown ArrowLeft ArrowRight ArrowUp ArrowDown Home) do: [ :n | BlKeyboardKey class compile: n uncapitalized asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', n asString classified: 'keys - navigation' ].

#(MetaLeft MetaRight ShiftLeft ShiftRight ControlLeft ControlRight AltLeft AltRight) do: [ :n | BlKeyboardKey class compile: n uncapitalized asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', n asString classified: 'keys - modifiers' ].

#(Minus Equal LeftBracket RightBracket Quote Semicolon Backslash Comma Slash Period Grave) do: [ :n | BlKeyboardKey class compile: n uncapitalized asString, '
	<return: #', BlKeyboardKey name, '>
	^ self named: #', n asString classified: 'keys - symbols' ].

```

"
Class {
	#name : 'BlKeyboardKey',
	#superclass : 'Object',
	#instVars : [
		'value',
		'name'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : 'keys - functions' }
BlKeyboardKey class >> F1 [
	<return: #BlKeyboardKey>
	^ self named: #F1
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F10 [
	<return: #BlKeyboardKey>
	^ self named: #F10
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F11 [
	<return: #BlKeyboardKey>
	^ self named: #F11
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F12 [
	<return: #BlKeyboardKey>
	^ self named: #F12
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F2 [
	<return: #BlKeyboardKey>
	^ self named: #F2
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F3 [
	<return: #BlKeyboardKey>
	^ self named: #F3
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F4 [
	<return: #BlKeyboardKey>
	^ self named: #F4
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F5 [
	<return: #BlKeyboardKey>
	^ self named: #F5
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F6 [
	<return: #BlKeyboardKey>
	^ self named: #F6
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F7 [
	<return: #BlKeyboardKey>
	^ self named: #F7
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F8 [
	<return: #BlKeyboardKey>
	^ self named: #F8
]

{ #category : 'keys - functions' }
BlKeyboardKey class >> F9 [
	<return: #BlKeyboardKey>
	^ self named: #F9
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> a [
	<return: #BlKeyboardKey>
	^ self named: #A
]

{ #category : 'instance creation' }
BlKeyboardKey class >> all [
	<return: #Collection of: #BlKeyboardKey>
	<script: 'self all inspect'>
	
	^ self class methods
		select: [ :eachMethod | eachMethod protocol beginsWith: 'key' ]
		thenCollect: [ :eachMethod | self perform: eachMethod selector ]
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> altLeft [
	<return: #BlKeyboardKey>
	^ self named: #AltLeft
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> altRight [
	<return: #BlKeyboardKey>
	^ self named: #AltRight
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> arrowDown [
	<return: #BlKeyboardKey>
	^ self named: #ArrowDown
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> arrowLeft [
	<return: #BlKeyboardKey>
	^ self named: #ArrowLeft
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> arrowRight [
	<return: #BlKeyboardKey>
	^ self named: #ArrowRight
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> arrowUp [
	<return: #BlKeyboardKey>
	^ self named: #ArrowUp
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> b [
	<return: #BlKeyboardKey>
	^ self named: #B
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> backslash [
	<return: #BlKeyboardKey>
	^ self named: #Backslash
]

{ #category : 'keys - special' }
BlKeyboardKey class >> backspace [
	<return: #BlKeyboardKey>
	^ self named: #Backspace
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> c [
	<return: #BlKeyboardKey>
	^ self named: #C
]

{ #category : 'keys - special' }
BlKeyboardKey class >> capsLock [
	<return: #BlKeyboardKey>
	^ self named: #CapsLock
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> comma [
	<return: #BlKeyboardKey>
	^ self named: #Comma
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> controlLeft [
	<return: #BlKeyboardKey>
	^ self named: #ControlLeft
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> controlRight [
	<return: #BlKeyboardKey>
	^ self named: #ControlRight
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> d [
	<return: #BlKeyboardKey>
	^ self named: #D
]

{ #category : 'keys - special' }
BlKeyboardKey class >> delete [
	<return: #BlKeyboardKey>
	^ self named: #Delete
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> e [
	<return: #BlKeyboardKey>
	^ self named: #E
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> eight [
	<return: #BlKeyboardKey>
	^ self named: #'8'
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> end [
	<return: #BlKeyboardKey>
	^ self named: #End
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> equal [
	<return: #BlKeyboardKey>
	^ self named: #Equal
]

{ #category : 'keys - special' }
BlKeyboardKey class >> escape [
	<return: #BlKeyboardKey>
	^ self named: #Escape
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> f [
	<return: #BlKeyboardKey>
	^ self named: #F
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> five [
	<return: #BlKeyboardKey>
	^ self named: #'5'
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> four [
	<return: #BlKeyboardKey>
	^ self named: #'4'
]

{ #category : 'keys - special' }
BlKeyboardKey class >> function [
	<return: #BlKeyboardKey>
	^ self named: #Function
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> g [
	<return: #BlKeyboardKey>
	^ self named: #G
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> grave [
	<return: #BlKeyboardKey>
	^ self named: #Grave
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> h [
	<return: #BlKeyboardKey>
	^ self named: #H
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> home [
	<return: #BlKeyboardKey>
	^ self named: #Home
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> i [
	<return: #BlKeyboardKey>
	^ self named: #I
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> j [
	<return: #BlKeyboardKey>
	^ self named: #J
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> k [
	<return: #BlKeyboardKey>
	^ self named: #K
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> l [
	<return: #BlKeyboardKey>
	^ self named: #L
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> leftBracket [
	<return: #BlKeyboardKey>
	^ self named: #LeftBracket
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> m [
	<return: #BlKeyboardKey>
	^ self named: #M
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> metaLeft [
	<return: #BlKeyboardKey>
	^ self named: #MetaLeft
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> metaRight [
	<return: #BlKeyboardKey>
	^ self named: #MetaRight
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> minus [
	<return: #BlKeyboardKey>
	^ self named: #Minus
]

{ #category : 'keys - sound' }
BlKeyboardKey class >> mute [
	<return: #BlKeyboardKey>
	^ self named: #Mute
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> n [
	<return: #BlKeyboardKey>
	^ self named: #N
]

{ #category : 'instance creation' }
BlKeyboardKey class >> named: aName [
	<return: #BlKeyboardKey>

	^ self new setName: aName
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> nine [
	<return: #BlKeyboardKey>
	^ self named: #'9'
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> o [
	<return: #BlKeyboardKey>
	^ self named: #O
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> one [
	<return: #BlKeyboardKey>
	^ self named: #'1'
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> p [
	<return: #BlKeyboardKey>
	^ self named: #P
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> pageDown [
	<return: #BlKeyboardKey>
	^ self named: #PageDown
]

{ #category : 'keys - navigation' }
BlKeyboardKey class >> pageUp [
	<return: #BlKeyboardKey>
	^ self named: #PageUp
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> period [
	<return: #BlKeyboardKey>
	^ self named: #Period
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> q [
	<return: #BlKeyboardKey>
	^ self named: #Q
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> quote [
	<return: #BlKeyboardKey>
	^ self named: #Quote
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> r [
	<return: #BlKeyboardKey>
	^ self named: #R
]

{ #category : 'keys - special' }
BlKeyboardKey class >> return [
	<return: #BlKeyboardKey>
	^ self named: #Return
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> rightBracket [
	<return: #BlKeyboardKey>
	^ self named: #RightBracket
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> s [
	<return: #BlKeyboardKey>
	^ self named: #S
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> semicolon [
	<return: #BlKeyboardKey>
	^ self named: #Semicolon
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> seven [
	<return: #BlKeyboardKey>
	^ self named: #'7'
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> shiftLeft [
	<return: #BlKeyboardKey>
	^ self named: #ShiftLeft
]

{ #category : 'keys - modifiers' }
BlKeyboardKey class >> shiftRight [
	<return: #BlKeyboardKey>
	^ self named: #ShiftRight
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> six [
	<return: #BlKeyboardKey>
	^ self named: #'6'
]

{ #category : 'keys - symbols' }
BlKeyboardKey class >> slash [
	<return: #BlKeyboardKey>
	^ self named: #Slash
]

{ #category : 'keys - special' }
BlKeyboardKey class >> space [
	<return: #BlKeyboardKey>
	^ self named: #Space
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> t [
	<return: #BlKeyboardKey>
	^ self named: #T
]

{ #category : 'keys - special' }
BlKeyboardKey class >> tab [
	<return: #BlKeyboardKey>
	^ self named: #Tab
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> three [
	<return: #BlKeyboardKey>
	^ self named: #'3'
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> two [
	<return: #BlKeyboardKey>
	^ self named: #'2'
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> u [
	<return: #BlKeyboardKey>
	^ self named: #U
]

{ #category : 'instance creation' }
BlKeyboardKey class >> unknown [
	<return: #BlKeyboardKey>

	^ self named: self unknownKeyName
]

{ #category : 'instance creation' }
BlKeyboardKey class >> unknown: aValue [
	<return: #BlKeyboardKey>

	^ self unknown setValue: aValue
]

{ #category : 'accessing' }
BlKeyboardKey class >> unknownKeyName [
	^ #Unknown
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> v [
	<return: #BlKeyboardKey>
	^ self named: #V
]

{ #category : 'keys - sound' }
BlKeyboardKey class >> volumeDown [
	<return: #BlKeyboardKey>
	^ self named: #VolumeDown
]

{ #category : 'keys - sound' }
BlKeyboardKey class >> volumeUp [
	<return: #BlKeyboardKey>
	^ self named: #VolumeUp
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> w [
	<return: #BlKeyboardKey>
	^ self named: #W
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> x [
	<return: #BlKeyboardKey>
	^ self named: #X
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> y [
	<return: #BlKeyboardKey>
	^ self named: #Y
]

{ #category : 'keys - letters' }
BlKeyboardKey class >> z [
	<return: #BlKeyboardKey>
	^ self named: #Z
]

{ #category : 'keys - digits' }
BlKeyboardKey class >> zero [
	<return: #BlKeyboardKey>
	^ self named: #'0'
]

{ #category : 'comparing' }
BlKeyboardKey >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	
	self isUnkownKey = anObject isUnkownKey
		ifFalse: [ ^ false ].
	
	^ self isUnkownKey
		ifTrue: [ value = anObject value ]
		ifFalse: [ name = anObject name ]
]

{ #category : 'converting' }
BlKeyboardKey >> asKeyCombination [
	^ BlSingleKeyCombination key: self
]

{ #category : 'comparing' }
BlKeyboardKey >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ self isUnkownKey
		ifTrue: [ value hash ]
		ifFalse: [ name hash ]
]

{ #category : 'initialization' }
BlKeyboardKey >> initialize [
	super initialize.
	
	name := self class unknownKeyName.
	value := nil
]

{ #category : 'testing' }
BlKeyboardKey >> isArrowLeft [
	^ self = self class arrowLeft
]

{ #category : 'testing' }
BlKeyboardKey >> isArrowRight [
	^ self = self class arrowRight
]

{ #category : 'testing' }
BlKeyboardKey >> isEscape [
	^ self = self class escape
]

{ #category : 'testing' }
BlKeyboardKey >> isShift [
	^ self = self class shiftLeft or: [ self = self class shiftRight ]
]

{ #category : 'testing' }
BlKeyboardKey >> isUnkownKey [
	<return: #Boolean>

	 ^ self name == self class unknownKeyName
]

{ #category : 'accessing' }
BlKeyboardKey >> name [
	<return: #Symbol>

	^ name
]

{ #category : 'printing' }
BlKeyboardKey >> printOn: aStream [
	aStream
		nextPutAll: 'Key ';
		nextPutAll: name;
		nextPutAll: ' code: (';
		print: value;
		nextPutAll: ')'
]

{ #category : 'private' }
BlKeyboardKey >> setName: aName [
	name := aName asSymbol
]

{ #category : 'private' }
BlKeyboardKey >> setValue: aValue [
	value := aValue
]

{ #category : 'printing' }
BlKeyboardKey >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self class name;
		space;
		nextPutAll: 'new';
		space;
		nextPutAll: #setName:;
			space;
			store: name;
			nextPut: $;;
			space;
		nextPutAll: #setValue:;
			space;
			store: value;
		nextPut: $)
]

{ #category : 'accessing' }
BlKeyboardKey >> value [
	"Return a platform and host specific value behind the key.
	I am useless for a typical user and have only debugging purpose"
	<return: #Number>
	
	^ value
]

{ #category : 'accessing' }
BlKeyboardKey >> valueOrZero [
	"Return a platform and host specific value behind the key.
	If value is not specified I return 0.
	I am useless for a typical user and have only debugging purpose"
	<return: #Number>
	
	^ value ifNil: [ 0 ]
]
