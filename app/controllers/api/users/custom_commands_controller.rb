class Api::Users::CustomCommandsController < Api::ApplicationController
  before_action :set_user, only: [:create, :destroy]
  before_action :authenticate, only: [:create, :destroy]
  before_action :set_custom_command, only: [:destroy]

  def create
    @c_com = CustomCommand.new(user_id: @user.id, on: params[:on], trigger: params[:trigger], admin: params[:admin], limit: params[:limit], output: params[:output])
    if @c_com.save
      render status: 200, json: {status: 200, custom_command: @c_com
      }
    else
      render status: 400, json: {status: 400, message: "Failed to create custom command."
      }
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
