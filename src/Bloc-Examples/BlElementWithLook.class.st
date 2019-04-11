Class {
	#name : #BlElementWithLook,
	#superclass : #BlElement,
	#instVars : [
		'look'
	],
	#category : #'Bloc-Examples-Widgets'
}

{ #category : #accessing }
BlElementWithLook >> background [
	^ self look background
]

{ #category : #accessing }
BlElementWithLook >> background: aBlBackground [
	self look background: aBlBackground
]

{ #category : #accessing }
BlElementWithLook >> border [
	^ self look border
]

{ #category : #accessing }
BlElementWithLook >> border: aBlBorder [
	self look border: aBlBorder
]

{ #category : #initialization }
BlElementWithLook >> initialize [
	super initialize.
	
	self look: BlLook new
]

{ #category : #accessing }
BlElementWithLook >> look [
	^ look
]

{ #category : #accessing }
BlElementWithLook >> look: aBlLook [
	look := aBlLook.
	look onInstalledIn: self
]
