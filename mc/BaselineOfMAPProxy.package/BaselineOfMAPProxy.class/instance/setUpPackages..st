as yet unclassified
setUpPackages: spec
	spec
		package: #MAPProxy
		with: [ spec
				requires:
					#('OsmoNetwork' 'OsmoLogging' 'TCAP' 'OsmoGSM') ].