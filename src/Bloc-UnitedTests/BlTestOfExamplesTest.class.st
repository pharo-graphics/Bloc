Class {
	#name : #BlTestOfExamplesTest,
	#superclass : #TestCase,
	#category : 'Bloc-UnitedTests-Examples'
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
		hasSameElements: #(examplePass exampleFail exampleError exampleSkip)

]

{ #category : #tests }
BlTestOfExamplesTest >> testErrors [

	self
		assertCollection: (self examplesTestResult errors collect: [ :each | each selector ])
		hasSameElements: #(exampleError)

]

{ #category : #tests }
BlTestOfExamplesTest >> testFail [

	self
		assertCollection: (self examplesTestResult failures collect: [ :each | each selector ])
		hasSameElements: #(exampleFail)

]

{ #category : #tests }
BlTestOfExamplesTest >> testPass [

	self
		assertCollection: (self examplesTestResult passed collect: [ :each | each selector ])
		hasSameElements: #(examplePass)

]

{ #category : #tests }
BlTestOfExamplesTest >> testSkip [

	self
		assertCollection: (self examplesTestResult skipped collect: [ :each | each selector ])
		hasSameElements: #(exampleSkip)

]
