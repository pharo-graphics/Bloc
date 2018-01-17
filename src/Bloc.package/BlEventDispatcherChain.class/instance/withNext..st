api - adding
withNext: aBlEventDispatcher
	| aNextChain |

	aNextChain := self class with: aBlEventDispatcher.
	self next: aNextChain.
	aNextChain previous: self.

	^ aNextChain