opening
openRadio
	<script: 'self openRadio'>
	
	self
		openInWindow: (self radio
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 232@165