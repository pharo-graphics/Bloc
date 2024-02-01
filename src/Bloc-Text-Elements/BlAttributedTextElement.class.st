Class {
	#name : #BlAttributedTextElement,
	#superclass : #BlTextElement,
	#traits : 'TBlTextStyleable - {#defaultFontSize:}',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'attributesBuilder'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlAttributedTextElement >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ attributesBuilder
]

{ #category : #initialization }
BlAttributedTextElement >> initialize [
	super initialize.
	
	attributesBuilder := BlTextDelegatedAttributesBuilder new.
	attributesBuilder attributesTarget: text.
	attributesBuilder whenAdded: [ self textChanged ]
]

{ #category : #accessing }
BlAttributedTextElement >> text: aText [
	super text: aText.
	
	self attributesBuilder attributesTarget: aText
]
