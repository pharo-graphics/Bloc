Class {
	#name : #BlTestOfExamplesTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Examples'
}

{ #category : #running }
BlTestOfExamplesTest >> examplesTestResult [

	| suite |
	suite := BlExamplesMock suite.
	suite tests do: [ :each | each enableRunning ].
	^ suite run
]

{ #category : #tests }
BlTestOfExamplesTest >> testAllExamplesAreConsideredTests [

	self
		assertCollection: BlExamplesMock testSelectors
		hasSameElements: #(#testExamplePass #testExampleFail #testExampleError #testExampleSkip)

]

{ #category : #tests }
BlTestOfExamplesTest >> testErrors [

	self
		assertCollection: (self examplesTestResult errors collect: [ :each | each selector ])
		hasSameElements: #(#testExampleError)

]

{ #category : #tests }
BlTestOfExamplesTest >> testFail [

	self
		assertCollection: (self examplesTestResult failures collect: [ :each | each selector ])
		hasSameElements: #(#testExampleFail)

]

{ #category : #tests }
BlTestOfExamplesTest >> testPass [

	self
		assertCollection: (self examplesTestResult passed collect: [ :each | each selector ])
		hasSameElements: #(#testExamplePass)

]

{ #category : #tests }
BlTestOfExamplesTest >> testSkip [

	self
		assertCollection: (self examplesTestResult skipped collect: [ :each | each selector ])
		hasSameElements: #(#testExampleSkip)

]
