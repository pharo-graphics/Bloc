private
notifyValueChanged
	| theListeners aValue |
	self invalidated.
	
	"changeListeners is *immutable* array so there is no need to make a copy
	of existing listeners, we just need to store a reference to the array
	for the case if one of the listeners will be removed as the result of some action
	by any notified listener"
	theListeners := changeListeners.
	aValue := self value.
	theListeners do: [ :cl | cl valueChanged: aValue ]