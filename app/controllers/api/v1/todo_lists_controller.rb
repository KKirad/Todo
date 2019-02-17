class Api::V1::TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:update, :temporary_destroy]
  before_action :set_unscope_todo_list, only: [:destroy, :restore]

  def index
    @todo_lists = params[:trash] ? TodoList.trash : TodoList.search(params[:title])
    meta = { total: @todo_lists.count }
    @todo_lists = @todo_lists.pagination(params[:page], params[:limit])
    render json: success(@todo_lists, meta), status: :ok
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      render json: success(@todo_list), status: :created
    else
      render json: error(@todo_list), status: :unprocessable_entity
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      render json: success(@todo_list), status: :ok
    else
      render json: error(@todo_list), status: :unprocessable_entity
    end
  end

  def destroy
    @todo_list.destroy
    render json: :no_content, status: :ok
  end

  def temporary_destroy
    @todo_list.temporary_destroy
    render json: :no_content, status: :ok
  end

  def restore
    @todo_list.restore
    render json: :no_content, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list
      @todo_list = TodoList.find(params[:id])
    end

    def set_unscope_todo_list
      @todo_list = TodoList.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_list_params
      params.require(:todo_list).permit(:title)
    end
end
