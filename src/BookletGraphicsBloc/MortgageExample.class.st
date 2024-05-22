"
Sample mortage and inspector
"
Class {
	#name : #MortgageExample,
	#superclass : #Object,
	#instVars : [
		'duration',
		'rate',
		'amount'
	],
	#category : #'BookletGraphicsBloc-inspector'
}

{ #category : #examples }
MortgageExample class >> example [

	<sampleInstance>
	^ Mortgage  principal: 330000 duration: 12 * 3 rate: 4.5 percent "month" "year"
]

{ #category : #examples }
MortgageExample class >> example2 [

	<sampleInstance>
	^ Mortgage  principal: 330000 duration: 12 * 3 rate: -4.5 percent "month" "year"
]

{ #category : #'see class side' }
MortgageExample >> seeClassSide [ 
]
