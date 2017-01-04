driver selection
pickHost
	"Find and instantiate a first supported host.
	Throw an error if there are no supported hosts"
	<return: #BlHost>

	self allSubclassesDo: [ :aHostClass |
		aHostClass isSupported
			ifTrue: [ ^ aHostClass new ] ].

	Error signal: 'No host is available'