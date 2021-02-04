"
I am an extended version of the attributes builder with an ability to delegate the applying of attributes to the other stylable, which can be a ${class:BlText}$ or the other ${class:BlTextAttributesBuilder}$
"
Class {
	#name : #BlTextDelegatedAttributesBuilder,
	#superclass : #BlTextAttributesBuilder,
	#instVars : [
		'attributesTarget',
		'attributeAddedBlock',
		'isOverwritableByStyler'
	],
	#category : #'Bloc-Text-Text-Support'
}

{ #category : #accessing }
BlTextDelegatedAttributesBuilder >> attribute: aTextAttribute [
	
	isOverwritableByStyler
		ifTrue: [ aTextAttribute beOverwritableByStyler ]
		ifFalse: [ aTextAttribute beNotOverwritableByStyler ].
		
	(self hasAttribute: aTextAttribute)
		ifTrue: [ ^ self ].
	
	super attribute: aTextAttribute.
	self attributesTarget ifNotNil: [ :aTarget | aTarget attribute: aTextAttribute ].
	
	attributeAddedBlock cull: aTextAttribute
]

{ #category : #accessing }
BlTextDelegatedAttributesBuilder >> attributesTarget [
	<return: #TBlTextStyleable>

	^ attributesTarget
]

{ #category : #accessing }
BlTextDelegatedAttributesBuilder >> attributesTarget: aTBlTextStyleable [
	attributesTarget := aTBlTextStyleable.
	self applyOn: attributesTarget
]

{ #category : #accessing }
BlTextDelegatedAttributesBuilder >> beNotOverwritableByStyler [
	isOverwritableByStyler := false
]

{ #category : #accessing }
BlTextDelegatedAttributesBuilder >> beOverwritableByStyler [
	isOverwritableByStyler := true
]

{ #category : #initialization }
BlTextDelegatedAttributesBuilder >> initialize [
	super initialize.
	
	attributeAddedBlock := [  ].
	isOverwritableByStyler := true
]

{ #category : #scripting }
BlTextDelegatedAttributesBuilder >> whenAdded: aBlock [
	attributeAddedBlock := aBlock
]
