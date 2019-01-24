Class {
	#name : #BlFocusTransferEvent,
	#superclass : #BlBaseFocusEvent,
	#instVars : [
		'transfer'
	],
	#category : #'Bloc-Events'
}

{ #category : #testing }
BlFocusTransferEvent >> hasTransfer [
	^ transfer isNotNil
]

{ #category : #testing }
BlFocusTransferEvent >> isFocusTransfer [
	^ true
]

{ #category : #sending }
BlFocusTransferEvent >> sendTo: anObject [
	anObject focusTransferEvent: self
]

{ #category : #accessing }
BlFocusTransferEvent >> transfer [
	self
		assert: [ self hasTransfer ]
		description: [ 'Can not access transfer element when it does not exist' ].

	^ transfer
]

{ #category : #accessing }
BlFocusTransferEvent >> transfer: anObject [
	transfer := anObject
]
