groups
gFrom: node
	|groupElement|
	groupElement := BlElement new.

	self commonPropertiesFrom: node attributes on: groupElement.
	
	node nodesDo: [:child | child translatedBy: self withParent: groupElement].

	^groupElement