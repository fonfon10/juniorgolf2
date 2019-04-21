require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { category_id: @event.category_id, comments: @event.comments, course_id: @event.course_id, days: @event.days, gender_id: @event.gender_id, level_id: @event.level_id, name: @event.name, qual_required: @event.qual_required, reg_deadline: @event.reg_deadline, start_date: @event.start_date, tour_id: @event.tour_id } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { category_id: @event.category_id, comments: @event.comments, course_id: @event.course_id, days: @event.days, gender_id: @event.gender_id, level_id: @event.level_id, name: @event.name, qual_required: @event.qual_required, reg_deadline: @event.reg_deadline, start_date: @event.start_date, tour_id: @event.tour_id } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
