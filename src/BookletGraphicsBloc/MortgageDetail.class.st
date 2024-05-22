"
A placeholder, to contain loan repayment values
"
Class {
	#name : #MortgageDetail,
	#superclass : #Object,
	#instVars : [
		'beginningPrincipal',
		'principalPayment',
		'remainingPrincipal',
		'interestPayment'
	],
	#category : #'BookletGraphicsBloc-inspector'
}

{ #category : #accessing }
MortgageDetail >> beginningPrincipal [

	^ beginningPrincipal
]

{ #category : #accessing }
MortgageDetail >> beginningPrincipal: anObject [

	beginningPrincipal := anObject
]

{ #category : #accessing }
MortgageDetail >> interestPayment [

	^ interestPayment
]

{ #category : #accessing }
MortgageDetail >> interestPayment: anObject [

	interestPayment := anObject
]

{ #category : #accessing }
MortgageDetail >> principalPayment [

	^ principalPayment
]

{ #category : #accessing }
MortgageDetail >> principalPayment: anObject [

	principalPayment := anObject
]

{ #category : #accessing }
MortgageDetail >> remainingPrincipal [

	^ remainingPrincipal
]

{ #category : #accessing }
MortgageDetail >> remainingPrincipal: anObject [

	remainingPrincipal := anObject
]
