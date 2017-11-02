private
splitLines: aSpText
	| theLines aLineIterator |

	theLines := OrderedCollection new.
	aLineIterator := aSpText rope iterator.

	[ aLineIterator hasNext ] whileTrue: [ 
		theLines add: aLineIterator nextLine ].

	^ theLines