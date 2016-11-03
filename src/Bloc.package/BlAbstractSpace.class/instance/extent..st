accessing
extent: aNewExtent
	"| oldExtent rdRect bdRect |
	oldExtent := self extent.
	rdRect := oldExtent x @ 0 corner: aNewExtent x @ oldExtent y.
	bdRect := 0 @ oldExtent y corner: aNewExtent.
	extent := aNewExtent."
	self extentProperty value:aNewExtent.
	self root extent: aNewExtent.
	self glass extent: aNewExtent.
	self beDirtyArea.
	self requestNextPulse