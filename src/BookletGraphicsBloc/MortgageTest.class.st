Class {
	#name : #MortgageTest,
	#superclass : #TestCase,
	#category : #'BookletGraphicsBloc-inspector'
}

{ #category : #tests }
MortgageTest >> testFormatAmount [

	| mortgage |
	mortgage := Mortgage new.  
	self assert: (mortgage formatAmount: 330000) equals: '330 000'.
	self assert: (mortgage formatAmount: 3000000) equals: '3 000 000'.
	self assert: (mortgage formatAmount: 9816.49) equals: '9 816.49'.
]

{ #category : #tests }
MortgageTest >> testMortgagePayement [

	| mortgage |
	mortgage := Mortgage principal: 330000 duration: 12 "month" * 3 "year"rate: 4.5 percent.  
	self assert: mortgage monthlyRate equals: 0.00375.
	self assert: mortgage payment equals: 9816.49
]

{ #category : #tests }
MortgageTest >> testPrincipalRemaining [

	| mortgage |
	mortgage := Mortgage principal: 330000 duration: 12 "month" * 3 "year"rate: 4.5 percent.  
	self assert: (mortgage principalRemainingAtPeriod:1) equals: 321421.18.
	self assert: (mortgage principalRemainingAtPeriod:36) equals: 0.
]
