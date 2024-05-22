"
ReceiverMorph new openInWorld.
EllipseMorph new openInWorld

Changez la couleur de l’ellipse pour du bleu via l’inspecteur (que vous
pouvez activer avec le menu de la poignée du débogage du halo Morphic
en cliquant sur inspect morph ) : évaluez self color: Color blue. Les morphs bleus
étant acceptés par le ReceiverMorph : essayez à nouveau le glisser-déposer
"
Class {
	#name : #ReceiverMorph,
	#superclass : #Morph,
	#category : #'BookletGraphicsBloc-Morph'
}

{ #category : #initialization }
ReceiverMorph >> initialize [

	super initialize.
	color := Color red.
	bounds := 0 @ 0 extent: 200 @ 200
]

{ #category : #'instance creation' }
ReceiverMorph >> open [
	<script: 'self new openInWorld'>
]

{ #category : #'dropping/grabbing' }
ReceiverMorph >> repelsMorph: aMorph event: anEvent [
^ (self wantsDroppedMorph: aMorph event: anEvent) not
]

{ #category : #'drag and drop' }
ReceiverMorph >> wantsDroppedMorph: aMorph event: anEvent [

	^ aMorph color = Color blue
]
