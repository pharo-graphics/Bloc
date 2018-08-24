Class {
	#name : #BlStyleManager,
	#superclass : #Object,
	#instVars : [
		'styleMap'
	],
	#category : 'Bloc-Style-Util'
}

{ #category : #'as yet unclassified' }
BlStyleManager >> initialize [
	super initialize.
	styleMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
BlStyleManager >> stylesFor: aStyleable [
	styleMap at: aStyleable
]

{ #category : #'as yet unclassified' }
BlStyleManager >> transitionStatesFor: aNode [
	| parent states |
	states := OrderedCollection new.
	parent := aNode.
	[ parent isNotNil ]
		whileTrue:[ 
			states add: parent pseudoClassStates.
			parent := parent parent].
	^ states  
]
