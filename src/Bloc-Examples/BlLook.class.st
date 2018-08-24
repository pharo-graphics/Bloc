Class {
	#name : #BlLook,
	#superclass : #Object,
	#instVars : [
		'owner',
		'border',
		'background'
	],
	#category : 'Bloc-Examples-Widgets'
}

{ #category : #public }
BlLook >> background [
	^ background value
]

{ #category : #public }
BlLook >> background: aBlBackground [
	<callback: #onBackgroundChanged>

	background value: aBlBackground asBlBackground
]

{ #category : #public }
BlLook >> border [
	^ border value
]

{ #category : #public }
BlLook >> border: aBlBorder [
	<callback: #onBorderChanged>

	border value: aBlBorder
]

{ #category : #testing }
BlLook >> hasOwner [
	^ owner isNotNil
]

{ #category : #initialization }
BlLook >> initialize [
	super initialize.
	
	border := BlLookProperty
		on: self
		named: #border
		default: BlBorder empty
		invalidated: #onBorderChanged
		when: #hasOwner.

	background := BlLookProperty
		on: self
		named: #background
		default: BlBackground transparent
		invalidated: #onBackgroundChanged
		when: #hasOwner
]

{ #category : #changes }
BlLook >> onBackgroundChanged [
	self owner invalidate
]

{ #category : #changes }
BlLook >> onBorderChanged [
	<event: #BlElementBorderChangedEvent>

	self owner dispatchEvent: (BlElementBorderChangedEvent target: self owner).
	self owner invalidate
]

{ #category : #installation }
BlLook >> onInstalledIn: anElement [
	owner := anElement
]

{ #category : #installation }
BlLook >> onUninstalledIn: anElement [
	owner := nil
]

{ #category : #accessing }
BlLook >> owner [
	^ owner
]
