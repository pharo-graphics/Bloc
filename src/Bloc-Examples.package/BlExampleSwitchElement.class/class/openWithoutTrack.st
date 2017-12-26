opening
openWithoutTrack
	<script: 'self openWithoutTrack'>
	
	self
		openInWindow: (self withoutTrack
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 240@165