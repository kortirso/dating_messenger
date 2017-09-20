class TaskSerializer < ActiveModel::Serializer
    attributes :id, :url, :email, :profiles_count, :scrape_progress, :current_status
end
