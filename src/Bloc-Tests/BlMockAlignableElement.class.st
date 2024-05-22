"
I'm a mock element for unit-testing `TBlAlignable`.
"
Class {
	#name : #BlMockAlignableElement,
	#superclass : #BlElement,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'horizontalAlignment',
		'verticalAlignment'
	],
	#category : #'Bloc-Tests-Layouts-Alignment'
}

{ #category : #accessing }
BlMockAlignableElement >> horizontalAlignment [

	^ horizontalAlignment
]

{ #category : #accessing }
BlMockAlignableElement >> horizontalAlignment: aBlElementAlignment [
	
	horizontalAlignment := aBlElementAlignment
]

{ #category : #accessing }
BlMockAlignableElement >> verticalAlignment [
	
	^ verticalAlignment
]

{ #category : #accessing }
BlMockAlignableElement >> verticalAlignment: aBlElementAlignment [
	
	verticalAlignment := aBlElementAlignment
]
