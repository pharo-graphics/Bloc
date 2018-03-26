accessing
sourceElements: aCollection
	sourceElements := aCollection.
	sourceElements do: [ :anElement | anElement addEventHandler: self ]