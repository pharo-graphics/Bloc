driver selection
pickHost
	"Find and instantiate a first supported host.
	Return a special null one if there are no available hosts"
	<return: #BlHost>

	self allSubclassesDo: [ :aHostClass |
		aHostClass isSupported
			ifTrue: [ ^ aHostClass new ] ].
	
	"There are no availbale hosts, return a null one"
	^ BlNullHost new