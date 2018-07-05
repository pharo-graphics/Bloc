children - adding
add: aChild at: anIndex
	"Adds aChild at a given index moving existing children to the right"
	| aLinkAt |
	
	anIndex = 1
		ifTrue: [
			list addFirst: aChild.
			^ self ].
	
	aLinkAt := list linkAt: anIndex - 1.
	list add: aChild afterLink: aLinkAt