comparing
hash
	^ margin hash bitXor: (
		padding hash bitXor: (
			vertical hash bitXor: (
				horizontal hash bitXor: (
					minHeight hash bitXor: (
						minWidth hash bitXor: (
							visibility hash bitXor: (
								weight hash) ) ) ) ) ) )