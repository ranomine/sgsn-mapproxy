as yet unclassified
setUpDependencies: spec

	spec
		baseline: 'OsmoCore'
		with: [ spec repository: 'github://moiji-mobile/osmocom-core:v9/source' ].
	spec
		baseline: 'TCAP'
		with: [ spec
				repository: 'github://moiji-mobile/tcap:v12/source';
				loads: #('default' 'camel') ].
	spec
		baseline: 'OsmoLogging'
		with: [ spec repository: 'github://moiji-mobile/osmocom-logging:v7/source' ].
	spec
		baseline: 'OsmoNetwork'
		with: [ spec repository: 'github://moiji-mobile/osmocom-network:master/source' ].
	spec
		baseline: 'OsmoCrashReportClient'
		with: [ spec
				repository: 'github://moiji-mobile/osmocom-crashreport:v7/source' ].
	spec
		baseline: 'ZincHTTPComponents'
		with: [ spec
				repository: 'github://svenvc/zinc:v3.0.1/repository';
				loads: #('REST') ].
	spec
		baseline: 'OsmoGSM'
		with: [ spec repository: 'github://moiji-mobile/osmocom-gsm:v3/source' ].