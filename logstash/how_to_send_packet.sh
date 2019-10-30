 tshark -r IPFIX.pcap -T ek > packets.json
 curl -s -H "Content-Type: application/x-ndjson" -XPOST "localhost:9200/_bulk" --data-binary "@packets.json"
