children - removing
removeAt: anIndex
	| aLinkAt |

	aLinkAt := list linkAt: anIndex.
	list removeLink: aLinkAt