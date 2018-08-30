Class {
	#name : #BlExactProgress,
	#superclass : #BlTaskProgress,
	#instVars : [
		'amount',
		'total'
	],
	#category : #'Bloc-TaskIt-Signals'
}

{ #category : #signalling }
BlExactProgress class >> signal: signalerText amount: amount total: total [
	"Create and signal progress with amount units transferred out of total.
	Use an additional signalerText."

	^ self new
		amount: amount total: total;
		signal: signalerText
]

{ #category : #signalling }
BlExactProgress class >> signalAmount: amount total: total [
	"Create and signal progress with amount units transferred out of total."
	
	^ self new
		amount: amount total: total;
		signal
]

{ #category : #accessing }
BlExactProgress >> amount [
	<return: #Number>
	^ amount
]

{ #category : #accessing }
BlExactProgress >> amount: anAmountNumber total: aTotalNumber [
	self
		assert: [ anAmountNumber notNil and: [ aTotalNumber notNil ] ]
		description: [ 'Progress amount and total numbers must be non-nil' ].
	self
		assert: [ anAmountNumber >= 0 and: [ anAmountNumber <= aTotalNumber ] ]
		description: [ 'Progress amount must be positive number less or equal to total number' ].

	amount := anAmountNumber.
	total := aTotalNumber.
]

{ #category : #'accessing-computed' }
BlExactProgress >> fraction [
	"Answer the fraction of total that has already been transferred.
	Should be between 0 and 1."
	^ self amount / self total
]

{ #category : #'accessing-computed' }
BlExactProgress >> fraction: aNumber [
	self 
		assert: [ aNumber notNil ]
		description: [ 'Progress fraction must be non-nil' ].
	self 
		assert: [ aNumber >= 0 and: [ aNumber <= 1 ] ]
		description: [ 'Progress fraction number must be between 0 and 1' ].
	self amount: aNumber * 100 total: 100
]

{ #category : #initialization }
BlExactProgress >> initialize [
	super initialize.
	amount := 0.
	total := 100.
]

{ #category : #'accessing-computed' }
BlExactProgress >> percentage [
	"Answer the percentage of total that has already been transferred.
	Should be between 0 and 100."
	^ self fraction * 100
]

{ #category : #'accessing-computed' }
BlExactProgress >> percentage: aNumber [
	self amount: aNumber total: 100
]

{ #category : #accessing }
BlExactProgress >> total [
	^ total
]
