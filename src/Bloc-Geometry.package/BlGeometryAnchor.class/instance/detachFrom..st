event handling
detachFrom: aGeometryElement
	self removeEventHandlersSuchThat: [ :anEventHandler |
		(anEventHandler class = self anchorListenerClass)
			and: [ anEventHandler geometryElement == aGeometryElement ] ]