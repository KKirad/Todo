class Api::V1::TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:update, :temporary_destroy]
  before_action :set_todo_list, only: :create
  before_action :set_unscope_todo_item, only: [:destroy, :restore]

  def create
    @todo_item = @todo_list.todo_items.new(todo_item_params)
    if @todo_item.save
      render json: success(@todo_item), status: :created
    else
      render json: error(@todo_item), status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      render json: success(@todo_item), status: :ok
    else
      render json: error(@todo_item), status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
    render json: :no_content
  end

  def temporary_destroy
    @todo_item.temporary_destroy
    render json: :no_content, status: :ok
  end

  def restore
    @todo_item.restore
    render json: :no_content, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    def set_unscope_todo_item
      @todo_item = TodoItem.unscoped.find(params[:id])
    end

    def set_todo_list
      @todo_list = TodoList.find(params[:todo_list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:content)
    end
end
