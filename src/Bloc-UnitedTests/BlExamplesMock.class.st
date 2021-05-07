"
I define examples with the goal of demonstrating and testing my superclass.

See my references.
"
Class {
	#name : #BlExamplesMock,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-UnitedTests-Examples'
}

{ #category : #examples }
BlExamplesMock >> exampleError [
	<gtExample>

	self error
]

{ #category : #examples }
BlExamplesMock >> exampleFail [
	<gtExample>

	self fail
]

{ #category : #examples }
BlExamplesMock >> examplePass [
	<gtExample>

]

{ #category : #examples }
BlExamplesMock >> exampleSkip [
	<gtExample>
	<noTest>
	
	self error
]
