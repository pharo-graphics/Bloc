accessing
windowExtent: aNewExtent
	"Change window size to aNewExtent.
	Note, that window size may be different from renderer size
	on high dpi (retina) displays"
	| aWindowSize |

	aWindowSize := aNewExtent.
	self hostSpace
		ifNotNil: [ :aHostSpace |
			aHostSpace windowExtent: aNewExtent ].

	extent := aWindowSize.
	self root extent: extent.
	self glass extent: extent.
	self beDirtyArea.
	self requestNextPulse