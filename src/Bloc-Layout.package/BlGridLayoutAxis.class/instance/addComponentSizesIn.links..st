computing arcs
addComponentSizesIn: theArcs links: links
	"arcs is collection of BlGridLayoutArc
	links is BlGridPackedMap<Interval, BlMutableInteger>"
	
	links keysAndValuesDo: [ :span :size |
		self includeIn: theArcs span: span size: size ignoreIfPresent: false ]