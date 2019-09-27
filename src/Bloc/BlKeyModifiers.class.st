Class {
	#name : #BlKeyModifiers,
	#superclass : #Object,
	#instVars : [
		'hashKey'
	],
	#category : #'Bloc-Events'
}

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> altMask [
	^ 2r000100
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> capsLockMask [
	^ 2r010000
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> cmdMask [
	^ 2r001000
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> ctrlMask [
	^ 2r000010
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> numLockMask [
	^ 2r100000
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> shift: shiftBool ctrl: ctrlBool alt: altBool  cmd: cmdBool [
	^ self new
		shift: shiftBool
		ctrl: ctrlBool
		alt: altBool
		cmd: cmdBool
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> shift: shiftBool ctrl: ctrlBool alt: altBool  cmd: cmdBool capsLock: capsLockBool	numLock: numLockBool [
	^ self new
		shift: shiftBool
		ctrl: ctrlBool
		alt: altBool
		cmd: cmdBool
		capsLock: capsLockBool
		numLock: numLockBool
]

{ #category : #'as yet unclassified' }
BlKeyModifiers class >> shiftMask [
	^ 2r000001
]

{ #category : #testing }
BlKeyModifiers >> = aKeyModifiers [
	^ self hash = aKeyModifiers hash
]

{ #category : #accessing }
BlKeyModifiers >> alt: altBool [
	hashKey := hashKey bitAt: 3 put: altBool asBit
]

{ #category : #accessing }
BlKeyModifiers >> capsLock: capsLockBool [
	hashKey := hashKey bitAt: 5 put: capsLockBool asBit
]

{ #category : #accessing }
BlKeyModifiers >> cmd: cmdBool [
	hashKey := hashKey bitAt: 4 put: cmdBool asBit
]

{ #category : #accessing }
BlKeyModifiers >> ctrl: ctrlBool [
	hashKey := hashKey bitAt: 2 put: ctrlBool asBit
]

{ #category : #accessing }
BlKeyModifiers >> hash [
	^ hashKey
]

{ #category : #initialization }
BlKeyModifiers >> initialize [
	super initialize.
	hashKey := 2r000000
	
]

{ #category : #testing }
BlKeyModifiers >> isAlt [
	^ hashKey anyMask: self class altMask
]

{ #category : #testing }
BlKeyModifiers >> isCapsLock [
	^ hashKey anyMask: self class capsLockMask
]

{ #category : #testing }
BlKeyModifiers >> isCmd [
	^ hashKey anyMask: self class cmdMask
]

{ #category : #testing }
BlKeyModifiers >> isCtrl [
	^ hashKey anyMask: self class ctrlMask
]

{ #category : #testing }
BlKeyModifiers >> isEmpty [
	^ hashKey = 0
]

{ #category : #testing }
BlKeyModifiers >> isNumLock [
	^ hashKey anyMask: self class numLockMask
]

{ #category : #testing }
BlKeyModifiers >> isPrimaryModifier [
	"Return true if primary modifier is pressed, false otherwise"
	| aPrimaryModifier |
	
	aPrimaryModifier := OSPlatform current primaryModifier.

	(self isCmd and: [ (aPrimaryModifier includes: BlKeyboardKey metaLeft) or: [ (aPrimaryModifier includes: BlKeyboardKey metaRight) ] ])
		ifTrue: [ ^ true ].
		
	(self isCtrl and: [ (aPrimaryModifier includes: BlKeyboardKey controlLeft) or: [ (aPrimaryModifier includes: BlKeyboardKey controlRight) ] ])
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #testing }
BlKeyModifiers >> isShift [
	^ hashKey anyMask: self class shiftMask
]

{ #category : #testing }
BlKeyModifiers >> isSuper [
	^ self isCmd
]

{ #category : #accessing }
BlKeyModifiers >> numLock: numLockBool [
	hashKey := hashKey bitAt: 6 put: numLockBool asBit
]

{ #category : #accessing }
BlKeyModifiers >> printOn: aStream [
	|mods|
	mods := OrderedCollection new.
	self isAlt ifTrue: [ mods add: 'Alt'].
	self isCmd ifTrue: [ mods add:  'Cmd'].
	self isCtrl ifTrue: [ mods add:  'Ctrl'].
	self isShift ifTrue: [ mods add: 'Shift'].
	self isCapsLock ifTrue: [ mods add:  'CapsLock'].
	self isNumLock ifTrue: [ mods add:  'NumLock'].
	aStream nextPutAll: (mods joinUsing: $+) 
	
	
]

{ #category : #accessing }
BlKeyModifiers >> shift: shiftBool [
	hashKey := hashKey bitAt: 1 put: shiftBool asBit
]

{ #category : #initialization }
BlKeyModifiers >> shift: shiftBool ctrl: ctrlBool alt: altBool cmd: cmdBool [
	hashKey := hashKey bitAt: 1 put: shiftBool asBit.
	hashKey := hashKey bitAt: 2 put: ctrlBool asBit.
	hashKey := hashKey bitAt: 3 put: altBool asBit.
	hashKey := hashKey bitAt: 4 put: cmdBool asBit
]

{ #category : #initialization }
BlKeyModifiers >> shift: shiftBool ctrl: ctrlBool alt: altBool cmd: cmdBool capsLock: capsLockBool numLock: numLockBool [
	hashKey := hashKey bitAt: 1 put: shiftBool asBit.
	hashKey := hashKey bitAt: 2 put: ctrlBool asBit.
	hashKey := hashKey bitAt: 3 put: altBool asBit.
	hashKey := hashKey bitAt: 4 put: cmdBool asBit.
	hashKey := hashKey bitAt: 5 put: capsLockBool asBit.
	hashKey := hashKey bitAt: 6 put: numLockBool asBit
]

{ #category : #printing }
BlKeyModifiers >> storeOn: aStream [
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' shift: '.
	aStream store: self isShift.
	aStream nextPutAll: ' ctrl: '.
	aStream store: self isCtrl.
	aStream nextPutAll: ' alt: '.
	aStream store: self isAlt.
	aStream nextPutAll: ' cmd: '.
	aStream store: self isCmd.
	aStream nextPutAll: ' capsLock: '.
	aStream store: self isCapsLock.
	aStream nextPutAll: ' numLock: '.
	aStream store: self isNumLock.
	aStream nextPutAll: ')'
]
