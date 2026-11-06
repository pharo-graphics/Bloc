Class {
	#name : #BlHeadlessHostSpaceTest,
	#superclass : #TestCase,
	#category : #'Bloc-Tests-Universe'
}

{ #category : #tests }
BlHeadlessHostSpaceTest >> testNewHostSpaceIsAtTheOriginOfTheScreen [

	self assert: BlHeadlessHostSpace new position equals: 0 @ 0
]

{ #category : #tests }
BlHeadlessHostSpaceTest >> testPositionIsTheOneSet [

	| hostSpace |
	hostSpace := BlHeadlessHostSpace new.
	hostSpace position: 40 @ 30.
	self assert: hostSpace position equals: 40 @ 30
]
