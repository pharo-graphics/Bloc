text - enumeration
do: aBlockClosure 
	| anIterator |
	anIterator := self iterator.
	[ anIterator hasNext ] whileTrue: [ aBlockClosure value: anIterator next ]