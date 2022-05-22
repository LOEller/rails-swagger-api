class Api::V1::CredentialsController < ApplicationController
  before_action :set_credential, only: [:show, :update, :destroy]

  # GET /api/v1/credentials
  def index
    @credentials = Credential.all

    render json: @credentials
  end

  # GET /api/v1/credentials/1
  def show
    if @credential.nil?
      render json: "Credential not found", status: :not_found
    else
      render json: @credential
    end
  end

  # POST /api/v1/credentials
  def create
    @credential = Credential.new(credential_params)

    if @credential.save
      # weird namespaceing issue here...
      render json: @credential, status: :created, location: @api_v1_credential
    else
      render json: @credential.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/credentials/1
  def update
    if @credential.update(credential_params)
      render json: @credential
    else
      render json: @credential.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/credentials/1
  def destroy
    @credential.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credential
      @credential = Credential.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def credential_params
      params.fetch(:credential).permit(:username, :password, :env, :utility_id)
    end
end
