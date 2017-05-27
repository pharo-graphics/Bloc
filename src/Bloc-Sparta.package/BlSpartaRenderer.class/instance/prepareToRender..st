renderer - rendering
prepareToRender: aSpace
	"I check if window extent changed since last rendering step
	and if yes, recreate resources"

	(session ~= Smalltalk session or: [ self surface windowExtent ~= self windowExtent])
		ifTrue: [
			session := Smalltalk session.
			self surface initializeResourcesOn: self ]