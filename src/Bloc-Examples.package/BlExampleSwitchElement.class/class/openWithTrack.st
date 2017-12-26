opening
openWithTrack
	<script: 'self openWithTrack'>
	
	self
		openInWindow: (self withTrack
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 255@165