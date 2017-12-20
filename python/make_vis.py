import json

print("[")
for num in range(1,120):
    source = {
        "title": "title " + str(num),
        "visState": "{\"title\":\"dd\",\"type\":\"table\",\"params\":{\"perPage\":10,\"showPartialRows\":false,\"showMeticsAtAllLevels\":false,\"sort\":{\"columnIndex\":null,\"direction\":null},\"showTotal\":false,\"totalFunc\":\"sum\",\"type\":\"table\"},\"aggs\":[{\"id\":\"1\",\"enabled\":true,\"type\":\"count\",\"schema\":\"metric\",\"params\":{}}],\"listeners\":{}}",
        "uiStateJSON": "{\"vis\":{\"params\":{\"sort\":{\"columnIndex\":null,\"direction\":null}}}}",
        "description": "",
        "version": 1
    }

    data = {
        '_id': num,
        '_type': "visualization",
        '_source': source
    }
    json_str = json.dumps(data)
    if num == 119:
        print(json_str)
    else:
        print(json_str + ",")

print("]")
