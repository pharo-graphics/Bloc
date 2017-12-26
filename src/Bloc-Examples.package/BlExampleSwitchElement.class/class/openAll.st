opening
openAll
	<script: 'self openAll'>
	
	self
		openInWindow: (self all
			relocate: 150@150;
			transformDo: [ :t | t scaleBy: 3 ])
		named: 'Hydra switches'
		extent: 450@450