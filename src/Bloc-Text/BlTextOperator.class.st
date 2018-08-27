Class {
	#name : #BlTextOperator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'text'
	],
	#category : #'Bloc-Text-Text-Operator'
}

{ #category : #accessing }
BlTextOperator >> text [
	<return: #BlText>
	^ text
]

{ #category : #accessing }
BlTextOperator >> text: aBlText [
	text := aBlText
]
