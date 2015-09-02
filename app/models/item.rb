class Item
  include ActiveModel::Model
  include Elasticsearch::Model

  index_name "documents_v1"
  document_type "prodsense"
  
end