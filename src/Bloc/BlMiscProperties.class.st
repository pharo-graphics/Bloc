Class {
	#name : #BlMiscProperties,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'clipChildren',
		'focused',
		'mouseTransparent',
		'userData',
		'debug',
		'label',
		'wantsCompositionLayer'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #accessing }
BlMiscProperties >> clipChildren [
	^ clipChildren
]

{ #category : #accessing }
BlMiscProperties >> clipChildren: anObject [
	clipChildren := anObject
]

{ #category : #accessing }
BlMiscProperties >> debug [
	^ debug
]

{ #category : #accessing }
BlMiscProperties >> debug: aBoolean [
	debug := aBoolean
]

{ #category : #accessing }
BlMiscProperties >> focused [
	^ focused
]

{ #category : #accessing }
BlMiscProperties >> focused: aBoolean [
	focused := aBoolean
]

{ #category : #initialization }
BlMiscProperties >> initialize [
	super initialize.
	
	clipChildren := true.
	wantsCompositionLayer := false.
	userData := IdentityDictionary new.
	debug := false.
	label := ''.
	focused := false
]

{ #category : #accessing }
BlMiscProperties >> label [
	<return: #String>

	^ label
]

{ #category : #accessing }
BlMiscProperties >> label: aString [
	label := aString asString
]

{ #category : #accessing }
BlMiscProperties >> userData [
	^userData
]

{ #category : #accessing }
BlMiscProperties >> userData: aDict [
	userData := aDict
]

{ #category : #accessing }
BlMiscProperties >> wantsCompositionLayer [
	<return: #Boolean>

	^ wantsCompositionLayer
]

{ #category : #accessing }
BlMiscProperties >> wantsCompositionLayer: aBoolean [
	wantsCompositionLayer := aBoolean
]
