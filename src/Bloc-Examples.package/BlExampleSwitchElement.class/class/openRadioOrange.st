opening
openRadioOrange
	<script: 'self openRadioOrange'>
	
	self
		openInWindow: (self radioOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 232@165