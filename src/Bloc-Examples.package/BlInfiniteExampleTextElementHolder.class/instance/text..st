accessing
text: aSpText
	| theWords theChildren aWordIterator aSize aManagedSize theManagedChildren |
	
	"amount of managed and visible children"
	aManagedSize := itemElement children accountedByLayout size.
	"amount of all children"
	aSize := itemElement childrenCount.
	
	theWords := OrderedCollection new.
	aWordIterator := aSpText rope iterator.

	[ aWordIterator hasNext ] whileTrue: [
		| aWord aText |
		aWord := aWordIterator nextWord.
		aText := SpText fromRope: aWord.
		aText attributes: { SpTextWrapAttribute none }.
		theWords	add: aText ].

	"unmanage and hide unneeded children"
	theWords size < aManagedSize
		ifTrue: [
			| allChildren |
			allChildren := itemElement children.
			(theWords size + 1) to: aManagedSize do: [ :anIndex |
				| anElement |
				anElement := (allChildren at: anIndex).
				anElement constraintsDo: [ :c | c ignoreByLayout ].
				anElement visibility: BlVisibility gone ] ].

	"create needed elements"
	theChildren := #().
	theWords size > aSize ifTrue: [
		theChildren := (1 to: theWords size - aSize) collect: [ :anIndex |
			(aSize + anIndex = 15)
				ifTrue: [
					BlElement new
						size: 200@100;
						background: Color random;
						constraintsDo: [ :c |
							c margin: (BlInsets top: 0 right: 3 bottom: 2 left: 0).
							c flow float ];
						yourself ]
				ifFalse: [
					BlTextElement new
					"BlElement new"
						"background: Color random;"
						constraintsDo: [ :c | 
							c margin: (BlInsets top: 0 right: 3 bottom: 2 left: 0).
							c horizontal fitContent.
							c vertical fitContent ];
						yourself ] ]	 ].
	"we don't have enough children, add new ones"
	itemElement addChildren: theChildren.

	theManagedChildren := itemElement children.
	theWords withIndexDo: [ :aText :anIndex |
		anIndex ~= 15 ifTrue: [ 
			(theManagedChildren at: anIndex)
				constraintsDo: [ :c | c accountByLayout ];
				visibility: BlVisibility visible;
				"size: 50@20"
				text: aText ] ]