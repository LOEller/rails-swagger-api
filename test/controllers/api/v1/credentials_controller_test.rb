require "test_helper"

class Api::V1::CredentialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_credential = api_v1_credentials(:one)
  end

  test "should get index" do
    get api_v1_credentials_url, as: :json
    assert_response :success
  end

  test "should create api_v1_credential" do
    assert_difference('Api::V1::Credential.count') do
      post api_v1_credentials_url, params: { api_v1_credential: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show api_v1_credential" do
    get api_v1_credential_url(@api_v1_credential), as: :json
    assert_response :success
  end

  test "should update api_v1_credential" do
    patch api_v1_credential_url(@api_v1_credential), params: { api_v1_credential: {  } }, as: :json
    assert_response 200
  end

  test "should destroy api_v1_credential" do
    assert_difference('Api::V1::Credential.count', -1) do
      delete api_v1_credential_url(@api_v1_credential), as: :json
    end

    assert_response 204
  end
end
