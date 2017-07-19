text - enumeration
from: aFromIndex to: aToIndex do: aBlockClosure
	| anIterator |
	anIterator := self iterator: aFromIndex to: aToIndex.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]