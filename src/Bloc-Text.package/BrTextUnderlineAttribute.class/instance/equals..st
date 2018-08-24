comparing
equals: aTextAttribute
	"Return true if I am equal to a given text attribute assuming that
	it has the same type as me"
	<return: #Boolean>

	^ self paint = aTextAttribute paint and: [ 
		self style = aTextAttribute style and: [ 
			self width = aTextAttribute width and: [ 
				self opacity = aTextAttribute opacity and: [ 
					self isBelow = aTextAttribute isBelow ] ] ] ]