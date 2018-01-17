private - accessing
withAllPrevious
	<return: #SequenceableCollection of: #BlEventDispatcherChain>

	^ Array streamContents: [ :aStream |
		| aChain |
		aChain := self.
		aStream nextPut: aChain.
		[ aChain hasPrevious ] whileTrue: [
			aStream nextPut: aChain previous.
			aChain := aChain previous ] ]