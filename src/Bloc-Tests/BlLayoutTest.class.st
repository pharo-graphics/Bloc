"
A BlLayoutTest is a test class for testing the behavior of BlLayout
"
Class {
	#name : #BlLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Layouts-Basic'
}

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicLayout [

	self assert: BlBasicLayout new equals: BlBasicLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFlowLayout [

	self assert: BlFlowLayout horizontal equals: BlFlowLayout horizontal.
	self assert: BlFlowLayout vertical equals: BlFlowLayout vertical.
	self deny: BlFlowLayout horizontal equals: BlFlowLayout vertical.

	self
		assert: BlFlowLayout horizontal alignTopCenter
		equals: BlFlowLayout horizontal alignTopCenter.
	self
		assert: BlFlowLayout horizontal alignCenter
		equals: BlFlowLayout horizontal alignCenter.
	self
		assert: BlFlowLayout horizontal alignBottomRight
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

	self assert: BlFrameLayout new equals: BlFrameLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlLinearLayout [

	self
		assert: BlLinearLayout horizontal
		equals: BlLinearLayout horizontal.
	self assert: BlLinearLayout vertical equals: BlLinearLayout vertical.
	self deny: BlLinearLayout horizontal equals: BlLinearLayout vertical.
	
		self
		assert: (BlLinearLayout horizontal cellSpacing: 5.0)
		equals: (BlLinearLayout horizontal cellSpacing: 5.0).
	self
		deny: (BlLinearLayout horizontal cellSpacing: 4.0)
		equals: (BlLinearLayout horizontal cellSpacing: 5.0).

	self
		assert: (BlLinearLayout horizontal interspace: 5.0)
		equals: (BlLinearLayout horizontal interspace: 5.0).
	self
		deny: (BlLinearLayout horizontal interspace: 4.0)
		equals: (BlLinearLayout horizontal interspace: 5.0).

	self
		assert: BlLinearLayout horizontal alignTopCenter
		equals: BlLinearLayout horizontal alignTopCenter.
	self
		assert: BlLinearLayout horizontal alignCenter
		equals: BlLinearLayout horizontal alignCenter.
	self
		assert: BlLinearLayout horizontal alignBottomRight
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

	self assert: BlProportionalLayout new equals: BlProportionalLayout new
]
