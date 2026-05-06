module Peripatetic
  class ApplicationRecord < ::ActiveRecord::Base
    self.abstract_class = true
    self.table_name_prefix = "peripatetic_"
    extend Geocoder::Model::ActiveRecord
  end
end
