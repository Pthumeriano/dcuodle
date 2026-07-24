require "test_helper"

class ResultsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "visitante não grava estatística" do
    post api_results_path, params: { attempts: 4, won: true }, as: :json
    assert_response :unauthorized
  end

  test "o resultado do dia é gravado uma vez só" do
    sign_in users(:member)

    assert_difference "GameResult.count", 1 do
      post api_results_path, params: { attempts: 4, won: true }, as: :json
    end
    assert_response :created

    # Segunda tentativa no mesmo dia não regrava para melhorar a estatística.
    assert_no_difference "GameResult.count" do
      post api_results_path, params: { attempts: 1, won: true }, as: :json
    end
    assert_response :conflict
  end
end
