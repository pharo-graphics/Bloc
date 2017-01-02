accessing
text: aSpText
	| theWords theChildren aWordIterator aSize theManagedChildren |
	
	aSize := itemElement childrenCount.

	theWords := OrderedCollection new.
	aWordIterator := aSpText rope iterator.
	
	[ aWordIterator hasNext ] whileTrue: [
		| aWord aText |
		aWord := aWordIterator nextWord.
		aText := SpText fromRope: aWord.
		aText attributes: { SpTextWrapAttribute none }.
		theWords	add: aText ].
	
	"remove unneeded elements"
	theWords size < aSize
		ifTrue: [ itemElement removeChildren: (itemElement managedChildren last: aSize - theWords size ) ].

	"create needed elements"
	theChildren := #().
	theWords size > aSize ifTrue: [
		theChildren := (1 to: theWords size - aSize) collect: [ :anIndex |
			BlTextElement new
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
			yourself ] ].
	itemElement addChildren: theChildren.
	
	theManagedChildren := itemElement managedChildren.
	theWords withIndexDo: [ :aText :anIndex |
		(theManagedChildren at: anIndex)
			text: aText ]