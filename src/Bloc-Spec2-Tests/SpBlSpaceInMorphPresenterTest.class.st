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

	| aPresenter aSpace |
	self
		shouldnt: [
			aPresenter := SpBlSpaceInMorphPresenter example ]
		raise: Error.
	aSpace := aPresenter space.
	aSpace settle.
	self assert: aSpace isOpened.
	self assert: aSpace hostSpace isNotNil.
	self assert: aSpace hostSpace spaceHostMorph isNotNil.
	self assert: aSpace hostSpace spaceHostMorph form isNotNil.
	self assert: aSpace root children size equals: 50.

	aPresenter window close
]

{ #category : #tests }
SpBlSpaceInMorphPresenterTest >> testSpaceRemainsOpenedBeforeWindowOpen [

	| aPresenter aSpace |
	aPresenter := SpBlSpaceInMorphPresenter new.
	aSpace := aPresenter space.
	aSpace settle.
	self assert: aSpace isOpened.
	self assert: aSpace host isRunning.
	self assert: aSpace hostSpace isNotNil.

	aSpace close.
	aSpace settle.
	self deny: aSpace isOpened
]
