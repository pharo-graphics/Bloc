Class {
	#name : #BlFileCollectionRopeExamples,
	#superclass : #BlCollectionRopeExamplesTest,
	#category : #'Bloc-Examples-Rope'
}

{ #category : #'instance creation' }
BlFileCollectionRopeExamples >> testBufferedIndexes [
	"Test that buffering + index calculations work"

	| rope result file |
	file := FileSystem memory / 'test.txt'.
	file writeStreamDo: [ :stream | stream << 'foobarbaz' ].
	rope :=
		BlRopeableCollectionFile new
			bufferSize: 3;
			fileReference: file.	

	"The following test uses an explicit whileTrue: loop instead of to:do: since `rope size` can be different every time"
	result :=
		String streamContents: [ :str | 
			| i |
			i := 1.
			[ i <= rope size ] whileTrue: [
				str nextPut: (rope at: i).
				i := i + 1 ] ].

	self assert: result equals: 'foobarbaz'
]

{ #category : #'instance creation' }
BlFileCollectionRopeExamples >> testSmall [
	"Test a rope of size smaller than combineLength"

	| aRope file |
	file := FileSystem memory / 'test.txt'.
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
