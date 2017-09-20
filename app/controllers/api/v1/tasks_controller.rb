module Api
    module V1
        class TasksController < Api::V1::BaseController
            before_action :select_tasks, only: %i[index]

            def index
                render json: { tasks: ActiveModel::Serializer::CollectionSerializer.new(@tasks, each_serializer: TaskSerializer) }, status: 200
            end

            private

            def select_tasks
                @tasks = Task.order(id: :desc)
            end
        end
    end
end
