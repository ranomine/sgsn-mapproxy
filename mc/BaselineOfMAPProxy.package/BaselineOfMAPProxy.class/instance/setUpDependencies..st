as yet unclassified
setUpDependencies: spec

	spec
		baseline: 'OsmoCore'
		with: [ spec repository: 'github://ranomine/osmocom-core:pharo10-migration/source' ].
	spec
		baseline: 'TCAP'
		with: [ spec
				repository: 'github://ranomine/tcap:pharo10/source';
				loads: #('default' 'camel') ].
	spec
		baseline: 'OsmoLogging'
		with: [ spec repository: 'github://ranomine/osmocom-logging:pharo10-migration/source' ].
	spec
		baseline: 'OsmoNetwork'
		with: [ spec repository: 'github://ranomine/osmocom-network:pharo10-migration/source' ].
	spec
		baseline: 'OsmoCrashReportClient'
		with: [ spec
				repository: 'github://ranomine/osmocom-crashreport:pharo10-migration/source' ].
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec
				repository: 'github://svenvc/zinc:v5/repository';
				loads: #('REST') ].
	spec
		baseline: 'OsmoGSM'
		with: [ spec repository: 'github://ranomine/osmocom-gsm:pharo10-migration/source' ].
