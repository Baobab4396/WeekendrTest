require "test_helper"

class WeekSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @week_schedule = week_schedules(:one)
  end

  test "should get index" do
    get week_schedules_url, as: :json
    assert_response :success
  end

  test "should create week_schedule" do
    assert_difference('WeekSchedule.count') do
      post week_schedules_url, params: { week_schedule: { schedule: @week_schedule.schedule, shop_name: @week_schedule.shop_name } }, as: :json
    end

    assert_response 201
  end

  test "should show week_schedule" do
    get week_schedule_url(@week_schedule), as: :json
    assert_response :success
  end

  test "should update week_schedule" do
    patch week_schedule_url(@week_schedule), params: { week_schedule: { schedule: @week_schedule.schedule, shop_name: @week_schedule.shop_name } }, as: :json
    assert_response 200
  end

  test "should destroy week_schedule" do
    assert_difference('WeekSchedule.count', -1) do
      delete week_schedule_url(@week_schedule), as: :json
    end

    assert_response 204
  end
end
