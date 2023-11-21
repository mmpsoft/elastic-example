PUT /elastic
{
  "mappings": {
    "properties": {
      "name": {
        "type": "text",
        "analyzer": "ik_smart"
      },
      "age": {
        "type":"keyword",
        "index": false
      },
      "email": {
        "type": "integer",
        "index": false
      },
      "address": {
        "type": "object",
        "properties": {
          "province": {
            "type": "keyword"
          },
          "city": {
            "type": "keyword"
          },
          "dist": {
            "type": "keyword"
          }
        }
      }
    }
  }
}

## 添加数据
PUT /elastic/_doc/3
{
  "name":"wangwu",
  "age": 333,
  "email":"jeremystudio@163.com",
  "address": {
    "province": "广东省",
    "city":"深圳市",
    "dist":"宝安"
  }
}

## 查询数据
GET /elastic/_doc/1

## 全量更新和新增一样
## PUT /elastic/_doc/1


## 局部更新数据
POST /elastic/_update/1
{
  "doc": {
    "name": "lisi"
  }
}

## 全文检索，会对用户输入的内容分词，然后去倒排索引库
GET /elastic/_search
{
  "query": {
    "match": {
      "name": "lisi"
    }
  }
}

## 多字段全文检索
GET /elastic/_search
{
  "query": {
    "multi_match": {
      "query": "lisi",
      "fields": ["name", "address.city"]
    }
  }
}

## 精确查询
GET /elastic/_search
{
  "query": {
    "term": {
      "name": {
        "value": "lisi"
      }
    }
  }
}

## 范围查询
GET /elastic/_search
{
  "query": {
    "range": {
      "age": {
        "gte": 111
      }
    }
  }
}


## 复合查询
GET /elastic/_search
{
  "query": {
    "bool": {
      "must": [
        {"term": {
          "name": {
            "value": "lisi"
          }
        }}
      ]
    }
  }
}

## 排序
GET /elastic/_search
{
  "sort": [
    {
      "age": {
        "order": "desc"
      }
    }
  ]
}

## 分页
GET /elastic/_search
{
  "from": 0,
  "size": 1
}

## 高亮
GET /elastic/_search
{
  "query": {
    "match": {
      "name": "lisi"
    }
  },
  "highlight": {
    "fields": {
      "name": {
        "pre_tags": "<em>",
        "post_tags": "</em>"
      }
    }
  }
}
