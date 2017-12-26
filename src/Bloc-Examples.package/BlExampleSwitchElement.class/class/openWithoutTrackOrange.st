opening
openWithoutTrackOrange
	<script: 'self openWithoutTrackOrange'>
	
	self
		openInWindow: (self withoutTrackOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 240@165