opening
openWithTrackOrange
	<script: 'self openWithTrackOrange'>
	
	self
		openInWindow: (self withTrackOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 255@165