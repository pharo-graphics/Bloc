Class {
	#name : #BlLocalClipboard,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'clipData'
	],
	#classVars : [
		'Default'
	],
	#category : 'Bloc-Universe'
}

{ #category : #'as yet unclassified' }
BlLocalClipboard class >> clear [
	Default := nil
]

{ #category : #'as yet unclassified' }
BlLocalClipboard class >> clipData [
	^ self default clipData
]

{ #category : #'as yet unclassified' }
BlLocalClipboard class >> clipData: anObject [
	self default clipData: anObject
]

{ #category : #'as yet unclassified' }
BlLocalClipboard class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #accessing }
BlLocalClipboard >> clipData [
	^ clipData
]

{ #category : #accessing }
BlLocalClipboard >> clipData: anObject [
	clipData := anObject
]
