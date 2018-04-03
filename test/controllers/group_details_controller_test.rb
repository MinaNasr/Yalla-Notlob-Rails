require 'test_helper'

class GroupDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_detail = group_details(:one)
  end

  test "should get index" do
    get group_details_url, as: :json
    assert_response :success
  end

  test "should create group_detail" do
    assert_difference('GroupDetail.count') do
      post group_details_url, params: { group_detail: { groupId: @group_detail.groupId, userId: @group_detail.userId } }, as: :json
    end

    assert_response 201
  end

  test "should show group_detail" do
    get group_detail_url(@group_detail), as: :json
    assert_response :success
  end

  test "should update group_detail" do
    patch group_detail_url(@group_detail), params: { group_detail: { groupId: @group_detail.groupId, userId: @group_detail.userId } }, as: :json
    assert_response 200
  end

  test "should destroy group_detail" do
    assert_difference('GroupDetail.count', -1) do
      delete group_detail_url(@group_detail), as: :json
    end

    assert_response 204
  end
end
