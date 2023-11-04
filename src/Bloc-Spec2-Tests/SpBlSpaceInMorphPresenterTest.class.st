"
A SpBlSpaceInMorphPresenterTest is a test class for testing the behavior of SpBlSpaceInMorphPresenter
"
Class {
	#name : #SpBlSpaceInMorphPresenterTest,
	#superclass : #TestCase,
	#category : #'Bloc-Spec2-Tests'
}

{ #category : #tests }
SpBlSpaceInMorphPresenterTest >> testOpenExampleWithoutError [

	| aPresenter |
	self
		shouldnt: [
			aPresenter := SpBlSpaceInMorphPresenter example ]
		raise: Error.
		
	aPresenter window close.
]
