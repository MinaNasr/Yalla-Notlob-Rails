class Friend < ApplicationRecord
    belongs_to :user
    # belongs_to :object, class_name: "${1/[[:alpha:]]+|(_)/(?1::\u)/g", foreign_key: "object_id"}
end
