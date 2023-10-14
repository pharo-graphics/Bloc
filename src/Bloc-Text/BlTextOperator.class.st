Class {
	#name : 'BlTextOperator',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'text'
	],
	#category : 'Bloc-Text-Text-Operator',
	#package : 'Bloc-Text',
	#tag : 'Text-Operator'
}

{ #category : 'accessing' }
BlTextOperator >> text [
	<return: #BlText>
	^ text ifNil: [ text := '' asRopedText ]
]

{ #category : 'accessing' }
BlTextOperator >> text: aBlText [
	text := aBlText asRopedText 
]
