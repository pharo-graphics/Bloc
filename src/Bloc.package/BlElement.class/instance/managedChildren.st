children accessing
managedChildren
	"Return an array of all my direct managed children.
	Managed children are taken into account during layout process.
	children can not be nil"
	<return: #Array>
	self 
		deprecated: 'Use "children accountedByLayout" instead'
		on: 	'17 March 2018' 
		in: 'Pharo-6.0-60539-'.
		
	^ self children accountedByLayout