class Api::Users::CustomCommandsController < Api::ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :authenticate, only: [:update, :destroy]
  before_action :set_custom_command, only: [:update, :destroy]

  def update
    if @c_command.save
      render status: 200, json: {status: 200, message: "Custom command '#{params[:id]}' updated successfully."}
    else
      render status: 400, json: {status: 400, message: "Custom command '#{params[:id]}' failed to update."}
    end
  end

  def destroy
    if @c_command.destroy
      render status: 200, json: {status: 200, message: "Custom command '#{params[:id]}' destroyed."}
    else
      render status: 400, json: {status: 200, message: "Custom command '#{params[:id]}' could not be destroyed."}
    end
  end

  private

    def set_custom_command
      @c_command = Customcommand.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: 404, json: {status: 404, message: "Custom command with '#{params[:id]}' not found."}
    end
end
