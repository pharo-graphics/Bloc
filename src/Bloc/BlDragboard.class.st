"
I manage the dragged values that can be exported in clipboard.

I am not really used for the moment.
"
Class {
	#name : #BlDragboard,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'space',
		'clipData',
		'dragView',
		'transferMode'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #'as yet unclassified' }
BlDragboard class >> space: aSpace [
	^ self new space: aSpace
]

{ #category : #'as yet unclassified' }
BlDragboard >> clear [
	dragView ifNotNil: [ :dv | dv removeFromParent ].
	clipData := nil
]

{ #category : #accessing }
BlDragboard >> clipData [
	"data insert in the system clipboard"

	^ clipData
]

{ #category : #accessing }
BlDragboard >> clipData: aString [
	clipData := aString.
	"Clipboard clipboardText: aString"
]

{ #category : #accessing }
BlDragboard >> dragView [
	^ dragView 
]

{ #category : #accessing }
BlDragboard >> hasClipData [
	^ self clipData isNotNil
]

{ #category : #accessing }
BlDragboard >> hasLocalData [
	^ self localData isNotNil
]

{ #category : #'as yet unclassified' }
BlDragboard >> initialize [
	super initialize.
	space := BlWeakRef new.
]

{ #category : #accessing }
BlDragboard >> localData [
	"data shared between multiple spaces"

	^ BlLocalClipboard clipData
]

{ #category : #accessing }
BlDragboard >> localData: anObject [
	BlLocalClipboard clipData: anObject
]

{ #category : #accessing }
BlDragboard >> space [
	^ space value
]

{ #category : #accessing }
BlDragboard >> space: anObject [
	space value: anObject
]

{ #category : #accessing }
BlDragboard >> transferMode [
	^ transferMode
]

{ #category : #accessing }
BlDragboard >> transferMode: anObject [
	transferMode := anObject
]
