Class {
	#name : #BlSomeProgress,
	#superclass : #BlTaskNotification,
	#instVars : [
		'amount'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #signalling }
BlSomeProgress class >> signal: signalerText amount: amount [
	"Create and signal progress with amount units transferred out of total.
	Use an additional signalerText."

	^ self new
		amount: amount;
		signal: signalerText
]

{ #category : #signalling }
BlSomeProgress class >> signalAmount: amount [
	"Create and signal progress with amount units."
	
	^ self new
		amount: amount;
		signal
]

{ #category : #accessing }
BlSomeProgress >> amount [
	<return: #Number>
	^ amount
]

{ #category : #accessing }
BlSomeProgress >> amount: anAmountNumber [
	self
		assert: [ anAmountNumber notNil ]
		description: [ 'Progress amount number must be non-nil' ].
	self
		assert: [ anAmountNumber >= 0 ]
		description: [ 'Progress amount must be positive number' ].

	amount := anAmountNumber.
]

{ #category : #initialization }
BlSomeProgress >> initialize [
	super initialize.
	amount := 0.
]
