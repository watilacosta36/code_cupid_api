require 'opensearch'

Searchkick.client = OpenSearch::Client.new(
  url: ENV['ELASTICSEARCH_URL'] || "http://opensearch:9200",
  retry_on_failure: 5,
  request_timeout: 120,
  transport_options: { ssl: { verify: false } },
  log: true
)
