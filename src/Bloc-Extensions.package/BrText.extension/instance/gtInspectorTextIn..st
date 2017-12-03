*Bloc-Extensions
gtInspectorTextIn: composite
	<gtInspectorPresentationOrder: -10>  
	 composite bloc
		title: 'Text';
		element: [
			| root |
			root := BlElement new.
			root constraintsDo: [ :c | 
					c vertical matchParent. 
					c horizontal matchParent ]. 
			self gtTextIn: root.
			root ]