private
splitLines: aSpText
	| theLines aRope aLineIterator |

	theLines := OrderedCollection new.
	aRope := aSpText rope.
	aLineIterator := aRope iterator: 1 to: aRope size.
	
	[ aLineIterator hasNext ] whileTrue: [ 
		theLines add: aLineIterator nextLine ].

	^ theLines