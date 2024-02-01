Class {
	#name : #BlFileCollectionRopeExamples,
	#superclass : #BlCollectionRopeExamplesTest,
	#category : 'Bloc-Examples-Rope'
}

{ #category : #'instance creation' }
BlFileCollectionRopeExamples >> testSmall [
	"Creates an instance of the rope of size smaller than combineLength"

	<sampleInstance>
	| aRope file |
	file := FileReference
		        newTempFilePrefix: 'BlFileCollectionRopeExamples-'
		        suffix: '-small'.
	file writeStreamDo: [ :stream | stream << 'Hello' ].
	aRope := BlCollectionRope collection:
		         (BlRopeableCollectionFile new fileReference: file).

	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope collection equals: 'Hello'.
	self assert: aRope isLeaf.
	self assert: aRope size <= BlRope combineLength.

	^ aRope
]
