private - accessing
withAllNext
	<return: #SequenceableCollection of: #BlEventDispatcherChain>

	^ Array streamContents: [ :aStream |
		| aChain |
		aChain := self.
		aStream nextPut: aChain.
		[ aChain hasNext ] whileTrue: [
			aStream nextPut: aChain next.
			aChain := aChain next ] ]