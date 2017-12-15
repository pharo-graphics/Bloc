*Bloc-Extensions
gtInspectorMetricsIn: composite
	<gtInspectorPresentationOrder: 100>  
	
	^ composite bloc
		title: 'Metrics' translated;
		element: [
			BlMetricsInspector new
				relocate: 25@25;
				for: self ]