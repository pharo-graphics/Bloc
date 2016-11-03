private
notifyValueChanged
	self invalidated.
	changeListeners asArray do: [ :cl | cl valueChanged: self value ]