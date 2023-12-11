initialization
setupConnection

	"Create a connection class"

	conn := SCCPNetworkServiceOsmoDirect new
		        hostname: '10.26.0.69' port: 15004;
		        token: 'thnode';
		        yourself