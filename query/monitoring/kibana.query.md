```
http://localhost:5601/api/monitoring/v1/clusters/79BUf_2LQ3ykfIczYBxd_A/elasticsearch/indices
{
    "showSystemIndices": false,
    "timeRange": {
        "min": "2018-02-03T15:00:00.000Z",
        "max": "2018-02-10T14:59:59.999Z"
    },
    "listingMetrics": [
        "index_document_count",
        "index_size",
        "index_search_request_rate",
        "index_request_rate_primary"
    ]
}
```

response
```
{
    "clusterStatus": {
        "status": "yellow",
        "indicesCount": 12,
        "totalShards": 24,
        "documentCount": 28550,
        "dataSize": 18361286,
        "nodesCount": 1,
        "upTime": 11715690,
        "version": [
            "5.6.7"
        ],
        "memUsed": 378612576,
        "memMax": 2112618496,
        "unassignedShards": 12
    },
    "rows": [
        {
            "name": "test",
            "metrics": {
                "index_request_rate_primary": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.primaries.indexing.index_total",
                        "label": "Primary Shards",
                        "title": "Indexing Rate",
                        "description": "Number of documents being indexed for primary shards.",
                        "units": "/s",
                        "format": "0,0.[00]"
                    },
                    "last": 0
                },
                "index_search_request_rate": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.total.search.query_total",
                        "label": "Total Shards",
                        "title": "Search Rate",
                        "description": "Number of search requests being executed across primary and replica shards. A single search can run against multiple shards!",
                        "units": "/s",
                        "format": "0,0.[00]"
                    },
                    "last": 0
                },
                "index_size": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.total.store.size_in_bytes",
                        "label": "Index Size",
                        "description": "Size of the index on disk for primary and replica shards.",
                        "units": "B",
                        "format": "0,0.0 b"
                    },
                    "last": 3373
                },
                "index_document_count": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.primaries.docs.count",
                        "label": "Document Count",
                        "description": "Total number of documents, only including primary shards.",
                        "units": "",
                        "format": "0,0.[0]a"
                    },
                    "last": 1
                },
                "index_unassigned_shards": {
                    "last": 1,
                    "metric": {
                        "units": ""
                    }
                }
            },
            "status": "yellow"
        },
        {
            "name": "test2",
            "metrics": {
                "index_request_rate_primary": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.primaries.indexing.index_total",
                        "label": "Primary Shards",
                        "title": "Indexing Rate",
                        "description": "Number of documents being indexed for primary shards.",
                        "units": "/s",
                        "format": "0,0.[00]"
                    },
                    "last": 0
                },
                "index_search_request_rate": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.total.search.query_total",
                        "label": "Total Shards",
                        "title": "Search Rate",
                        "description": "Number of search requests being executed across primary and replica shards. A single search can run against multiple shards!",
                        "units": "/s",
                        "format": "0,0.[00]"
                    },
                    "last": 0
                },
                "index_size": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.total.store.size_in_bytes",
                        "label": "Index Size",
                        "description": "Size of the index on disk for primary and replica shards.",
                        "units": "B",
                        "format": "0,0.0 b"
                    },
                    "last": 11218
                },
                "index_document_count": {
                    "metric": {
                        "app": "elasticsearch",
                        "field": "index_stats.primaries.docs.count",
                        "label": "Document Count",
                        "description": "Total number of documents, only including primary shards.",
                        "units": "",
                        "format": "0,0.[0]a"
                    },
                    "last": 3
                },
                "index_unassigned_shards": {
                    "last": 1,
                    "metric": {
                        "units": ""
                    }
                }
            },
            "status": "yellow"
        }
    ],
    "shardStats": {
        "nodes": {
            "G8Ct8aYJTUC4v_BB26dWOg": {
                "shardCount": 12,
                "indexCount": 12,
                "name": "G8Ct8aY",
                "transport_address": "127.0.0.1:9300",
                "node_ids": [
                    "G8Ct8aYJTUC4v_BB26dWOg"
                ],
                "attributes": {},
                "type": "master"
            }
        },
        "indices": {
            "totals": {
                "primary": 12,
                "replica": 0,
                "unassigned": {
                    "replica": 12,
                    "primary": 0
                }
            },
            ".kibana": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".monitoring-alerts-6": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".monitoring-es-6-2018.02.09": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".monitoring-es-6-2018.02.10": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".monitoring-kibana-6-2018.02.09": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".monitoring-kibana-6-2018.02.10": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".triggered_watches": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".watcher-history-6-2018.02.09": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".watcher-history-6-2018.02.10": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            ".watches": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            "test": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            },
            "test2": {
                "status": "yellow",
                "primary": 1,
                "replica": 0,
                "unassigned": {
                    "replica": 1,
                    "primary": 0
                }
            }
        }
    }
}
```
