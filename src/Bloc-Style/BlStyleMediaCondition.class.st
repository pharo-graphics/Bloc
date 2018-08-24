Class {
	#name : #BlStyleMediaCondition,
	#superclass : #Object,
	#instVars : [
		'type',
		'conditions',
		'media'
	],
	#category : 'Bloc-Style-CSS'
}

{ #category : #accessing }
BlStyleMediaCondition >> conditions [
	^ conditions
]

{ #category : #accessing }
BlStyleMediaCondition >> conditions: anObject [
	conditions := anObject
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> heightOf: aTarget value: aValue [
	^ aTarget height = aValue
]

{ #category : #testing }
BlStyleMediaCondition >> isValidOn: aTarget [
	| typeTarget |
	typeTarget := BlStyleMediaTarget
		perform: (self type , 'On:') asSymbol
		with: aTarget.
	conditions
		keysAndValuesDo:
			[ :k :v | 
			(self
				perform: (k , 'Of:' , 'value:') asSymbol
				withEnoughArguments:
					{typeTarget.
					v value})
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> maxHeightOf: aTarget value: aValue [
	^ aTarget height <= aValue
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> maxWidthOf: aTarget value: aValue [
	^ aTarget width <= aValue
]

{ #category : #accessing }
BlStyleMediaCondition >> media [
	^ media
]

{ #category : #accessing }
BlStyleMediaCondition >> media: anObject [
	media := anObject
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> minHeightOf: aTarget value: aValue [
	^ aTarget height >= aValue
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> minWidthOf: aTarget value: aValue [
	^ aTarget width >= aValue
]

{ #category : #accessing }
BlStyleMediaCondition >> type [
	^ type
]

{ #category : #accessing }
BlStyleMediaCondition >> type: anObject [
	type := anObject
]

{ #category : #'evaluating conditions' }
BlStyleMediaCondition >> widthOf: aTarget value: aValue [
	^ aTarget width = aValue
]
