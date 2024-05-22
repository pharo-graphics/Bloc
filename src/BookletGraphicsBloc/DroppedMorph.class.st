"
ReceiverMorph new openInWorld.
(DroppedMorph new color: Color blue) openInWorld.
(DroppedMorph new color: Color green) openInWorld.

Le morph vert (Color green) est rejeté et reste ainsi attaché au pointeur de la
souris
"
Class {
	#name : #DroppedMorph,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #initialization }
DroppedMorph >> initialize [

	super initialize.
	color := Color blue.
	self position: 250 @ 100
]

{ #category : #'dropping/grabbing' }
DroppedMorph >> rejectDropMorphEvent: anEvent [

	| h |
	h := anEvent hand.
	self currentWorld worldState defer: [ h grabMorph: self ].
	anEvent wasHandled: true
]
