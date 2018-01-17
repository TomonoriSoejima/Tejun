curl -s -u elastic:changeme -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" -d '{ "attributes": { "title": "Test pattern" } }' http://localhost:5601/api/saved_objects/index-pattern
