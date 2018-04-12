tree - enumerating
do: aBlock
	self hasRoot
		ifTrue: [ self root do: aBlock ]