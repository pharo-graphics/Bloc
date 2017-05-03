renderer - rendering
prepareToRender: aSpace

	"I check if window extent changed since last rendering step
	and if yes, recreate resources"
	(self surface windowExtent ~= self windowExtent)
		ifTrue: [ self surface initializeResourcesOn: self ]