examples
bouncingText
	"Click on letters to start animation"
	<script: 'self bouncingText'>

	self
		openInWindow: self new bouncingText
		named: 'Bouncing text (Click on letters)'
		extent: 850 @ 520