element handlers
elementExtentChanged: anEvent
	| maxWidth |

	maxWidth := self sourceElements max: #width.
	self targetElements do: [ :anElement | anElement width: maxWidth ]