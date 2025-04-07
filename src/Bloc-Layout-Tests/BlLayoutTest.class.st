"
A BlLayoutTest is a test class for testing the behavior of BlLayout
"
Class {
	#name : #BlLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicLayout [

	self deny: BlBasicLayout new equals: BlBasicLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFlowLayout [

	self deny: BlFlowLayout horizontal equals: BlFlowLayout horizontal.
	self deny: BlFlowLayout vertical equals: BlFlowLayout vertical.
	self deny: BlFlowLayout horizontal equals: BlFlowLayout vertical.

	self
		deny: BlFlowLayout horizontal alignTopCenter
		equals: BlFlowLayout horizontal alignTopCenter.
	self
		deny: BlFlowLayout horizontal alignCenter
		equals: BlFlowLayout horizontal alignCenter.
	self
		deny: BlFlowLayout horizontal alignBottomRight
		equals: BlFlowLayout horizontal alignBottomRight.

	self
		deny: BlFlowLayout horizontal alignTopCenter
		equals: BlFlowLayout horizontal alignCenter.
	self
		deny: BlFlowLayout horizontal alignTopCenter
		equals: BlFlowLayout horizontal alignBottomRight
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFrameLayout [

	self deny: BlFrameLayout new equals: BlFrameLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlLinearLayout [

	self
		deny: BlLinearLayout horizontal
		equals: BlLinearLayout horizontal.
	self deny: BlLinearLayout vertical equals: BlLinearLayout vertical.
	self deny: BlLinearLayout horizontal equals: BlLinearLayout vertical.
	
	self
		deny: BlLinearLayout horizontal alignTopCenter
		equals: BlLinearLayout horizontal alignTopCenter.
	self
		deny: BlLinearLayout horizontal alignCenter
		equals: BlLinearLayout horizontal alignCenter.
	self
		deny: BlLinearLayout horizontal alignBottomRight
		equals: BlLinearLayout horizontal alignBottomRight.

	self
		deny: BlLinearLayout horizontal alignTopCenter
		equals: BlLinearLayout horizontal alignCenter.
	self
		deny: BlLinearLayout horizontal alignTopCenter
		equals: BlLinearLayout horizontal alignBottomRight
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlProportionalLayout [

	self deny: BlProportionalLayout new equals: BlProportionalLayout new
]
